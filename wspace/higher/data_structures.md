# Expressing higher-level data structures in Whitespace

## Sum type (enum with data)

To minimize the number of bits to represent all the discriminants, they should
have an equal number of positive and negative values, instead of only
non-negative.

Special cases:

- 0: (none)
- 1: (unnecessary)
- 2: 0 `jz`, -1 `jn`
- 3: 0 `jz`, -1 `jn`, 1 `-1 * jn`

Discriminants can be ordered by number of usages to minimize by bits of absolute
value.

For all pairs of variants, if both variants share the same branch in all pattern
matches, and the raw values of the discriminants are not inspected, they can be
coalesced.

If a field in a variant is never used, it can be removed.
