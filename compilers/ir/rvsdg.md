# RVSDG

Uses state edges.

Ports are structural! That's why it would work with e-graphs! That is, you can
consider a sub-graph on its own and the ports are just opaque.

Theta nodes are loops and gamma nodes are branches. Edges (“ports”) are not
connected between nodes, but instead to regions. Each region has a matching
number of input and output variables. The input variables are like BB params in
SSA IRs.

Nodes are nested structurally. This allows you to optimize each node as a
self-contained unit, recursively, which is crucial for rewrites with an e-graph.

## Compiling

Region arguments and results remind me of my approach since Nebula of modeling
an abstract stack for Whitespace or abstract memory for Brainfuck. (A better
name could be stack view or memory view.) With an RVSDG, loops in Brainfuck with
balanced shifts and loops in Whitespace with balanced pushes and pops can be
transformed to a gamma node, which first loads from memory/the stack, then a
theta node in terms of those variables, then stores.

I/O nodes don't need IDs to distinguish them, because they have state edges.

With hash-consing, identical loops would have regions with the same ID, but
their theta nodes have potentially differing inputs, which would distinguish
them. Since regions don't have inputs or outputs (instead arguments and
results), should they be part of a node arena?
