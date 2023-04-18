# Compact bitwise token encoding

## Encoding

Tokens are encoded with a variable number of bits:
- `S` maps to `0`
- `T` maps to `10`
- `L` maps to `11`

This means that the bits do not end at a byte (or, in general, a `BitStore`)
boundary. If the final byte were to be filled with `0`s, then most programs
would decode with extra `S` tokens. Likewise, if filled with `1`s, there would
be extra `L` tokens. To resolve this ambiguity, if the final bit is a `0`, then
a marker `1` bit is appended before the trailing zeros, which is ignored when
unpacking.

## History

I have a tradition of including bit packing in each of my major Whitespace
implementations: [Respace], [Nebula], [yspace], and [Nebula 2]. Nebula 2 has
configurable bit order unlike the others, which were `Msb0`.

As far as I can tell, Respace was the first implementation of this algorithm and
had been discovered independently, though it had been mentioned theoretically
[in 2012](https://github.com/wspace/corpus/tree/main/python/res-trans32).

[Respace]: https://github.com/thaliaarchi/respace/blob/master/src/binary.h
[Nebula]: https://github.com/thaliaarchi/nebula/blob/master/ws/pack.go
[yspace]: https://github.com/thaliaarchi/yspace/blob/main/src/bit_pack.rs
[Nebula 2]: https://github.com/thaliaarchi/nebula2/blob/main/src/ws/token/bit_pack.rs
