# MLIR Tutorial

Mehdi Amini and River Riddle (Google)

- https://www.youtube.com/watch?v=uhXT4RXjzLI
- https://whova.com/portal/webapp/llvm_202010/Agenda/1162355/

`affine.for` is a loop of a linear equation.

Basic blocks in MLIR take arguments like Swift instead of Phi nodes like
LLVM.

Constants are modeled as operations in MLIR and are not special.

Dialects are declaratively specified in TableGen.

MLIR uses interfaces to manipulate MLIR entities opaquely.
Does not rely on C++ inheritance, more like C# inheritance.

Important to do progressive lowering. Can take advantage of each layer
of abstraction.

## Questions

Q: Are there bindings for using MLIR in languages other than C++? For
example, Go? (me)

A: We are working on a C API to make these easier to create, and first
use is via a Python API. There was an experimental Swift one and I think
someone has done a haskell binding of some sort (I forgot the details, I
think it could have been purely build around the textual IR). I seem to
recall a Julia one too. The focus has been on C++ and getting the core
there, but using from other languages is of interest. (Jacques Pienaar)
