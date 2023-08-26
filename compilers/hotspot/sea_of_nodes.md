# The Sea of Nodes and the HotSpot JIT

Notes on “The Sea of Nodes and the HotSpot JIT” by Cliff Click at Joker 2020.

[[video](https://www.youtube.com/watch?v=9epgZ-e6DUU)]

Sea of nodes
- Designed with emphasis on fast codegen and small IR size
- Always in SSA form, even in final code scheduling and register allocation
- Limited data in nodes
- Data and control use the same graph
- Data is decoupled from CFG and floats around

No basic blocks. Uses phis.

Has an embedded control flow graph.

Doesn't use a program dependence graph, as that would have been too many
experimental ideas.

## Edges

The control edge is the first and is nullable, since most operations don't use
it.

Nodes, that produce multiple outputs, need to label which result is carried on
that edge.

## Iter

Iter pass runs peephole in a fixpoint:

- Pull node from worklist
- Peephole, if possible
- Also check constant propagation, GVE, DCE
- If changed push neighbors on worklist
- Repeat

It is called by all parts of the compiler, after doing something major.

## Types

Every node has a type, even Control.

Based on lattices.

Type descriptions can get big. Types are immutable and hash-consed (interned),
then compared with pointer, rather than structural, equality. Most types hit in
hash-cons table.

## Unzipping

Null check unzipping: merging branches created by repeated null checks.

## Range check elimination

Rewatch when I'm ready to implement this.

## Safepoints

Breakpoints stop at the previous safepoint, then step with the interpreter.
