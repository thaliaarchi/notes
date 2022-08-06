# Nebula 2 architecture plan

Nebula 2 is a compiler framework for inter-language compilation using a
dynamically-registered mixed-dialect intermediate representation.

The project is very early in development, but the aspirational architecture plan
is as follows:

## Architecture

### Language API

A language can be defined with Nebula APIs and has

### Mixed-dialect IR

A language can be defined and dynamically registered with its own syntax(es),
including accurate location tracking in all phases; intermediate language
dialect(s); and incremental transformation passes between arbitrary dialects.
Most languages will be able to serve as a frontend or a backend, using
incremental transformations that lower to or raise from common dialects.

Dialects decouple control flow, data flow, and memory models, to support diverse
representations. The core data flow dialects will include an SSA-based IR, that
uses basic block parameters, and a typed stack-oriented IR. Control flow
dialects will include unstructured with jumps and structured with functions and
loops. There will also be eager values and lazy thunk expressions, as well as
arbitrary-precision integer types, with a data flow analysis to constrain bit
widths.

The dynamic registration allows languages to be defined modularly in independent
projects and for library components to be reused by multiple tools, including
external tools. The toolchain will include a static compiler and a language
server.

### Incremental computation

I intend to use incremental computation via [Salsa](https://github.com/salsa-rs/salsa),
as [used](https://rustc-dev-guide.rust-lang.org/salsa.html) by rust-analyzer, or
[Adapton](https://github.com/Adapton/adapton.rust) ([notes](https://github.com/andrewarchi/compiler-notes/tree/main/adapton)),
once I have a working pipeline.

### Inspiration

It takes inspiration from many projects and concepts: MLIR for dialect mixing
and registration; GraalVM for its polyglot API with high-level mixed-language
interoperability and its sea of nodes IR with loose node ordering; LLVM for its
library design and SSA-based IR; the SSA form variant in used in MLIR and
WebAssembly, that uses basic block parameters instead of phi functions; and by
Futamura projections for powerful partial evaluation.

Whitespace is a nice starting point, because its jump-oriented control flow
resembles a minimal LLVM IR, which can be expanded as a general IR with features
added as needed, until it’s 1:1 with LLVM IR.

Factor (for quotations, i.e., closures) and Kitten (for static stack types)

## Goals

### Whitespace

It aims to bring excellent tooling to Whitespace, with planned components
including an optimizing compiler, modular intermediate language, interpreter,
and language server.

before 1 April 2023, the 20th anniversary of the Whitespace 0.2 [public release](https://web.archive.org/web/20150717220656/http://compsoc.dur.ac.uk:80/whitespace/explanation.php).

## Current features

### Languages

- Whitespace
  - Supported supersets: GrassMudHorse
- Brainfuck
  - Supported supersets: Ook! and Spoon
