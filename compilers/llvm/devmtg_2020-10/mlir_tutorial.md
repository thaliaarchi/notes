# MLIR Tutorial

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

### My question

Q: Are there bindings for using MLIR in languages other than C++? For
example, Go?
