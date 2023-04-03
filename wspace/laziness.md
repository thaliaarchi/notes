# Laziness in Whitespace

The [reference interpreter](https://web.archive.org/web/20040617010431/http://compsoc.dur.ac.uk/whitespace/downloads/wspace-0.3.tgz)
was [intended](emails.md#2023-03-28-210850-utc) to have eager evaluation, but
due to its implementation in Haskell, some parts have lazy evaluation. The
[language tutorial](https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php)
states that the operational semantics are defined by that implementation, in
lieu of a formal specification. A maximally compliant implementation can
consider this lazy behavior to be standard, although all [known](https://github.com/wspace/corpus)
implementations so far, except for [lazy-wspace](https://github.com/thaliaarchi/lazy-wspace)
use the obvious strict semantics.

Whitespace's lazy semantics are difficult to reason about, as execution
interleaves instruction effects, with exceptions potentially occurring long in
the program execution from the originating instruction. This document codifies
those semantics.

## Execution of an individual instruction

- `push n`: lazy literal parse `n`; eager push `n`
- `dup`: eager pop `n`; eager push `n` and `n`
- `copy n`: lazy literal parse `n`; lazy copy from `n`; eager push `stack!!n`
- `swap`: eager pop `n` and `m`; eager push `m` and `n`
- `drop`: eager pop `n`
- `slide n`: eager pop `n`; lazy literal parse `n`; lazy drop by `n`
- `add`: eager pop `y` and `x`; lazy add on `x` and `y`; eager push
- `sub`: eager pop `y` and `x`; lazy sub on `x` and `y`; eager push
- `mul`: eager pop `y` and `x`; lazy mul on `x` and `y`; eager push
- `div`: eager pop `y` and `x`; lazy div on `x` and `y`; eager push
- `mod`: eager pop `y` and `x`; lazy mod on `x` and `y`; eager push
- `store`: eager pop `n` and `loc`; eager evaluate `loc`;
  eager store `n` to `loc`
- `retrieve`: eager pop `loc`; lazy evaluate `loc`; lazy retrieve from `loc`;
  eager push `heap!!(fromInteger loc)`
- `label l`; skip
- `call l`: eager program parse until `label l`; eager push `pc` to call stack;
  eager jump
- `jmp l`: eager program parse until `label l`; eager jump
- `jz l`: eager pop `n`; eager evaluate `n`;
  if n is zero, eager program parse until `label l` and eager jump
- `jn l`: eager pop `n`; eager evaluate `n`;
  if n is negative, eager program parse until `label l` and eager jump
- `ret`: eager call stack pop `cs`; eager jump to `cs`
- `end`: eager exit
- `printc`: eager pop `n`; eager evaluate `n`; eager char validate `n`
- `printi`: eager pop `n`; eager evaluate `n`
- `readc`: eager pop `loc`; eager parse next input char as `ch`;
  eager evaluate `loc`; eager store `ch` at `loc`
- `readi`: eager pop `loc`; eager parse next input line as `ch`;
  eager evaluate `loc`; eager store `ch` at `loc`; lazy number parse `ch`

## Detailed execution

1. Eagerly get the current instruction:
   1. Evaluate `pc` (it may be a `findLabel l prog` expression)
   2. Parse the program until `pc`
2. Eagerly terminate execution or continue:
   - `end`: terminate execution
3. Eagerly pop from the stack:
   - `dup`, `drop`, `slide`, `retrieve`, `jz`, `jn`, `printc`, `printi`,
     `readc`, `readi`: evaluate `stack` to length 1, then pop 1 value `x` or
     panic with underflow
   - `swap`, `add`, `sub`, `mul`, `div`, `mod`, `store`: evaluate `stack` to
     length 2, then pop 2 values `y` and `x` or panic with underflow
4. Eagerly pop from the call stack:
   - `ret`: pop 1 value `pc2` from the call stack or panic
5. Lazily slide:
   - `slide n`: set `stack` to `drop ((parseNumber n) :: Int) stack`
     - Until fully evaluated, this retains references to the values on the top
       of `stack` that will be dropped
     - On evaluation of `stack`, panic if `n` is an empty list (has no sign)
6. Eagerly evaluate values:
   - `store`, `jz`, `jn`, `printc`, `printi`: evaluate `x`
7. Eagerly push to the stack:
   - `push n`: push `parseNumber n`
     - On evaluation, panic if `n` is an empty list (has no sign)
   - `dup`: push `x`, `x`
   - `copy n`: push `stack!!((parseNumber n) :: Int)`
     - Until evaluated, this retains a reference to the current `stack`, so can
       cause space leaks
     - On evaluation:
       1. Parse `n` and let `i = (parseNumber n) :: Int` or panic if `n` is an
          empty list (has no sign)
       2. Evaluate `stack` up to length `i`
       3. Panic if `i < 0` or `i >= length stack`
   - `swap`: push `y` and `x`
   - `slide`: push `x`
   - `add`: push `x + y`
     - On evaluation, evaluate `y`, then evaluate `x`
   - `sub`: push `x - y`
     - On evaluation, evaluate `y`, then evaluate `x`
   - `mul`: push `x * y`
     - On evaluation, evaluate `x`, then evaluate `y`
   - `div`: push ``x `div` y``
     - On evaluation, evaluate `y`, then panic if `y` is `0`, then evaluate `x`
   - `mod`: push ``x `mod` y``
     - On evaluation, evaluate `y`, then panic if `y` is `0`, then evaluate `x`
   - `retrieve`: push `heap!!(fromInteger x)`
     - Until evaluated, this retains a reference to the current `heap`, so can
       cause space leaks
     - On evaluation, evaluate `x`, then panic if `fromInteger x < 0` or
       `fromInteger x >= length heap`
8. Eagerly push to the call stack:
   - `call`: push `pc` to the call stack
9. Eagerly read from stdin:
   - `readc`: read the next character from stdin as `ch` or panic on IO error
   - `readi`: read the next line from stdin as `ch` or panic on IO error
10. Eagerly store in the heap:
    - `store`: store `y` at index `fromInteger x` in `heap`
      - It sets `heap` to a shallow copy of the first `(fromInteger x) - 1`
        elements, followed by `y`, consed with a reference to the tail of `heap`
        at index `fromInteger x` (this constructs `fromInteger x` cons cells)
    - `readc`: store `store (toInteger (fromEnum ch))` at index `fromInteger x`
      in `heap`
    - `readi`: store `store ((read ch) :: Integer)` at index `fromInteger x` in
      `heap`
11. Eagerly update the program counter `pc`:
    - `call l`, `jmp l`, `jz l` if `x == 0`, `jn l` if `x < 0`: set `pc` to
      `findLabel l prog`
    - `ret`: set `pc` to `pc2`
    - else: set `pc` to `pc+1`

## Effects

- Instruction parse fails on unterminated numbers or labels, or invalid UTF-8
- Literal parse fails on missing sign
- Division and modulo fail on zero divisor
- Store never terminates on a negative address
- Retrieve fails on negative address
- Input char parse fails on invalid UTF-8 or EOF
- Input line parse fails on invalid UTF-8 and expects any chars until LF or one
  or more chars until EOF
- Number parse fails on empty string or invalid format
