# ægraphs: Acyclic E-graphs for Efficient Optimization in a Production Compiler

Notes on “ægraphs: Acyclic E-graphs for Efficient Optimization in a Production
Compiler” by Chris Fallin at PLDI 2023 in the EGRAPHS workshop.

[[video](https://vimeo.com/843540328)]
[[conference](https://pldi23.sigplan.org/details/egraphs-2023-papers/2/-graphs-Acyclic-E-graphs-for-Efficient-Optimization-in-a-Production-Compiler)]

- Cranelift aims for as close to formally verified as practical
  - What formal techniques are used to verify Cranelift?
- Mentions [“A Catalogue of Optimizing Transformations”](https://www.clear.rice.edu/comp512/Lectures/Papers/1971-allen-catalog.pdf)
  (Fran Allen and John Cocke, 1971), which I should finally read.
- Optimizations mentioned:
  - GVN, constant folding, loop-invariant code motion
  - Alias analysis
    - When a node is replaced with another, it points to the first.
  - Redundant load elimination, store-to-load forwarding
- Cranelift uses a CFG of basic blocks with block parameters instead of phis
- High-level description of e-graphs: a sea of nodes representation with some
  “special properties”. Sounds like a great complement to a sea of nodes IR.
- Converting to e-graphs:
  - Cranelift converts the CFG to e-graphs, then back to a CFG.

## E-graph per basic block

The naïve approach is to use one e-graph per basic block, but that limits
rewrite scope and sharing/amortization and eliminates control optimizations.

## E-graph sea of nodes

Use one e-graph for the whole program or one per function.

Represent control flow as structured nodes, like an `if` node, in a nested tree
of regions. Like Graal's structured loops or Relooper.

Memory stores “somehow” need edges in the e-graph. ~ Sounds like what sea of
nodes already does!

Benefits:
- powerful optimizations
- strongly normalizing
- more compact IR
- cheaper analysis?

Downsides
- very different from CFG (conversion overheads)
- side-effects are tricky
- issues with irreducible control flow

If writing the compiler from scratch, he'd be more interested in taking a
regions-based approach.

Jamey Sharp's [optir](https://github.com/jameysharp/optir) prototype uses this
approach. It uses Regionalized Value State Dependency Graphs and e-graphs

### My reflection

Since my IR is sea of nodes in an arena, I already have the building blocks for
a whole-program e-graph representation. I think I could avoid a two-way
conversion between e-graphs and a CFG. `NodeTable` hashes my nodes for unique
insertion, so I could rework it to a hashcons structure to power the e-graph.

Perhaps I could make it work without structuring control flow. I've written
several irreducible programs, that I'd want to compile, so it would be valuable.
If the terminators are also nodes, the dependence could be used. Cyclic edges
might then be problematic… hinted at by the name “acyclic e-graphs”.

I think this approach would make optimizing across basic blocks easier. It could
recognize something like `if x < y { x } else { y }`, even when unstructured,
and rewrite it to `min(x, y)`.

With the load-store edges explicit, it may be able to subsume redundant load
elimination and store-to-load forwarding. Once the values of addresses are
optimized by the e-graph, it could more precisely determine which addresses are
aliasing.

## E-graph with CFG skeleton

Uses an e-graph scope for the whole function body, but keeps the CFG around.
Effectful operations, like memory stores, remain in the CFG and are ordered. CFG
nodes point into the e-graph, which contains the pure nodes. This sounds very
close to my current approach.

CFG skeleton contains:
- all blocks, with blockparams
- side-effecting operators
- block terminators

e-graph contains:
- blockparam values, as terminals
- all pure operators, without associated location

Benefits:
- cheap to convert to/from CFG, algorithmically and in implementation
- optimizations across function scope (mostly)

Downsides:
- harder to express rewrites that alter side-effects
- need special support for seeing through blockparams

### Elaboration

To lower the e-graph with CFG skeleton to a CFG (“elaboration”): …

His convention is to identify e-classes as `ec0`, `ec1`, …, `ecn`, and
elaborated SSA values as `v0`, `v1`, …, `vn`.

When moving an expression that is used by multiple, but not all, branches, to an
earlier point, such that it can be shared by all branches, it creates a “partial
redundancy”.

#### Dominance

A dominates B if all paths to B first pass through A. The immediate dominator is
the closest dominator, that dominates a given block. Dominance forms a tree.

SSA requires the invariant that a value's definition dominates its uses.

GVN: if an operator dominates a duplicate copy of itself, reuse the original.
Implemented with domtree pre-order traversal and a scoped map (pushing a scope
on pre-order, then popping the scope with its changes on post-order). This map
allows lookup of computations to get the SSA value and reuse.

What data structure is used for the scoped hash map? A persistent hash map like
Rust `im::HashMap`?

#### Scoped elaboration

Domtree pre-order traversal, building the same e-class-to-elaborated map, except
it's a scoped hash map.

Anything elaborated by a dominator is available for use in a child.

Subsumes:
- Scoped elaboration subsumes GVN.
- It also can subsume loop-invariant code motion by choosing to
  insert higher in the loopnest (which is computed earlier) and insert earlier
  in the scoped map.
- Rematerialization: choosing to duplicate anyways (e.g., to alleviate register
  pressure from retaining computations long-term). Cranelift does this for
  integer constants and adds with a single integer constant.

How would something like:

```ir
v3 = v1 + v2
v4 = v1 + v4 + v2
```

be optimized? It should be `v4 = v3 + v4`, but that requires commuting. The
e-graph, if saturated, would have found that, but how would it know that it
should extract that term, instead of an equivalent one? How is the cost
computed?

### Union nodes

E-graphs perform rewrites in a batch, then repair invariants. Fixup requires
backlinks (parent pointers) and re-interning, which are costly. Parent lists,
duplicated node storage, and parent list merging and deduping should be
eliminated. Instead, perform all rewrites eagerly.

Cycles occur in e-graphs, even if the original e-graph is acyclic (e.g., from
SSA). For example, x + 0 => x has a self-edge.

To solve this, æ-graphs don't join e-classes or rewrite a node and instead
represent e-classes as trees of union nodes. As the e-graph is built, track the
latest ID for a given value. Rewrite rules are invoked when a node is created
and only the final unioned ID is entered into the hashcons map.

### Combination of insights

Æ-graphs combine multiple insights:
- Eager rewriting
  - Enables persistence (otherwise uses don't pick up optimized refs)
- Persistent immutable data structure
  - Maintains acyclicity (creating a cycle requires mutable args)
- Acyclicity
  - Allows eager rewriting (otherwise, need to revisit and do fixpoint)

## E-graphs vs æ-graphs

egg-style e-graph: batched rewriting and repair
- Benefits:
  - strongly normalizing
  - supports arbitrarily cyclic input
- Downsides:
  - requires parent pointers and rehashing on fixup
  - repair step is a fixpoint

Æ-graphs: eager rewriting and immutable union nodes
- Benefits:
  - single-pass rewrite
  - no parent pointers (minimal memory and maintenance overhead)
- Downsides:
  - can miss rewrites (depending on rule structure)
  - cannot support cyclic input (e.g., see through phi nodes)

Would I still need parent pointers for other kinds of optimizations? If so, that
would negate some of the benefits of æ-graphs.

### Compromises

- More targeted rewrites
  - No catch-all commutativity or associativity rewrites like
    `(iadd a b) => (iadd b a)` or `(iadd a (iadd b c)) => (iadd (iadd a b) c)`.
  - Limited non-directional rewrites like
    `(bnot (band a b)) => (bor (bnot a) (bnot b))`, but only as a part of a
    strategy (e.g., to push `bnot`s downward to leaves). Only one direction.
- Acyclicity
  - Precludes rules that operate over blockparams (phis)

This is at least as powerful as traditional rewrites, but has solved phase
ordering and can make use of multi-version, cost-based extraction.

### Influences from e-graphs

Æ-graphs take several things from e-graphs:
- Rewriting: a powerful unifying paradigm for optimizations
- Multiple value representations: exploring all rewrite paths and resolving
  final values in a principled way with a cost function
- Sea-of-nodes IR for pure values: natural framework for code motion

## Performance

Most slowdowns come from instruction scheduling ([#6250](https://github.com/bytecodealliance/wasmtime/issues/6260))
or missing opt rules, such as magic div constants ([#6049](https://github.com/bytecodealliance/wasmtime/issues/6049)).

## Future

Instruction scheduler as an extraction pass
- The ISA instruction selector could be an extraction pass, that lowers directly
  from e-classes.
- This would have complex interactions, because scoped elaboration works
  forwards and instruction selection works backwards.

Optimization through blockparms (phis)
- Phis are currently terminals (opaque).
- This would enable sparse conditional constant propagation, unifying
  branch-folding and constant-propagation.
- The challenge is dealing with cycles. It could be partially addressed by
  limiting analysis to forms that operate in a single pass, such as skipping
  back-edges.

Non-greedy instruction selection
- Optimal extraction depends on elaboration, but extraction is currently done
  before elaboration. Multiple uses of a value can share its cost and if another
  inst needs an expensive value, it becomes sunk cost.

Fused and unrolled rewrites
- They have efficient rule dispatch from a decision tree, but it can only
  perform one step at a time.
- Perhaps a path of rewrites could be statically unrolled or insertion of
  intermediates could be elided, if they're know to be bad (more expensive or
  always subsumed).

Instruction scheduling
- The æ-graph discards location information and scoped elaboration recomputes
  it.
- The as-late-as-possible schedule is often quite bad.
- Perhaps it could use heuristics from register pressure or the original code
  order.

## Work with Cranelift

They mentor students and collaborate with researchers.
