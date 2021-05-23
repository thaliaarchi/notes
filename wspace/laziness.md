# Laziness

Make a compatibility mode in my Rust project that mimics the Haskell
interpreter, even down to the exception messages. When replicating lazy
parsing, can make a Parser and LazyParser, both implementing the same
traits: iterator, with a method for retrieving a label. The eager parser
would parse the entire file at once and construct a full label map. The
lazy parser would parse instructions as needed: when advancing pc to the
next or when jumping to a label that needs to seek forwards.

## AOT emulation

Emulating parse laziness would be more difficult ahead-of-time and
requires control flow analysis.

If all live branch targets are valid labels and the final instruction is
call, jmp, ret, or end, then the full source will not be parsed. A
compile warning would be emitted for trailing junk.

If some live branch targets an invalid label or the final instruction is
not call, jmp, ret, or end, then that branch will parse trailing junk
and may panic.
