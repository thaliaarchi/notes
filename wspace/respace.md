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
  - Flags
    - Specify alternate `[Space]`/`[Tab]`/`[LF]` chars
    - Empty number parsed as error or 0
    - Disable stack underflow checks
  - Optimizer
    - Identical consecutive pushes replaced with dup
    - Superfluous dup instructions removed
    - Consolidate stack underflow checks
    - Replace `call` and subsequent `ret` with `jmp` and no `ret`
    - Optimize tail recursion (replace `call` before `ret` with `jmp`) and convert other recursion to tail recursion
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
