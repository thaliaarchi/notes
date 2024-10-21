# foldhash vs rustc-hash

The new hashing algorithms in [`foldhash`](https://github.com/orlp/foldhash),
used by [`hashbrown`](https://github.com/rust-lang/hashbrown) as of
[version 0.15](https://github.com/rust-lang/hashbrown/blob/master/CHANGELOG.md#v0150---2024-10-01),
and [`rustc-hash`](https://github.com/rust-lang/rustc-hash) were both designed
and written by Orson Peters using [folded multiplies](https://github.com/orlp/foldhash/blob/master/README.md#background).

The new hashing algorithm in rustc-hash addresses issues with the original
`FxHasher` being slow for longer strings and not finalizing, leading to
collisions for unchanging least-significant bits. It is both faster and has less
collisions. foldhash generalizes it to be appropriate for non-compiler programs.

Since they are so similar, I do a more thorough comparison.

This analysis was conducted against foldhash [commit c55c471](https://github.com/orlp/foldhash/tree/c55c471921ec68e07fdf1623a5d1fa6cc3f09809)
(2024-10-04) and rustc-hash [commit 6745258](https://github.com/rust-lang/rustc-hash/tree/6745258da00b7251bed4a8461871522d0231a9c7)
(2024-10-18). foldhash was [adopted by hashbrown](https://github.com/rust-lang/hashbrown/pull/563)
on 2024-10-01 and the new algorithm for rustc-hash was [merged](https://github.com/rust-lang/rustc-hash/pull/37)
on 2024-06-02.

## Hashing `&[u8]`

- Both hash small lengths in overlapping chunks from the start and the end:
  chunk size 1 for lengths 1..4, chunk size 4 for lengths 4..8, and chunk size 8
  for lengths 8..16
- foldhash hashes larger lengths with overlapping chunks from the start and the
  end: chunk size 16 for lengths 16..256, chunk size 32 for lengths 256..
- rustc-hash only hashes larger lengths with chunks from the start: chunk size
  16 for lengths 16..
- Both combine chunks with folded multiply (64- to 128-bit multiply, then XOR
  the halves) and the result is a u64. They then treat this result as a scalar
  and accumulate as below.

## Hashing scalars

- foldhash collects scalars across calls into a u128 “sponge”, then performs
  folded multiply when it fills.
- rustc-hash hashes scalars with `self.hash = (self.hash + value) * 0xf1357aea2e62a9c5`
  (wrapping), i.e., a multiplicative congruential psueodrandom number generator.

## Seeding

- foldhash uses constant seeds with high entropy (derived from digits of pi!),
  mixed with address space layout randomization, the current time, and an
  address from the allocator. It also has a mode which uses only constant seeds.
- rustc-hash uses the same constant seeds with no other sources.

## Conclusion

This suggests that hashing `&[u8]` is more efficient than looping hashing
scalars, because it batches in chunks. For example, in a compiler that hashes a
lot of `&[Id]`, where `Id` is a newtype of `u32`, transmuting it to a `&[u8]`
would be faster.

rustc-hash is optimized for shorter strings.
