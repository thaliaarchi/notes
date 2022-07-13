# Compact bitwise token encoding

Tokens are encoded with a variable number of bits: S maps to 0, T maps to 10,
and L maps to 11. To resolve the ambiguity in the last byte of whether the
trailing zeros are S, the second half of T, or unset, an extra 1 is appended,
which is ignored when unpacking.

I have a tradition of including bit packing in each of my major Whitespace
implementations: [Respace](https://github.com/andrewarchi/respace/blob/master/src/binary.h),
[Nebula](https://github.com/andrewarchi/nebula/blob/master/ws/pack.go),
[yspace](https://github.com/andrewarchi/yspace/blob/main/src/bit_pack.rs), and
[Nebula 2](https://github.com/andrewarchi/nebula2/blob/main/src/ws/token/bit_pack.rs).
Nebula 2 has configurable bit order unlike the others, which were `Msb0`. As far
as I can tell, Respace was the first implementation of this algorithm and had
been discovered independently, though it had been mentioned theoretically
[in 2012](https://github.com/wspace/corpus/tree/main/python/res-trans32).
