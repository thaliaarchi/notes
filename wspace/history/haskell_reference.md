# Haskell reference interpreter

## Laziness

The Haskell reference interpreter parses Whitespace programs lazily, so syntax
errors after the last-executed instruction are not reported and the first
occurrence of a label is used for branch destinations.

When replicating lazy parsing in Rust, I'll make a Parser and LazyParser, both
implementing the same traits: iterator, with a method for retrieving a label.
The eager parser would parse the entire file at once and construct a full label
map. The lazy parser would parse instructions as needed: when advancing pc to
the next or when jumping to a label that needs to seek forwards.

### AOT emulation

Emulating parse laziness would be more difficult ahead-of-time and requires
control flow analysis.

If all live branch targets are valid labels and the final instruction is call,
jmp, ret, or end, then the full source will not be parsed. A compile warning
would be emitted for trailing junk.

If some live branch targets an invalid label or the final instruction is not
call, jmp, ret, or end, then that branch will parse trailing junk and may panic.

## GHC version

The latest GHC releases at the time:

- wspace 0.2, [GHC 5.04.3](https://www.haskell.org/ghc/download_ghc_5043.html)
- wspace 0.3, [GHC 6.2.1](https://www.haskell.org/ghc/download_ghc_621.html)

wspace is [tested](https://web.archive.org/web/20150717140342/http://compsoc.dur.ac.uk/whitespace/download.php)
with [GHC 5.02](https://www.haskell.org/ghc/download_ghc_502.html).
