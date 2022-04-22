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
