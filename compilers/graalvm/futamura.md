# Practical Second Futamura Projection: Partial Evaluation for High-Performance Language Interpreters

Florian Latifi (JKU)

[[paper](https://dl.acm.org/doi/10.1145/3359061.3361077)],
[[PDF](https://dl.acm.org/doi/pdf/10.1145/3359061.3361077)]

## Truffle with first Futamura projection

Truffle uses the first Futamura projection to derive target programs from AST
interpreters, which are then optimized and compiled by the Graal compiler to
high-performance machine code.

Partial evaluation starts at the AST root for the user method to be compiled,
parses it into an IR, and partially-evaluates it to the Truffle primitives.

## Truffle with second Futamura projection

Truffle PE can take half of the overall compile time, with the rest for Graal
opts and codegen. Compiling the Truffle interpreter to a compiler (2nd
projection) would yield much faster compile times.

For self-application to work in Truffle, PE would need to be reimplemented as a
Truffle language AST interpreter. Instead, this paper proposes a hand-written
code generator instead of self-application.
