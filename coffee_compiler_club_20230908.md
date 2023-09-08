# Coffee Compiler Club 2023-09-08

- Thoughts on node arenas
  - Did HotSpot just use dynamically allocated node instance?

- Source tracking in IR
  - Approaches I can think of:
    - Tree of span nodes depending on graph of IR nodes
    - Annotating IR node (issue with imprecision when coalescing nodes)
    - No source tracking in IR

- Does a sea of nodes IR compromise on generated code quality? Sea of nodes
  was invented for HotSpot with an emphasis on fast codegen, so I’ve been
  wondering if there’s some implication of compromise there compared to a more
  traditional basic-block-oriented IR in an AoT compiler.

- If you were architecting a compiler from scratch, without fossilized decisions
  from existing code, what design decisions would you want to make?

- In your sea of nodes talk, you said you didn't use a program dependence graph,
  because it was too new at the time and it would have been too many
  experimental ideas, and instead embedded a control flow graph. Would you do
  any of that differently?

- Why doesn't HotSpot use a DSL for peephole rewrites?
