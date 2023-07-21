# Post-undergrad projects

- CS 4410: Compiler Design (1–2 weeks)
- Nand to Tetris (1–2 weeks)
- Dependent types:
  - Simply Easy (1 week)
  - Eightfold interpreter (1/2 week)
  - Idris (3 weeks)
  - *Software Foundations* (interspersed)
  - Design my perfect language
- Compiler front-end:
  - Design language to compile to esolangs
  - wspace-syntax
    - Assembly dialects
    - Languages: HaPyLi, Nospace
  - Advent of Code (interspersed)
- Compiler middle-end
  - [GRIN](https://grin-compiler.github.io/)
- Compiler back-end and runtime:
  - *Crafting Interpreters*
  - *Hacker's Delight*
  - Build Whitespace runtime with GMP and a GC (e.g., [Boehm GC](https://en.wikipedia.org/wiki/Boehm_garbage_collector))

## Tutorial projects

- [Nand to Tetris](https://www.nand2tetris.org/)
- Northeastern [CS 4410: Compiler Design](https://course.ccs.neu.edu/cs4410/)
- *Software Foundations*
  - To start: Merge my SF work from as a student and TA, to use as a base.
  - *Logical Foundations* (7/17 chapters remaining)
  - *Programming Language Foundations* (14/16 chapters remaining)
  - *Verified Functional Algorithms* (16 chapters)
  - *QuickChick: Property-Based Testing in Coq* (4/5 chapters remaining)
  - *Verifiable C* (19 chapters)
  - *Separation Logic Foundations* (13 chapters)

## Books

- *Crafting Interpreters*
- *Hacker's Delight*
- [*The Rustonomicon*](https://doc.rust-lang.org/nomicon/)
- *Compilers: Principles, Techniques, and Tools*

## Implementing papers

- Type systems
  - Dependent types
    - [“A Tutorial Implementation of a Dependently Typed Lambda Calculus”](https://www.andres-loeh.de/LambdaPi/)
      and [“How to Keep Lambda Calculus Simple”](https://hirrolot.github.io/posts/how-to-keep-lambda-calculus-simple.html)
      [[HN](https://news.ycombinator.com/item?id=36645356)]
  - [“Bidirectional Typing”](https://arxiv.org/pdf/1908.05839.pdf)
- Logic programming
  - [miniKanren](http://minikanren.org/) and microKanren
  - [E-graphs](../topics/e-graphs.md)
  - [BDDs](../topics/bdds.md)
- Adaptive programming
  - Adapton and [miniAdapton](https://arxiv.org/pdf/1609.05337.pdf)
- Partial evaluation
  - Futamura projections
  - “Collapsing Towers of Interpreters” and “Lightweight Modular Staging”
- Regular expressions
  - Brzozowski derivatives
  - [“Proof-directed program transformation: A functional account of efficient
    regular expression matching”](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/454BB5CD9B0B056FA91957F2F9CC3EC5/S0956796820000295a.pdf)
- Category theory
- Data-codata duality

See the papers chosen for [CS 630](https://faculty.cs.byu.edu/~kimball/630/Schedule.html)

## Lectures

- [Oregon Programming Languages Summer School](https://www.cs.uoregon.edu/research/summerschool/)

## Learning languages

- [Idris](../pl/langs/idris/learning_idris.md)
  - *Type-Driven Development with Idris*
  - Build a [Whitespace backend for Idris](../wspace/back/idris_backend.md)
- Concatenative
  - Chuck Moore's languages, like colorForth and Machine Forth
  - High-level languages, like Kitten, Factor, and Joy
- Esolangs
  - 2-dimensional: Aheui, Befunge, Funciton, Piet
  - Automata: Game of Life
  - Bitstrings: Bitwise Cyclic Tag
  - Challenging: Malbolge
  - Dependent types: Eightfold
  - Metacircular: Emmental
  - Object-oriented: Glass
  - Rewriting: Cratylus, [Fractran](https://raganwald.com/2020/05/03/fractran.html),
    ///, Thue
  - Single-instruction: Subleq
  - Trees: Leaf
  - µ-recursive functions: Myopia

## Challenges

- Advent of Code
  - Implement challenges in a language of my design
