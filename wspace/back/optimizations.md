# Whitespace source-level optimizations

## Control flow

- Tail-call optimization for recursive `call`
- Replace non-recursive single-entry `call` and `ret` with `jmp`
- Replace `call` with `jmp` when `end` or error always reached before
  corresponding `ret`

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

- Duplicate values:

  - `x x` -> `x dup`
  - `x y x` -> `x y ^1`

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

  e.g., [`.print_base_prefix`](https://github.com/thaliaarchi/wslib/blob/main/int/print.wsf#L73-L89)
  in wslib/int/print.wsf

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

Recognize [wslib/math/divmod.wsf](https://github.com/thaliaarchi/wslib/blob/main/math/divmod.wsf)
division and modulo idioms.
