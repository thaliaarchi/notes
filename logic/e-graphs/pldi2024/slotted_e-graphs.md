# Slotted E-Graphs

Rudi Schneider (TU Berlin), Thomas Kœhler (INRIA), [Michel Steuwer](https://michel.steuwer.info/)
(TU Berlin)

[[conference details](https://pldi24.sigplan.org/details/egraphs-2024-papers/10/Slotted-E-Graphs)]
[[video](https://www.youtube.com/watch?v=4Cg365LVbYg&list=PLyrlk8Xaylp4UHRXP0VkuYen9nkn4bczW&index=12)]
[[live video (at 02:04:54)](https://www.youtube.com/watch?v=JPA8QwLHNzo&t=7494s)]
[[paper](https://michel.steuwer.info/files/publications/2024/EGRAPHS-2024.pdf)]
[[implementation](https://github.com/memoryleak47/egraph-sandbox/tree/main/3-miniegg-with-slots)]

An approach for representing bound variables in e-graphs. In their slotted
e-graph, e-classes are parameterized by slots abstracting over all free
variables.

Why not use de Bruijn levels? Then the example given for de Bruijn indices
doesn't have the same sharing problem:

- With de Bruijn indices: λ. (λ. f(%1) %0) arg ==>(beta-reduction) λ. f(%0) arg
- With de Bruijn levels:  λ. (λ. f(%0) %1) arg ==>(beta-reduction) λ. f(%0) arg

However, adding or removing binders still breaks sharing.

**Key idea**: unify e-nodes that are equivalent up to renaming of variables into
an e-class which is parameterized by its variable names.

Example: `f(x, y)` and `f(x', y')` have no sharing in conventional e-graphs.
With slotted e-graphs, this uses a variable node, `v` with a slot for the
binding. Then, the two calls instantiate `v` with their bindings:
`f(v[x], v[y])` and `f(v[x'], v[y'])`. Then, those two nodes are unified as,
say, `n[a, b] = f(v[a], v[b])`. (Brackets are my notation. The visual graphs
have a header to declare the slots and edges instantiate slots at the user end
of the line.)

Conventional e-class: set of equivalent terms.

Slotted e-class: function from variable names to a set of equivalent terms.

**Challenge 1: Parameter mismatch.** When an e-class has a node which depends on
a variable and a node which doesn't, their implementation says the e-class
doesn't depend on a variable. For example, x * 0 depends on x and 0 doesn't.

**Challenge 2: Symmetry.** Merging a + b with b + a is merging the same node
with itself. To make it symmetric, e-classes depend on a *set* of parameter
lists. In that case, {(a, b), (b, a)}. If you call it with any of them, it's the
same. That parameter set list can be represented nicely as a permutation group.

## Follow-up

Parameter mismatch and symmetry could be handled by the same mechanism. As
described in the talk, x * 0 has signature (x) and 0 has signature (), so when
unified, the e-class has signature (). Instead of deleting a variable, the
signatures are simply unioned in a set: {(), (x)}. This also works with
symmetry.

As an example, suppose you start with the expression:
(x + y) * 0

and rules:
- x * 0 ==> 0
- x + y ==> y + x
- (x + y) * z ==> (x * z) + (y * z)

Applying rewrites would yield the e-class of:
- {0, 0 + 0} with signature ()
- {(x * 0) + 0} with signature (x)
- {0 + (y * 0)} with signature (y)
- {(x + y) * 0, (x * 0) + (y * 0}} with signature (x, y)
- {(y + x) * 0} with signature (y, x)

In this model, each e-class is partitioned by the unique signatures.
var-classes?

What about permutation groups? Would that then need to be expanded instead of
compactly represented (or however they do it)?
