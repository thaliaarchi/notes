# Whitespace IR-level optimizations

## Control flow

- Rewrite mutually-exclusive branches as cascading branches

  ```ir
  let v = 0
  if a: v = 1
  if b: v = 2
  if c: v = 3
  ```

  ->

  ```ir
  let v
  if      c: v = 3
  else if b: v = 2
  else if a: v = 1
  else:      v = 0
  ```

## Data flow

- Determine integer bit width bounds
- Determine whether stack values represent heap addresses, for heap bounding and
  garbage collection
- Eliminate branches in loops, that are dependent on certain values in a string,
  which are never give by callers. For example, if `printf` is never called with
  the `%#nb` verb, that case can be removed

## Duplication

- Global value numbering
- Common subexpression elimination

## Peephole

- Bitwise expressions where `y = 2 ** s`:
  - `x y *` -> `x << s`
  - `x y /` -> `x >> s`
  - `x y %` -> `x & (y - 1)` (fdiv for `y > 0`, tdiv for `x > 0`)
  - `x 2 %` -> `x & 1` (fdiv, tdiv for `x > 0`)
- Logical expressions where `a = x % 2 = x & 1` and `b = y % 2 = y & 1` (fdiv,
  tdiv for `x > 0`)
  - NOT `^a`:
    - `1 a -`
  - AND `a & b`:
    - `a b *`
    - `a b + 2 /`
  - OR `a | b`:
    - `a b + a b -`
    - `1 1 a - 1 b - * -`
  - XOR `a ^ b`:
    - `a b + 2 %`
    - `a b + 1 a b * - *`
  - ANDNOT `a &^ b`:
    - `a 1 b - *`
  - NAND `^(a & b)`:
    - `1 a b * -`
    - `1 a b + 2 / -`
  - NOR `^(a | b)`:
    - `1 a - 1 b - *`
    - `1 a b + a b * - -`
  - XNOR `^(a ^ b)`:
    - `1 a b + 2 % -`
    - `1 a b * 1 a b * - * -`
  - NANDNOT `^(a &^ b)`:
    - `1 a 1 b - * -`
- `jz` conditionals:
  - `x jz l` -> `x == 0`
  - `x y + jz l` -> `x == -y`
  - `x y - jz l` -> `x == y`
  - `x y * jz l` -> `x & y == 0`
  - `x y / jz l` for `y > 0`:
    - -> `0 <= x && x < y` (fdiv)
    - -> `-y < x && x < y` (tdiv)
  - `x y / jz l` for `y < 0`:
    - -> `y < x && x <= 0` (fdiv)
    - -> `y < x && x < -y` (tdiv)
  - `x y % jz l` -> `x % y == 0` (fdiv, tdiv)
- `jn` conditionals:
  - `x jn l` -> `x < 0`
  - `x y + jn l` -> `x < -y`
  - `x 1 - jn l` -> `x <= 0`
  - `x y - jn l` -> `x < y`
  - `x y * jn l` -> `(x < 0) ^ (y < 0)`
  - `x y / jn l` for `y > 0`:
    - -> `x < 0` (fdiv)
    - -> `x <= -y` (tdiv)
  - `x y / jn l` for `y < 0`:
    - -> `x > 0` (fdiv)
    - -> `x >= -y` (tdiv)

## Idioms

### Popcount

LLVM [transforms](https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Scalar/LoopIdiomRecognize.cpp#L1449)
this loop into the popcount instruction:

```c
for (cnt = init; x != 0; cnt++) {
  x &= (x - 1);
}
```

I want to also recognize this more naïve version:

```c
for (cnt = init; x != 0; x >>= 1) {
  cnt += x & 1;
}
```

## Division and modulo lowering

1. Lower `/` to `tdiv`, `fdiv`, `ediv`, `rdiv`, or `cdiv`; and `%` to `tmod`,
   `fmod`, `emod`, `rmod`, or `cmod`, according to the execution division mode
   (`--div`).
2. Replace div and mod of constant non-zero divisor with `_unchecked` variants
   and zero divisor with error.
3. Replace division mode conversion idioms.
4. Strength reduce constant divisor.
5. Lower to target division mode.
6. Replace with `_unchecked` variants and add explicit divisor checks when
   divisor may be zero.
7. Annotate zero divisor branches as unlikely like Rust's `unlikely!` intrinsic
   in [`checked_div`](https://doc.rust-lang.org/src/core/num/int_macros.rs.html#519).
