# RVSDG

Uses state edges.

Ports are structural! That's why it would work with e-graphs! That is, you can
consider a sub-graph on its own and the ports are just opaque.

This reminds me of my approach since Nebula of modeling an abstract stack for
Whitespace or abstract memory for Brainfuck. (A better name could be stack view
or memory view.)

Theta nodes are loops and gamma nodes are branches. Edges (“ports”) are not
connected between nodes, but instead to regions. Each region has a matching
number of input and output variables. The input variables are like BB params in
SSA IRs.

Nodes are nested structurally. This allows you to optimize each node as a
self-contained unit, recursively, which is crucial for rewrites with an e-graph.
