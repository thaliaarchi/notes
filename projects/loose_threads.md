# Loose threads

## Projects

- JavaScript 1.0
  - [doodlewind/mocha1995](https://github.com/doodlewind/mocha1995) extracts
    Mocha from the same archive as I am doing. It is done by the Chinese
    translator of “JavaScript: The First 20 Years”.
  - I think JavaScript was originally distributed as JSRef (JavaScript
    reference) before SpiderMonkey. Rhino [refers to it](https://web.mit.edu/javascript/arch/i386_rh9/build/README.html).
    Maybe I could find a pre-Netscape 3.02 version. However, this [source tree](https://github.com/zii/netscape/tree/master/js/ref)
    for Netscape, has JSRef and appears to be after Mocha.
  - [Rhino](https://web.mit.edu/javascript/doc/rhino/index.html) is an
    implementation of JavaScript in Java, from [fall 1997](https://web.mit.edu/javascript/doc/rhino/history.html),
    when a version of Netscape entirely in Java was in the works
- Blog
  - [Zola](https://www.getzola.org/)
  - [Eleventy](https://www.11ty.dev/)
  - [Jekyll vs Hugo vs Gatsby vs Next vs Zola vs Eleventy](https://mtm.dev/static)
  - [Simplified Saaze](https://jamstack.org/generators/simplified-saaze/)

## Topics

- Compiler IRs
  - RVSDG (Regionalized Value State Dependence Graph)
    - [optir](https://github.com/jameysharp/optir): Proof-of-concept RVSDG IR
    - [numba-rvsdg](https://github.com/numba/numba-rvsdg): Numba-compatible
      RVSDG utilities
  - History of CPS, SSA, and ANF in the context of the [T programming language](https://paulgraham.com/thist.html)
    [[HN](https://news.ycombinator.com/item?id=36732335)] and a related [thread](https://langdev.stackexchange.com/questions/2079/what-are-the-disadvantages-of-using-cps-form)
- Computer construction
  - From Nand to Tetris
  - [Nandgame](https://nandgame.com/) (and [r/nandgame_u](https://www.reddit.com/r/nandgame_u))
  - [MHRD](https://steamcommunity.com/app/576030): game to design CPU in
    hardware description language
  - [Bitwise](https://github.com/pervognsen/bitwise): series to build a hardware
    and software stack from scratch
- Garbage collection
  - [Boehm–Demers–Weiser GC](https://www.hboehm.info/gc/)
    - Wasmtime considered it for use as a general-purpose GC for WebAssembly,
      until that goal was [removed](https://github.com/bytecodealliance/rfcs/commit/b678bf4796851e19ebc41c88c90f76cd0ecd9fb1)
      from the roadmap
- WebAssembly
  - [GC Extension](https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md)
  - [RFC: Add support for the WebAssembly tail calls proposal in Wasmtime](https://github.com/bytecodealliance/rfcs/blob/main/accepted/tail-calls.md)
    [[PR](https://github.com/bytecodealliance/rfcs/pull/29)] (2023-01-20)
  - [RFC: Implement Wasm GC in Wasmtime](https://github.com/bytecodealliance/rfcs/blob/main/accepted/wasm-gc.md)
    [[PR](https://github.com/bytecodealliance/rfcs/pull/31)] (2023-04-14)
  - [Extended Numeric Representations in WebAssembly](https://www-old.cs.utah.edu/docs/techreports/2019/pdf/UUCS-19-009.pdf),
    Bachelor's thesis by Scott Butler, supervised by Matthew Flatt
    (December 2019) [[code](https://github.com/ScottButler87/ExtendedNumerics)]

## Books and papers to read

- [The Rust Performance Book](https://nnethercote.github.io/perf-book/)
  by Nicholas Nethercote
- [Programming Z3](https://theory.stanford.edu/~nikolaj/programmingz3.html)
- [The Apollo Guidance Computer: Architecture and Operation](http://www.apolloguidancecomputer.com/)
  [[HN](https://news.ycombinator.com/item?id=38245884)]
  - [related videos and talks linked by HN](https://news.ycombinator.com/item?id=38244927)
- [Algorithms in Rust for implementing pattern matching](https://github.com/yorickpeterse/pattern-matching-in-rust)

## Tools and libraries to try

- [insta](https://github.com/mitsuhiko/insta): snapshot testing for Rust
- [Gxhash](https://github.com/ogxd/gxhash): fast non-cryptograph hashing
  algorithm in Rust
- [VSCode LLVM Compiler Explorer](https://github.com/sunxfancy/vscode-llvm):
  exploring LLVM IR and machine IR after each pass

## Articles I have read, but not listed

- [Writing a JVM in Rust](https://andreabergia.com/blog/2023/07/i-have-written-a-jvm-in-rust/)
  series by Andrea Bergia

## Other

- [Saudade](https://www.joeyengmusic.com/shop/p/saudade-for-solo-marimba-5-oct)
  5-octave marimba solo
  [[video](https://www.youtube.com/watch?v=1AJPM_rIvMQ)]
