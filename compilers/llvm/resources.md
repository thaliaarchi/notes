# LLVM Tutorials and Resources

## Setting up LLVM tutorials

- [Getting Started with the LLVM System](https://llvm.org/docs/GettingStarted.html)
- [Getting Started with the LLVM System using Microsoft Visual Studio](https://llvm.org/docs/GettingStartedVS.html)
- [Building LLVM with CMake](https://llvm.org/docs/CMake.html)

## Building a frontend with LLVM

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

## Coding tutorials for using LLVM

- [Building a JIT in LLVM](https://llvm.org/docs/tutorial/BuildingAJIT1.html)
  [[code](https://github.com/llvm/llvm-project/tree/main/llvm/examples/Kaleidoscope/BuildingAJIT)]
- [Creating an LLVM Backend for the Cpu0 Architecture](https://jonathan2251.github.io/lbd/)
  [[code](https://github.com/Jonathan2251/lbd)]
- [Creating an LLVM Toolchain for the Cpu0 Architecture](https://jonathan2251.github.io/lbt/)
  [[code](https://github.com/Jonathan2251/lbt)]
- [Implementing LLVM Integrated Assembler](https://www.embecosm.com/appnotes/ean10/ean10-howto-llvmas-1.0.html)
- [llvm-tutor](https://github.com/banach-space/llvm-tutor): example LLVM passes
- [clang-tutor](https://github.com/banach-space/clang-tutor): example Clang
  plugins for C and C++

## User guides

- [User Guides](https://llvm.org/docs/UserGuides.html)

## Language references

- [LLVM Language Reference Manual](https://llvm.org/docs/LangRef.html)
  - [Summary](langref.md)
- [Machine IR (MIR) Format Reference Manual](https://llvm.org/docs/MIRLangRef.html)

## Design and overview

- [The Architecture of Open Source Applications: LLVM](https://www.aosabook.org/en/llvm.html)
- [LLVM for Grad Students](https://www.cs.cornell.edu/~asampson/blog/llvm.html)
- [A Tourist’s Guide to the LLVM Source Code](https://blog.regehr.org/archives/1453)
- [LLVM Framework and Infrastructure Tutorial](https://llvm.org/pubs/2004-09-22-LCPCLLVMTutorial.html)
  (slides)
- [EuroLLVM 2019 MLIR Keynote](https://llvm.org/devmtg/2019-04/talks.html#Keynote_1)

## Resources for compiler writers

- [Performance Tips for Frontend Authors](https://llvm.org/docs/Frontend/PerformanceTips.html)
- [Mapping High Level Constructs to LLVM IR](https://mapping-high-level-constructs-to-llvm-ir.readthedocs.io/en/latest/README.html)
- [Architecture & Platform Information for Compiler Writers](https://llvm.org/docs/CompilerWriterInfo.html)
- [Testing LLVM](https://blog.regehr.org/archives/1450)

## Getting involved

- [Getting Involved](https://llvm.org/docs/GettingInvolved.html)
- [Contributing to LLVM](https://llvm.org/docs/Contributing.html)
- [LLVM Programmer’s Manual](https://llvm.org/docs/ProgrammersManual.html)
- [MyFirstTypoFix](https://llvm.org/docs/MyFirstTypoFix.html)
- [How to submit an LLVM bug report](https://llvm.org/docs/HowToSubmitABug.html)

## News

- [LLVM Weekly](https://llvmweekly.org/) newsletter

## Lists of resources

- [Tutorials index](https://llvm.org/docs/tutorial/index.html)
- [Getting started tutorials](https://llvm.org/docs/GettingStartedTutorials.html)
- [Beginner resources and documentation](https://discourse.llvm.org/t/beginner-resources-documentation/5872)
- [LLVM examples](https://github.com/llvm/llvm-project/tree/main/llvm/examples)
- [Resources for Amateur Compiler Writers](https://c9x.me/compile/bib/)
  [[HN](https://news.ycombinator.com/item?id=26925314)]
- [Program Analysis Resources: LLVM](https://gist.github.com/MattPD/00573ee14bf85ccac6bed3c0678ddbef#llvm)
- [C++ links: compilers](https://github.com/MattPD/cpplinks/blob/master/compilers.md#llvm)
