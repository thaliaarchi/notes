# Synthesis

What shortcomings of LLVM does MLIR fix in its `llvm` dialect?

How is WebAssembly designed differently for browsers, compilation speed,
JavaScript interoperability, and as a compilation target? How does that affect
developer ergonomics?

How does CompCert different for verification? Is it suitable as a
general-purpose IR? (No?) How does the the many-language, many-pass architecture
affect ergonomics?

How do the MLIR dialect and CompCert intermediate language approaches compare?

How does block parameter SSA form compare in WebAssembly and MLIR? Why did
WebAssembly use stack-based instead of SSA? Are optimizations typically
performed on WebAssembly? (No?)

How does the approach with the Truffle API differ from MLIR dialects? Lower or
higher level?

MLIR's new approach vs established compilers. How were the other compilers novel
at release and how has that changed since?

The explicit graph design and op extensibility of MLIR is intentionally
reminiscent of the sea-of-nodes representation. Graal directly uses sea of
nodes.

## Other papers

Is there a paper on GCC? Possibly worth reviewing, if only for shortcomings or
how it's changed since the introduction of LLVM.

GNU Compiler for Java vs GraalVM?

## Developments

LLVM 2004 considered its type information, CFG, and SSA form to be high level.
