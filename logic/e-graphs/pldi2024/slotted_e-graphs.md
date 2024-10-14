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

Why not use de Bruijn levels? Then β-reduction the example given for de Bruijn
indices doesn't have the same sharing problem:

β-reduction: (λx. M) N ==> M[x := N]
- λ. (λ. f(%1) %0) arg ==> λ. f(%0) arg (de Bruijn indices)
- λ. (λ. f(%0) %1) arg ==> λ. f(%0) arg (de Bruijn levels)

η-reduction: λx. M x ==> M when M does not contain x free
- λ. f(%0) %0 ==> f (both)

η-expansion: M ==> λx. M x
- λ. f(%0) ==> λ. ((λ. f(%1)) %0) (de Bruijn indices)
- λ. f(%0) ==> λ. ((λ. f(%0)) %1) (de Bruijn levels)

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

(Question [asked](https://egraphs.zulipchat.com/#narrow/stream/328977-topic.2Ftheory/topic/Slotted.20E-graphs)
on Zulip.)

Parameter mismatch and symmetry could be handled by the same mechanism. As
described in the talk, x * 0 has signature (x) and 0 has signature (), so when
unified, the e-class has signature (). Instead of deleting a variable, the
signatures could be unioned in a set: {(), (x)}. This also works with symmetry.

As an example, suppose you start with the expression:
(x + y) * 0

and rules:
- ?x * 0 ==> 0
- ?x + ?y ==> ?y + ?x
- (?x + ?y) * ?z ==> (?x * ?z) + (?y * ?z)

Applying rewrites would yield the e-class of:
- {0, 0 + 0} with signature {()}
- {(a * 0) + 0, 0 + (a * 0)} with signatures {(x), (y)}
- {(a + b) * 0, (a * 0) + (b * 0}} with signatures {(x, y), (y, x)}

In this model, each e-class is partitioned by the unique signatures. Let's
tentatively call them var-classes. e-nodes then point to var-classes with
instantiations instead of e-classes.

What about permutation groups? Would that then need to be expanded instead of
compactly represented (or however they do it)?

What about types? Do var-classes need to be partitioned by sorts in addition to
arity? Is it possible for a rewrite to map a binding to another type? I don't
think so, so `var` nodes should be strongly typed.
