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

# Ideas

- Implement heap by using 0-9 (or any range) as 'variables' on heap, then pushing positive heap addresses up by 10. Essentially creating a stack frame for each instance of the nested interpreter
- Implement stack on stack by clearing stack of any temporary variables
- Insert profile points to monitor code to find places that need optimization and less probable branches
- Find wiki with list of optimization techniques
- Could do interpreting the JVM way by identifying slow methods as it's running and optimizing those, then replacing future calls with calls to the optimized methods
- Or do ahead of time compilation where it optimizes before it runs, then as it's running it can do other optimizations, but none of this is written to disk
- Could compile to x86 assembly or machine code
