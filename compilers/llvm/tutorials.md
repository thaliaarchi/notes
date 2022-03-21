# LLVM Tutorials and Examples

## Setting up LLVM

- [Getting Started with the LLVM System](https://llvm.org/docs/GettingStarted.html)
- [Getting Started with the LLVM System using Microsoft Visual Studio](https://llvm.org/docs/GettingStartedVS.html)
- [Building LLVM with CMake](https://llvm.org/docs/CMake.html)

## Front-ends

- Kaleidoscope: Implementing a Language with LLVM
  - [C++](https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html)
    [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Kaleidoscope)]
  - [OCaml](https://releases.llvm.org/12.0.1/docs/tutorial/OCamlLangImpl1.html)
    [[code](https://github.com/llvm/llvm-project/tree/llvmorg-12.0.1/llvm/examples/OCaml-Kaleidoscope)]
    ([removed](https://reviews.llvm.org/D96299) in LLVM 13)
  - [Haskell with llvm-hs](https://www.stephendiehl.com/llvm/)
    [[code](https://github.com/sdiehl/kaleidoscope)]
  - Haskell with llvm-hs [[code](https://github.com/llvm-hs/llvm-hs-kaleidoscope)]
    (without AST)
  - Rust with Inkwell [[code](https://github.com/TheDan64/inkwell/tree/master/examples/kaleidoscope)]
- BrainF [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/BrainF)]
- [Stacker: An Example of Using LLVM](https://releases.llvm.org/2.3/docs/Stacker.html)
  [[code](https://github.com/llvm/llvm-project/tree/9be3ca0a1f5d8b820b222858519c6b7a964cc174/stacker)]
  ([removed](https://reviews.llvm.org/rGafb1d31c54204b7f6c11e4f8815d203bcf9cffa3)
  in LLVM 2.4)
- ExceptionDemo: An example using LLVM exceptions [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/ExceptionDemo)]
- ModuleMaker: Example project [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/ModuleMaker)]
- [Performance Tips for Frontend Authors](https://llvm.org/docs/Frontend/PerformanceTips.html)

## Passes

- [Writing an LLVM Pass](https://www.llvm.org/docs/WritingAnLLVMNewPMPass.html)
  (new pass manager)
- [Writing an LLVM Pass](https://www.llvm.org/docs/WritingAnLLVMPass.html)
  (legacy pass manager)
- [Using the New Pass Manager](https://www.llvm.org/docs/NewPassManager.html)
- [Getting Started With LLVM: Basics](https://llvm.org/devmtg/2019-10/talk-abstracts.html#tut1)
  [[video](https://www.youtube.com/watch?v=3QQuhL-dSys)]
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/IRTransforms)]
  (legacy pass manager)
- [llvm-tutor](https://github.com/banach-space/llvm-tutor)
  (example LLVM passes)
- Bye [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Bye)]
  (new/legacy pass manager registration)

## Back-ends

- [Creating an LLVM Backend for the Cpu0 Architecture](https://jonathan2251.github.io/lbd/)
  [[code](https://github.com/Jonathan2251/lbd)]
- [Creating an LLVM Toolchain for the Cpu0 Architecture](https://jonathan2251.github.io/lbt/)
  [[code](https://github.com/Jonathan2251/lbt)]
- [Implementing LLVM Integrated Assembler](https://www.embecosm.com/appnotes/ean10/ean10-howto-llvmas-1.0.html)

## JIT

### ORC

- [Building a JIT in LLVM](https://llvm.org/docs/tutorial/BuildingAJIT1.html)
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Kaleidoscope/BuildingAJIT)]
- HowToUseLLJIT: An example use of ORC-based LLJIT
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/HowToUseLLJIT)]
- OrcV2Examples [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/OrcV2Examples)]
- SpeculativeJIT [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/SpeculativeJIT)]

### MCJIT

- [Kaleidoscope with MCJIT](https://blog.llvm.org/2013/07/using-mcjit-with-kaleidoscope-tutorial.html)
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Kaleidoscope/MCJIT)]
  - [Kaleidoscope Performance with MCJIT](https://blog.llvm.org/2013/07/kaleidoscope-performance-with-mcjit.html)
  - [Object Caching with the Kaleidoscope Example Program](https://blog.llvm.org/2013/08/object-caching-with-kaleidoscope.html)
- HowToUseJIT: An example use of the JIT
  [[code](https://github.com/llvm/llvm-project/blob/main/llvm/examples/HowToUseJIT/HowToUseJIT.cpp)]
- Fibonacci: An example use of the JIT
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Fibonacci)]
- ParallelJIT: Exercise threaded-safe JIT
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/ParallelJIT)]

## Debugging

- [How to create LLDB type summaries and synthetic children for your custom types](https://melatonin.dev/blog/how-to-create-lldb-type-summaries-and-synthetic-children-for-your-custom-types/)

## Clang

- [clang-tutor](https://github.com/banach-space/clang-tutor) (example Clang
  plugins for C and C++)

## Contributing

- [MyFirstTypoFix](https://llvm.org/docs/MyFirstTypoFix.html)

## Tutorial lists

- [Tutorials index](https://llvm.org/docs/tutorial/index.html)
- [Getting started tutorials](https://llvm.org/docs/GettingStartedTutorials.html)
- [Beginner resources and documentation](https://discourse.llvm.org/t/beginner-resources-documentation/5872)
- [LLVM examples](https://github.com/llvm/llvm-project/tree/main/llvm/examples)
