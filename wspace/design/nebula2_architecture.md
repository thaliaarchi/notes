# Nebula 2 architecture plan

Nebula 2 is a library-oriented compiler with a dynamically-registered
mixed-dialect IR.

The project is very early in development, but the aspirational architecture plan
is as follows:

## Aspirational architecture

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

I intend to use incremental computation via [Salsa](https://github.com/salsa-rs/salsa),
as [used](https://rustc-dev-guide.rust-lang.org/salsa.html) by rust-analyzer, or
[Adapton](https://github.com/Adapton/adapton.rust) ([notes](https://github.com/andrewarchi/compiler-notes/tree/main/adapton)),
once I have a complete pipeline.

It takes inspiration from many projects and concepts: MLIR for dialect mixing
and registration; GraalVM for its polyglot API with high-level mixed-language
interoperability and its sea of nodes IR with loose node ordering; LLVM for its
library design and SSA-based IR; the SSA form variant in used in MLIR and
WebAssembly, that uses basic block parameters instead of phi functions; and
Futamura projections for powerful partial evaluation.

As I've been thinking about the kinds of programs I want to write, I've been
formulating ideas for languages that I would design in tandem. One would be
concatenate with quotations (closures) like Factor and a statically-typed stack
like Kitten.

## Philosophy

I've been developing it forwards with small instruction sets, similar to the
Nanopass philosophy, except I am compiling complete small languages that have
shared features, rather than building up subsets of one language. I've started
with Whitespace, of course, which I consider to be a nice starting point, since
its jump-oriented control flow resembles a minimal LLVM IR, which I can expand
into a general IR with features added as needed, until it approaches parity with
LLVM IR. By writing transformations between structured and unstructured control
flow, I could eventually use LLVM IR as both a back end and a front end.
