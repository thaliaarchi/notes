# Emscripten: An LLVM-to-JavaScript Compiler

Alon Zakai (Mozilla)

Proc. of the 2011 ACM Object-oriented Programming, Systems, Languages, and
Applications conference (OOPSLA '11)
Portland, Oregon, Oct. 2011

[[paper](https://dl.acm.org/doi/10.1145/2048147.2048224)]

Emscripten is a compiler from LLVM IR to JavaScript. As such, the requirements
are somewhat reverse of the norm, transforming low-level IR into a high-level
language. LLVM IR lacks the structured control flow constructs of JavaScript,
such as loops and ifs, and instead represents it as a control-flow graph (CFG)
of branches between basic blocks. Emscripten aims to use native JavaScript
control flow structures as much as possible, which are more efficiently executed
by JavaScript engines. To recreate high-level structured control flow,
Emscripten uses the Relooper algorithm and this paper proves its validity. This
algorithm is similar to loop-recovery algorithms used in decompilers, but it
differs in that it is not attempting to recover the original source code, but
targets a different high-level language than the source language.

Emscripten has three types of blocks:

- *Simple block*
- *Loop*
- *Multiple*
