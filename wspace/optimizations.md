# Optimizations

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
  - For `copy n` with stack size s:
    - n==0 -> `dup`
    - n<0 -> `copy -1`
    - n>s -> `copy -1`
  - For `slide n` with stack size s:
    - n<=0 -> `slide 0`
    - n>=s -> `slide s-1`

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

  - Remove `slide 0` (-4 bytes)
  - `slide 1 drop` -> `drop drop` (-3 bytes)
  - `slide 2 drop` -> `drop drop drop` (-1 bytes)
  - `drop drop drop drop` -> `slide 3 drop` (-2 bytes)
  - `drop drop drop drop drop` -> `slide 4 drop` (-4 bytes)
  - etc.

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

- Remove drops and copies when procedure drops args, but args are used
  again afterwards:

  ```wsa
  0 3 3 call print_matrix
  0 3 3 call transpose
  0 3 3 call print_matrix
  ```

## Instruction count

Optimize for minimal Whitespace program instruction count.

- `swap drop` -> `slide 1`
- `drop drop drop` -> `slide 2 drop`

## Idioms

### Division and modulo

Recognize wslib/io/divmod.wsf division and modulo idioms.

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

1. Lower `/` to `tdiv`, `fdiv`, `ediv`, `rdiv`, or `cdiv` and `%` to
   `tmod`, `fmod`, `emod`, `rmod`, or `cmod`, according to the execution
   division mode (`--div`).
2. Replace div and mod of constant non-zero divisor with `_unchecked`
   variants and zero divisor with error.
3. Replace division mode conversion idioms.
4. Strength reduce constant divisor.
5. Lower to target division mode.
6. Replace with `_unchecked` variants and add explicit divisor checks
   when divisor may be zero.
7. Annotate zero divisor branches as unlikely like Rust's `unlikely!`
   macro in [`checked_div`](https://doc.rust-lang.org/src/core/num/int_macros.rs.html#519).
