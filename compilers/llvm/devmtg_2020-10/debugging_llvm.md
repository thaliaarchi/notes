# Everything I know about debugging LLVM

Nick Desaulniers (Google)

[[video](https://www.youtube.com/watch?v=y4b-sgp6VYA)],
[[video (raw)](https://www.youtube.com/watch?v=5vmJuLfIpY4)],
[[slides](https://clangbuiltlinux.github.io/llvm-dev-conf-2020/nick/debugging_llvm.html)]

## Description

This is a refinement of a presentation on the overall architecture of
LLVM, and how to debug certain pieces of it. From this talk, beginners
should learn how to think through where a bug in the compilation
pipeline may be, how to find it, and how to start debugging it. There
are some intermediate tips, too. There's no in-depth focus on any one
particular pass, more so general advice that's widely applicable to most
of the code base. No UML diagrams, but high quality SVG diagrams of the
high level view and corresponding source files in the tree for certain
concepts. Demos include opt, llc, and test case reduction.

The previous version (to be refined) can be viewed:
https://clangbuiltlinux.github.io/CBL-meetup-2020-slides/nick/debugging_llvm.html

## Architecture and structure of LLVM

## Building LLVM (12:10)

```bash
$ git clone git@github.com:llvm/llvm-project.git
$ mkdir llvm-project/llvm/build
$ cd $!
$ cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-G Ninja \
-DCMAKE_C_COMPILER=/android1/android-master/prebuilts/clang/host/
-DCMAKE_CXX_COMPILER=/android1/android-master/prebuilts/clang/hos
-DLLVM_ENABLE_LLD=ON \
-DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" \
-DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X64" \
-DLLVM_ENABLE_ASSERTIONS=OFF
$ ninja
```

- `-DCMAKE_BUILD_TYPE=Release` - Release builds run faster than debug.
  Debug needed for debug symbols and some debugging features.
- `-G Ninja` - Ninja builds faster than GNU Make.
- `-DCMAKE_C_COMPILER=` / `-DCMAKE_CXX_COMPILER=` - Build Clang with
  Clang.
- `-DLLVM_ENABLE_LLD=ON` - Linking Clang with LLD is way faster than
  BFD.
- `-DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt`
- `-DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86` - Anti-pattern; Clang is
  distributed with all non-experimental backends enabled. I turn off
  backends I don't need to speed up builds of Clang. `llc --version`
  shows backends it was configured with.
- `-DLLVM_ENABLE_ASSERTIONS=OFF` - LLVM is full of assertions. Turning
  off assertions is general faster than a debug build.
- `ninja clang` can rebuild just Clang.

## Important compiler-generic flags (16:50)

- `-E`: stop before compiling, after preprocessing, produces .i
- `-S`: stop before assembling, produces .s
- `-c`: stop before linking, produces .o
- `-v`: print commands executed and run
- `-###`: print commands executed, don't run
- `-o`: print to stdout rather than output to file

## Was my binary built with Clang? (20:20)

```sh
$ llvm-readelf --string-dump=.comment vmlinux
String dump of section '.comment':
[     0] Linker: LLD 11.0.0
[    64] clang version 11.0.0
```

## Dumping AST and LLVM IR

## Spotting where something went wrong in opt (32:50)

```sh
$ opt -O2 -print-after-all -S foo.ll
# print-after-all doesn't print a pass if it did no optimization
$ opt -O2 -print-before-all -S foo.ll
```

## Printf debugging in LLVM (37:10)

```cpp
#include <llvm/Support/raw_ostream.h>
llvm::outs() << object;
llvm::errs() << object;

object->print(llvm::errs());

object->dump();

// Per-pass debug info
#include <llvm/Support/Debug.h>
#define DEBUG_TYPE "foo"
LLVM_DEBUG(llvm::dbgs() << object);

// $ opt -licm -debug-only=licm foo.ll -S -o .
```

## llvm-extract (55:40)

Recursively pull out function definition and function definitions that
it depends on.

```sh
$ llvm-extract --func=a -o a.ll quarantine.ll
```
