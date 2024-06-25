# Control and data edges in IRs

I've been thinking about characterizations of various IRs and their tradeoffs,
particularly the direction of edges.

## Characteristics

These characteristics affect the edge direction:

- Control flow
  - Basic block terminators: forwards CFG
  - Structured control flow: forwards CFG
  - Sea of Nodes control inputs: reverse CFG
- Data flow
  - Value uses / Sea of Nodes data inputs: reverse DFG
  - Phi nodes: reverse DFG
  - Basic block parameters: forwards DFG

## IRs

- LLVM uses basic blocks with linear instructions inside. Basic block
  terminators form the CFG in a forwards direction. Value uses and phis form the
  DFG in a reverse direction. (Forwards CFG, reverse DFG.)

- MLIR is similar, but dialects can use structured or unstructured control flow.
  Nodes can contain blocks (MLIR calls them regions), so some reverse CFG edges
  are implicit from the structure (e.g., `affine.for`), but other nodes use
  LLVM-style terminators. Basic blocks have parameters, not phis (even in the
  LLVM dialect). (Forwards CFG, hybrid DFG.)

- Cranelift uses a CFG “skeleton” and an e-graph of pure nodes. The CFG is basic
  blocks of only the effecting nodes, which use pure nodes in the e-graph. Basic
  blocks have parameters, not phis parameters. (Forwards CFG, hybrid DFG.)

- HotSpot stores all relationships in a graph as inputs to nodes and uses phi
  nodes (reverse CFG and DFG). All nodes inherit from `Node`, which stores all
  inputs in one list and all outputs in another list.

- Simple is very similar to HotSpot. Inputs are almost always accessed by magic
  indices (so essentially equivalent to discrete methods).

- Graal likewise stores all relationships in a graph as inputs to nodes and uses
  phi nodes (reverse CFG and DFG), but inputs are in discrete properties and
  accessed with methods. Inputs are also annotated with `@Input` or
  `@OptionalInput`, but it seems they're never iterated except in
  `GraphNodeVerifier`. Uses structured control flow.
