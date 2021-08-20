Here's the page of LLVM tutorials, including building a Kaleidoscope
language front end using C++ and LLVM
https://llvm.org/docs/tutorial/index.html

Here is the LLVM IR language documentation:
https://llvm.org/docs/LangRef.html

Here is the Kaleidoscope tutorial in OCaml:
https://releases.llvm.org/12.0.1/docs/tutorial/OCamlLangImpl1.html

LLVM provides C++ bindings for its APIs, as well as C bindings that wrap
those and are more commonly used with other languages. There are
official OCaml, Go, and Python bindings in-tree at
https://github.com/llvm/llvm-project/tree/main/llvm/bindings that use
these C bindings.

The Go bindings are little more than just a direct mapping to the C API,
so it doesn't take advantage of extra guarantees from the Go type system
and is not particularly idiomatic Go, but it gets the job done. I used
these bindings for Nebula and would pick a different bindings library
next time (https://github.com/andrewarchi/nebula).

A large pain for me was building LLVM and linking with my project. I
plan to use llvmenv so that my compiler will be hopefully easier to
build for myself and others: https://github.com/llvmenv/llvmenv. There's
an open PR for using Homebrew LLVM installations that looks
ready-to-use, if you're on macOS:
https://github.com/llvmenv/llvmenv/pull/109.

I'm in the early phases of of building a compiler in Rust using LLVM.
I'm using Inkwell, a Rust library that exposes LLVM through a safe Rust
interface. The LLVM bindings have many methods that are only allowed for
certain subtypes, but still exist on the supertypes, so Inkwell makes it
so you can only use LLVM safely.

I don't know how much of the infrastructure you want to handle yourself.
You could do it like Clang where you have just an AST, a few
optimizations on that, then lower to LLVM IR using memory load/stores.
That leaves the difficulty of converting to valid SSA form to LLVM with
its mem2reg pass.

Or there's Swift that has its own IR: SIL (Swift Intermediate Language).
Or Rust with HIR (High-level IR) and MIR (Mid-level IR). That gives more
language-specific optimization capabilities. For example, it could
choose to model operations on a vector type and would know that
`v.push(x); v.pop()` is a nop and can just be removed; something that is
very difficult for LLVM IR to optimize away because it doesn't encode
those semantics.

Or there's like MLIR (Multi-level IR), a sub-project of LLVM: it has
many dialects that coexist and are incrementally lowered (nanopass
sounds like this). Keynote on MLIR and IR design:
https://www.youtube.com/watch?v=qzljG6DKgic,
https://llvm.org/devmtg/2019-04/slides/Keynote-ShpeismanLattner-MLIR.pdf

In my case, I'm very interested in IR design and building middle-end
optimizations, so I'm building my own IR in SSA form with
language-specific optimizations that lowers to LLVM IR. If you don't
care about building an IR, just make your front end lower directly from
your AST to memory load/store-style LLVM IR like Clang or the
Kaleidoscope tutorial. My guess is that you're probably more interested
in the language design than optimizations, so that might be a good fit.

If you don't want to use LLVM, here's some other options:

GraalVM is a Java JIT written in Java that can ATO compile to binaries
using its Native Image feature. Language front ends are easy to write
using the Truffle framework, which allows for powerful polyglot
programming and the compiler can optimize them together since they share
the same IR. There is a front end for LLVM IR, so it can run Python with
C extensions efficiently, for example. It uses the first Futamura
projection to transform the Truffle interpreters into compilers.
Disclaimer: I work on the Graal compiler team.

(Sidenote: the PyPy JIT is similar to Graal: it is self-hosting and
written in a subset of Python, RPython, and compiles itself using the
2nd Futamura projection)

An alternative to using LLVM as a back end is QBE. I haven't used it
myself, but the tagline sounds great: “QBE aims to be a pure C
embeddable backend that provides 70% of the performance of advanced
compilers in 10% of the code. Its small size serves both its aspirations
of correctness and our ability to understand, fix, and improve it. It
also serves its users by providing trivial integration and great
flexibility.” https://c9x.me/compile/

Here's StoneKnifeForth, a self-hosted Forth-like language that compiles
to x86 ELF binaries: https://github.com/kragen/stoneknifeforth.

Here's a Haskell project that compiles a small subset of C using LLVM:
https://blog.josephmorag.com/posts/mcc0/

And here's a very nice bibliography of resources for amateur compiler
writers that I found very helpful: https://c9x.me/compile/bib/. The
corresponding Hacker News discussion is interesting:
https://news.ycombinator.com/item?id=26925314.

I'd like to do parsing with derivatives. Matt Might, former professor at
the U and mentor of Kimball and Peter Aldous, came up with it.

Oh man there's so many papers that I want to read!!! Writing this has
got me more excited. Are you going to be taking 601R from Kimball in the
winter? Kimball says it'll be “reading, summarizing, implementing, and
discussing an academic paper each week”. Or are you graduated?
