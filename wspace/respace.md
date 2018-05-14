# Respace

A compiler, interpreter, and assembler for the Whitespace language written in C++.

## Features

- *Compiler*
- Interpreter
- Transpiler
  - To Whitespace Assembly
  - *From Whitespace Assembly*
  - *To C*
- *Optimizer*
- Compresser

*Features in italics are upcoming*

# Todo

- Features
  - Floating point (2 arg) language extension
  - Flags for specifying alternate `[Space]`/`[Tab]`/`[LF]` chars
  - Optimizer
    - Identical consecutive pushes replaced with dup
    - Superfluous dup instructions removed
  - Transpiler
    - Apollo Guidance Computer compiler/transpiler
- Whitespace Programs
  - Whitespace interpreter
  - Infix and postfix expression evaluator and converter
  - BF interpreter/compiler
- Documentation
  - Language spec
- Investigate
  - LLVM for compilation
  - Flex or another lexer
