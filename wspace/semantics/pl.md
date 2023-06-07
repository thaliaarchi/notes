# PL theory of Whitespace

## Semantics

Whitespace is a stack machine with a heap store, control flow by labeled jumps
and a call stack, and mixed eager and lazy evaluation.

## Why is Whitespace difficult to compile?

### Stack operations should be registerized

The stack size is control-flow-dependent.

I first solved this in Nebula, then adapted it for lazy operations in
lazy-wspace.

### Laziness

### Functions are loosely defined

There is no strict definition of a function. A function could be defined as a
CFG, entered with a `call` and exited with a `ret` or by diverging. However,
this breaks down when considering that other labels within the “function“ could
also be called, which means that its `ret`s could be paired with multiple
entrypoints.

Similarly to how Graal [handles irreducible loops](https://github.com/oracle/graal/commit/4662877b8ce214528f09553f21776ab97e97c1a8)
(those with multiple entries), I could duplicate bodies, for each entry, to have
clearly-demarcated functions, but I'm wondering if there's a better way.

### TODO

List problems and how I solved them or why they're not solved.

Write out instructions and their IR mappings.
