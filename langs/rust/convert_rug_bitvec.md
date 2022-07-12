# Converting between Rug and bitvec types

To convert between Rug and `bitvec` types, the bit order, endianness, and limb
size need to correspond:

In the GMP `mpz_import` function, which Rug calls in `Integer::from_digits`, it
copies the input data to its internal format, which appears to be `Lsf`. If the
input order is `Lsf*` and the endianness matches the host, the data is simply
copied. If the endianness does not match the host, it swaps the bytes. If the
input order is `Msf*`, the bits are reversed.

`bitvec` strongly recommends using `Lsb0` as the `BitOrder`, even if it doesn't
match the host endianness, because it provides the best codegen for bit
manipulation. Since there is no equivalent to `Lsf` in `bitvec` and big-endian
systems are rare, `LsfLe`/`Lsb0` is the best option.

Whitespace integers are big endian, but are parsed and pushed to a `BitVec` in
little-endian order, so the slice of bits needs to be reversed (i.e., not
reversing or swapping words) before converting to an `Integer`.

GMP uses a machine word as the limb size and `bitvec` uses `usize` as the
default `BitStore`.

| Rug   | bitvec    | Bit order                   | Endianness      |
| ----- | --------- | --------------------------- | --------------- |
| Lsf   |           | least-significant bit first | host endianness |
| LsfLe | Lsb0      | least-significant bit first | little-endian   |
| LsfBe |           | least-significant bit first | big-endian      |
| Msf   |           | most-significant bit first  | host endianness |
| MsfLe |           | most-significant bit first  | little-endian   |
| MsfBe | Msb0      | most-significant bit first  | big-endian      |
|       | LocalBits | alias to Lsb0 or Msb0       | host endianness |
