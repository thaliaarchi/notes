# Posters

## Quickly Finding RISC-V Code Quality Issues with Differential Analysis

Luís Marques (lowRISC)

[[poster](https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/poster.pdf)],
[[code](https://github.com/lowRISC/longfruit)]

RISC-V still has cases of bad code generation, so LongFruit is a tool
that performs differential analysis of code generated with gcc and
Clang. Codegen is scored simply by the types of instructions used,
weighted by complexity. It finds candidate issues and reduces them.

## llvm-diva: Debug Information Visual Analyzer

Phillip Power (Sony)

[[poster](https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/llvm_diva_Poster.pdf)],
[[RFC](https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/llvm_diva_RFC_DebugInformationVisualAnalyzer.pdf)]

llvm-diva processes various formats of debugging information contained
in binary files and presents a high-level logical view of the
information. Logical views can be compared between different toolchains
and formats.

With llvm-diva, we aim to address the following points:

- Which variables are dropped due to optimization?
- Why I can’t stop at a particular line?
- Which lines are associated to a specific code range?
- Does the debug information represent the original source?
- What are the semantic differences between different toolchain versions?

## Enzyme: High-Performance Automatic Differentiation of LLVM

William Moses, Valentin Churavy (MIT)

[[poster](https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/Enzyme_llvmdev.pdf)]

Applying differentiable programming techniques and machine learning
algorithms to foreign programs requires developers to either rewrite
their code in a machine learning framework, or otherwise provide
derivatives of the foreign code. This paper presents Enzyme, a
high-performance automatic differentiation (AD) compiler plugin for the
LLVM compiler framework capable of synthesizing gradients of statically
analyzable programs expressed in the LLVM intermediate representation
(IR). Enzyme can synthesize gradients for programs written in any
language whose compiler targets LLVM IR including C, C++, Fortran,
Julia, Rust, Swift, MLIR, etc., thereby providing native AD capabilities
in these languages. Unlike traditional source-to-source and
operator-overloading tools, Enzyme performs AD on optimized IR. On a
machine-learning focused benchmark suite including Microsoft's ADBench,
AD on optimized IR achieves a geometric mean speedup of 4.5x over AD on
IR before optimization allowing Enzyme to achieve state-of-the-art
performance. Packaging Enzyme for PyTorch and TensorFlow provides
convenient access to gradients of foreign code with state-of-the art
performance, enabling foreign code to be directly incorporated into
existing machine learning workflows.

Has a type analyzer that determines more precise types. For example, it
refines `void *` in `memcpy` to a more accurate type. It is also capable
of handling packed pointers that are manipulated with bitwise
operations.
