# Limits for Whitespace

The character and line counts should each fit in 32 bits (up to 4,294,967,295)
and the line width and file count each in 16 bits (up to 65,535).

## Large Whitespace programs

The largest Whitespace programs, pulled from data gathered in the
[Whitespace Corpus](https://github.com/wspace/corpus):

| File                            | Bytes/chars | Lines | Longest line |
| ------------------------------- | ----------- | ----- | ------------ |
| [quine-copy.ws]                 | 661964      | 46171 | 128          |
| [QR.ws]                         | 614003      | 76753 | 49           |
| [xctf-finals-2020-spaceship.ws] | 539624      | 45435 | 216          |
| [password_checker.ws]           | 510875      | 43120 | 216          |
| [sk-whitespace.ws]              | 135462      | 19259 | 88           |
| [rameev.ws]                     | 94152       | 21387 | 49           |

[quine-copy.ws]: https://web.archive.org/web/20150612005338/http://compsoc.dur.ac.uk/whitespace/quine-copy.ws
[QR.ws]: https://github.com/mame/quine-relay/blob/spoiler/QR.ws
[xctf-finals-2020-spaceship.ws]: https://github.com/umutoztunc/whitesymex/blob/main/tests/data/xctf-finals-2020-spaceship.ws
[password_checker.ws]: https://github.com/umutoztunc/whitesymex/blob/main/tests/data/password_checker.ws
[sk-whitespace.ws]: https://github.com/kspalaiologos/cosmopolitan-sk/blob/master/sk-whitespace.ws
[rameev.ws]: https://gist.github.com/pik4ez/8274216220511d0e42de7881eca782da

## Line width limit

Due to the instruction encoding scheme, the absolute line width limit can be
approximated:

`push` is terminated with an L and can be preceded on the same line with any
number of instructions that do not contain L, that is, `add`, `sub`, `div`,
`mod`, `store`, `retrieve`, and `shuffle`. This subset of instructions would not
be very useful to repeat excessively in sequence, though `retrieve` and
`shuffle` could be arbitrarily repeated without requiring a large stack. 128 of
these instructions followed by a 4096-bit `push` would be up to 4611 tokens on a
line.

Labeled control flow instructions contain an L in the opcode and one terminating
the label, so always span a full line. With the convention of representing
textual labels using eight `S`/`T` tokens per byte and a pathological 2048-byte
label (the identifier length limit in some C++ compilers), that would be 16384
tokens for the label, plus three more for the opcode.

`slide` also spans a full line, but stack sizes are usually small and its
argument length is logarithmic to the size of the stack, so it wouldn't be more
than a few tokens long.

Comments are not similarly constrained and could be arbitrarily long, but should
not occur more than a ratio of 10:1 with `S`/`T`/`L` tokens, even in
steganographic programs.

## File count limit

There should be no case where over 65,535 files would be compiled at once. Even
the Linux kernel has less overall files than that.
