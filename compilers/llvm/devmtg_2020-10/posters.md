# Posters

## Quickly Finding RISC-V Code Quality Issues with Differential Analysis

Luís Marques (lowRISC)

- https://whova.com/portal/webapp/llvm_202010/Exhibitors/105336
- https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/poster.pdf
- https://github.com/lowRISC/longfruit

RISC-V still has cases of bad code generation, so LongFruit is a tool
that performs differential analysis of code generated with gcc and
Clang. Codegen is scored simply by the types of instructions used,
weighted by complexity. It finds candidate issues and reduces them.

## llvm-diva - Debug Information Visual Analyzer

Phillip Power (Sony)

- https://whova.com/portal/webapp/llvm_202010/Exhibitors/105335
- https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/llvm_diva_Poster.pdf
- https://d1keuthy5s86c8.cloudfront.net/static/ems/upload/files/llvm_diva_RFC_DebugInformationVisualAnalyzer.pdf

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
