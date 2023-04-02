# Optimizations

## Control flow

- Tail-call optimization for recursive `call`
- Replace non-recursive single-entry `call` and `ret` with `jmp`
- Replace `call` with `jmp` when `end` or error always reached before
  corresponding `ret`
- Rewrite mutually-exclusive branches as cascading branches

  ```
  let v = 0
  if a: v = 1
  if b: v = 2
  if c: v = 3
  ```

  ->

  ```
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

## Byte size

Optimize for minimal Whitespace program byte size.

Instruction sizes:

- 2+: `push`
- 3: `dup` `swap` `drop` `store` `retrieve` `ret` `end`
- 4: `add` `sub` `mul` `div` `mod` `printc` `printi` `readc` `readi`
- 3+: `copy` `slide` `label` `call` `jmp` `jz` `jn`

Optimizations:

- Simplify arguments:

  - Remove leading zeros for `push`, `copy`, and `slide`
  - `push -0` -> `push 0`
  - `copy n` with stack size s
    - -> `dup` (when `n == 0`)
    - -> `copy -1` (when `n < 0`)
    - -> `copy -1` (when `n > s`)
  - `slide n` with stack size s
    - -> `slide 0` (when `n <= 0`)
    - -> `slide s-1` (when `n >= s`)

- Minify labels, considering usage frequency

- Inline only if shorter

- Deduplicate identical regions

- Commutating:

  - `^1 ^1 +` -> `^ ^2 +` (-2 bytes)
  - `^1 ^1 *` -> `^ ^2 *` (-2 bytes)
  - `^1 ^1 - jz l` -> `^ ^2 - jz l` (-2 bytes)
  - `^2 ^2 * ^4 ^2 + +` -> `^3 ^2 + ^3 ^2 * +` (-1 bytes)
  - `^2 ^1 * ^4 ^3 + +` -> `^3 ^1 + ^3 ^3 * +` (-1 bytes)

- Successive drops:

  - Remove `slide 0` if stack always non-empty (-4 bytes)
  - `slide 1 drop` -> `drop drop` (-3 bytes)
  - `slide 2 drop` -> `drop drop drop` (-1 bytes)
  - `drop drop drop drop` -> `slide 3 drop` (-2 bytes)
  - `drop drop drop drop drop` -> `slide 4 drop` (-4 bytes)
  - etc.

- Slide reordering:

  - `slide n drop push x` -> `push x slide n+1` (-2 or -3 bytes)

- Label reordering:

  ```wsa
  a: ... jmp c
  b: ... jmp a
  ```

  -> (-4+ bytes)

  ```wsa
  b: ...
  a: ... jmp c
  ```

- Relative subtraction for unused conditions:

  ```wsa
  ^ 2  - jz a
  ^ 8  - jz b
  ^ 16 - jz c
  ```

  -> (-2 bytes)

  ```wsa
  2 - ^ jz a
  6 - ^ jz b
  8 - ^ jz c
  ```

  e.g. wslib/io/format_int.wsf:.print_base_prefix

- Factor out shared instructions:

  ```wsa
  a: drop 'a' jmp d
  b: drop 'b' jmp d
  c: drop 'c' jmp d
  d: printc
  ```

  -> (-6 bytes)

  ```wsa
  a: 'a' jmp d
  b: 'b' jmp d
  c: 'c' jmp d
  d: printc drop
  ```

  or

  ```wsa
  a: drop 'a' jmp d
  b: drop 'b' jmp d
  c: drop 'c' jmp d
  d: add printc
  ```

  -> (-3 bytes)

  ```wsa
  a: 'a' jmp d
  b: 'b' jmp d
  c: 'c' jmp d
  d: slide 1 add printc
  ```

- Swap params:

  ```wsa
  a: ^1 ^1 jmp c
  b: ^2 ^2 jmp c
  c: swap
  ```

  -> (-6 bytes)

  ```wsa
  a: ^ ^2 jmp c
  b: ^1 ^3 jmp c
  c:
  ```

- Remove drops and copies when procedure drops args, but args are used again
  afterwards:

  ```wsa
  0 3 3 call print_matrix
  0 3 3 call transpose
  0 3 3 call print_matrix
  ```

## Instruction count

Optimize for minimal Whitespace program instruction count.

- Drops:

  - `swap drop` -> `slide 1` (-0 bytes, -1 instruction)
  - `drop drop drop` -> `slide 2 drop` (+1 byte, -1 instruction)

## Idioms

### Division and modulo

Recognize wslib/math/divmod.wsf division and modulo idioms.

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

1. Lower `/` to `tdiv`, `fdiv`, `ediv`, `rdiv`, or `cdiv` and `%` to `tmod`,
   `fmod`, `emod`, `rmod`, or `cmod`, according to the execution division mode
   (`--div`).
2. Replace div and mod of constant non-zero divisor with `_unchecked` variants
   and zero divisor with error.
3. Replace division mode conversion idioms.
4. Strength reduce constant divisor.
5. Lower to target division mode.
6. Replace with `_unchecked` variants and add explicit divisor checks when
   divisor may be zero.
7. Annotate zero divisor branches as unlikely like Rust's `unlikely!` macro in
   [`checked_div`](https://doc.rust-lang.org/src/core/num/int_macros.rs.html#519).
