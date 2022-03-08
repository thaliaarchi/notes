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
  - Resources
    - Tools
      - LLVM library recommendations for various languages
      - llvmenv: https://github.com/llvmenv/llvmenv
    - LLVM tutorials
      - Pull that list from LLVM Weekly
      - Contributing to LLVM
    - LLVM Weekly
    - LangRef
    - Compiler Explorer
- Alternatives
  - Compilers
    - GCC - motivate LLVM design decisions
    - QBE: https://c9x.me/compile/
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
