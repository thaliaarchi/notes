# Compiler IRs

## Expressions

Use a DAG for expressions, e.g.,

| #   | Type   | Left | Right | Value |
| --- | ------ | ---- | ----- | ----- |
| 0   | NAME   |      |       | x     |
| 1   | NAME   |      |       | a     |
| 2   | INT    |      |       | 10    |
| 3   | ITOF   | 2    |       |       |
| 4   | FADD   | 1    | 3     |       |
| 5   | FMUL   | 4    | 4     |       |
| 6   | ASSIGN | 0    | 5     |       |

See [*Introduction to Compilers and Language Design*](https://www3.nd.edu/~dthain/compilerbook/),
2020, by Douglas Thain, section 8.3 Directed Acyclic Graph.

This simplifies CSE and constant folding.

How would this interact with lazy expressions? How would this interact with
opaque heap references and aliasing?
