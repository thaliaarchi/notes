# Zig

- [I Believe Zig Has Function Colors](https://gavinhoward.com/2022/04/i-believe-zig-has-function-colors/)
  [[HN](https://news.ycombinator.com/item?id=30965805)] - Shows that Zig has two
  colors of functions, async and not, that are distinguished by calling
  conventions. The color can usually be statically determined and the correct
  calling convention assigned, except when used as dynamic function pointers.
  Concludes that structured concurrency (as in Swift) is better.

- [Make self hosted compiler capable of building itself](https://github.com/ziglang/zig/pull/11442)
  [[HN](https://news.ycombinator.com/item?id=31052029)]

- [Zig Roadmap 2023](https://www.youtube.com/watch?v=AqDdWEiSwMM)

  > There are also many bugs that do not exist in self-hosted, that only exist
  > in the C++ implementation, so that will be very nice—especially for
  > everybody who likes to go into crazy town with `comptime`, you can start to
  > do all your fancy `comptime` regex stuff with or whatever with this
  > implementation.

  Is there more written on how the self-hosted compiler enables further
  `comptime` expressivity?

  The C backend allows the stage1 codebase to be retired.

- [Goodbye to the C++ Implementation of Zig](https://ziglang.org/news/goodbye-cpp/)
  [[HN](https://news.ycombinator.com/item?id=33913231)]

  The Zig compiler in C++ was removed (80,000 lines), leaving only the
  self-hosted compiler (250,000 lines). To facilitate the new bootstrapping
  process, a stage1 compiler build is periodically checked into the repo and a
  minimal WebAssembly-to-C converter (4,000 lines of C) was added.

  Bootstrapping process before:
  - stage1: Use system C compiler to compile the C++ Zig compiler into `zig1`.
  - stage2: Use `zig1` to compile the self-hosted Zig compiler into `zig2`.

  Bootstrapping process now:
  - stage1 setup:
    - Use system Zig compiler to compile the self-hosted Zig compiler into
      `zig1.wasm`, with only the C backend enabled.
    - Compress it as `zig1.wasm.zst` and check it into the repo.
  - stage1:
    - Use `zig-wasm2c` to zstd-decompress and convert `zig1.wasm.zst` to
      `zig1.c`.
    - Use system C compiler to compile `zig1.c` to `zig1`. This has incorrect
      logic (only C backend).
  - stage2:
    - Use `zig1` to compile the Zig compiler into `zig2.c`.
    - Use system C compiler to compile `zig2.c` to `zig2`. This has correct
      logic, but with the optimizations of the C compiler.
  - stage3:
    - Use `zig2` to compile the Zig compiler into `zig3`. This has correct logic
      and optimizations.
  - stage4:
    - Use `zig3` to compile the Zig compiler into `zig4`. This is binary-wise
      identical to `zig3`.

- [Zig ported to SerenityOS](https://twitter.com/awesomekling/status/1602315728320880640)
  [[talk](https://sin-ack.github.io/posts/sycl-talk-20221007/)]
  [[PR](https://github.com/SerenityOS/serenity/pull/15428)]
  [[HN](https://news.ycombinator.com/item?id=33955257)]
