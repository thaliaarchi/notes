# LLVM Presentation Topic Plan

- SSA form
  - Alternates to using phis
    - MLIR and Wasm block parameters
    - CPS equivalence (skip)
  - Alternatives for scheduling
    - Graal sea of nodes
  - Examples: loops, procedures, branches
  - Dominance
  - Benefits for opts
  - mem2reg
- LLVM architecture
  - Opcodes
  - Tiered architecture
    - Frontends
      - ASTs: Clang
      - Language IRs: Rust HIR and MIR, Swift SIL, Flang FIR,
        Whitespace, etc.
      - General IRs: GIMPLE
    - Middle end: LLVM IR
    - Backends
- How to use LLVM in your own compiler
  - LLVM Kaleidoscope tutorial with Rust Inkwell bindings
  - [Resources](resources.md)
- Alternatives
  - Compilers
    - GCC: motivate LLVM design decisions
    - [QBE](../qbe.md)
  - Futamura (blow minds)
    - GraalVM Truffle
    - PyPy (is it extensible?)
  - Tradeoffs vs LLVM

## Day 1: 2022-03-08

- Tiered compiler architecture
- LLVM intermediate representation
  - Static single-assignment form
  - Instructions
  - Type information

## Day 2: 2022-03-10

- Compiler for Kaleidoscope
  - Kaleidoscope syntax: fib, mandelbrot
  - Lexing, parsing
    - Algebraic data types: Rust/OCaml vs C++
      - [C++ virtual classes](https://releases.llvm.org/13.0.1/docs/tutorial/MyFirstLanguageFrontend/LangImpl03.html)
    - Parser combinators: nom's JSON example
  - Lowering
    - Builder API
      - [Simple example with Go](https://blog.gopheracademy.com/advent-2018/llvm-ir-and-go/#output-example-producing-llvm-ir)
    - [Control flow and SSA](https://mapping-high-level-constructs-to-llvm-ir.readthedocs.io/en/latest/control-structures/if-then-else.html)
    - [Mapping constructs to LLVM IR](https://mapping-high-level-constructs-to-llvm-ir.readthedocs.io/en/latest/README.html)
      - Object-oriented
        - Classes
        - Virtual methods
        - Single inheritance
        - Virtual inheritance
        - Interfaces
        - Boxing and unboxing
        - Class equivalence test
        - Class inheritance test
        - The new operator
      - Exception handling: covered on day 1
      - Advanced/functional
        - Lambda functions
        - Generators
  - Inkwell JIT example
- LLVM API
  - Safety, e.g., [Value](https://llvm.org/doxygen/classllvm_1_1Value.html)
- [API bindings](libraries.md)
