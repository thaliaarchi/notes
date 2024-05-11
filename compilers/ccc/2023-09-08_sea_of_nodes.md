# Coffee Compiler Club 2023-09-08 on Sea of Nodes

[Recording](https://www.youtube.com/watch?v=NDkMhB0xQwU)

## Questions

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

## Discussion

Cliff and others are working on a sea of nodes book; see “sea of nodes project
idea thread” in the chat.

There was a CCC meeting a few months ago with Chris Lattner involved, but it may
not have given the topic full justice.

PDG
- Sea of Nodes has a real CFG embedded
  - classic, needs to be graphed
  - PDG removes that, free-floating independent chunks of code that don't
    serialize easily
  - PDG: loop-invariant test

Sea of Nodes gets rid of a lot of the pass-scheduling problems like in GCC.

Darrick Wiebe only cares a little about the compiler executing quickly. He's
doing SoN stuff

Church-Rosser one-step property

In C2, inlining is first

When a loop never exits, Cliff would add a “never” exit, and a max count. Not
interesting for inlining.

Classic IR to Sea of Nodes paper:
[“From Quads to Graphs: An Intermediate Representation's Journey”](https://www.dropbox.com/s/aeb20g2ltueglsv/1993_From_Quads_to_Graphs_An_Intermediate_Representatio.pdf?dl=0)
(Cliff Click, 1997)

SoN allowed a simpler, more perfect design. Phases disappear.

Cliff learned how to do it at PhD and made it fast at Sun.

SeaOfNodes.odp
1. start with quads
2. alpha renaming, using pointers to nodes instead of names, then basically have
   nodes

GCC didn't assume that the graph would fit in memory, so it's written to disk.
HotSpot assumes it all fits into memory.
