# Optimizations

## Byte size

Optimize for minimal Whitespace program byte size.

Instruction sizes:

- 2: `push`
- 3: `dup` `swap` `drop` `store` `retrieve` `ret` `end`
- 4: `add` `sub` `mul` `div` `mod` `printc` `printi` `readc` `readi`
- 3+: `copy` `slide` `label` `call` `jmp` `jz` `jn`

Optimizations:

- Minify labels, considering usage

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

  - ```wsa
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

  - ```wsa
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

## Loop idioms

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