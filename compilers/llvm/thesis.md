# LLVM M.S. thesis

[*LLVM: An Infrastructure for Multi-Stage Optimization*](https://llvm.org/pubs/2002-12-LattnerMSThesis.html)
Chris Lattner, M.S. thesis, 2002

## Abstract

- High-level type information, low-level instructions
- Multi-stage optimizations
- Run-time profiling and optimization and idle-time reoptimization are barely
  emphasized onw with LLVM

## Table of contents

- What did LLVM have back then?
  - Multi-stage optimizations at compile, link, run, and idle time
  - LLVM IR (then called the LLVM virtual instruction set) in SSA form
    three-address code
  - Type-safe pointer arithmetic with `getelementptr`
  - Function calls and exception handling
  - Plaintext, bytecode, and in-memory representations
  - Optimizations

## Introduction

- Why did LLVM switch from a VM model to emphasizing static compilation?
  - Does the modern LLVM JIT still do reoptimization?
- Optimized native executables included a copy of the bytecode for later
  optimization. The program gathers profile information, which is recorded to
  disk. At idle-time, when resource usage is low, an offline reoptimizer
  performs aggressive PGO on the program, equivalent in power to the link-time
  optimizer, but with accurate profiles.
- The thesis contributes:
  - That aggressive interprocedural optimization can be performed on a low-level
    representation, provided it has high-level types
  - A practical implementation, that is a drop-in replacement
    - What does it specifically aim to replace? GCC?

## LLVM System Architecture

- The runtime optimizer optimizes the generated native code, by referencing the
  high-level dataflow and type information in the bytecode
- The idle-time reoptimizer optimizes from the bytecode

## LLVM Virtual Instruction Set

- Instructions are polymorphic, not requiring different opcodes for separate
  types
  - This was later loosened a bit and floating-point ops were split out
- SSA form is defined as all uses being dominated by the definition; does this
  mean graph IRs like sea of nodes are not in SSA form, since nodes aren't
  scheduled?
- Phis must be placed at the beginning of a basic block. I think this was
  loosened later.
- Integer types only had widths 8, 16, 32, and 64, using the C type names.
- A program is considered type-safe if no unsafe casts are used, that is,
  casting to a pointer type
- `malloc`/`free` manage heap-allocated memory and `alloca` allocates stack
  memory. I don't think `malloc`/`free` are in modern LLVM IR.
- Exception handling is implemented with `invoke`.

## Optimizations with LLVM

- Traditional SSA-based optimizations:
  - Simple and aggressive dead code elimination
  - Global common subexpression elimination
  - Induction variable simplification
  - Loop invariant code motion
  - Expression reassociation
  - Simple constant propagation
  - Sparse conditional constant propagation
  - Value numbering
- CFG-based optimizations and analyses:
  - Critical edge elimination
  - Various forms of dominator information
  - Interval construction
  - Natural loop construction
  - Loop pre-header insertion
  - CFG simplification
- Interprocedural analyses and transformations:
  - Call graph construction
  - Various alias analyses
  - Global constant merging
  - Type safety analysis
  - Dead global elimination (both global variables and functions)
  - Inlining
- Instruction combine (instcombine) performs peepholes and is fast
- The level raise pass takes poorly-typed programs and recovers type information
  from debug information in function signatures, to enable retargeting existing
  compilers to work with LLVM.
- Novel data structure analysis
- Automatic pool allocation allocates same-sized values in a pool, when the
  lifetimes do not escape the function they were created in, then frees the pool
  on function exit. Used, for example, for linked lists.

## Related work

- LLVM IR is less ambitious than previous attempts to created a unified, generic
  IR, in that it implements low-level features that any language can be lowered
  to, instead of implementing features from all possible source languages at the
  AST level.
