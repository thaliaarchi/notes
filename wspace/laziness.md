# Laziness in Whitespace

Whitespace instructions, as implemented in the [reference interpreter](https://web.archive.org/web/20040617010431/http://compsoc.dur.ac.uk/whitespace/downloads/wspace-0.3.tgz),
which was written in Haskell, have a mixture of lazy and eager effects:

- `push n`: lazy literal parse `n`; eager push `n`
- `dup`: eager pop `n`; eager push `n` and `n`
- `copy i`: lazy literal parse `i`; lazy evaluate `i`; lazy copy from `i`;
  eager push `stack!!i`
- `swap`: eager pop `n` and `m`; eager push `m` and `n`
- `drop`: eager pop `n`
- `slide i`: eager pop `n`; lazy literal parse `i`; lazy drop by `i`
- `add`: eager pop `y` and `x`; lazy add on `x` and `y`; eager push
- `sub`: eager pop `y` and `x`; lazy sub on `x` and `y`; eager push
- `mul`: eager pop `y` and `x`; lazy mul on `x` and `y`; eager push
- `div`: eager pop `y` and `x`; lazy div on `x` and `y`; eager push
- `mod`: eager pop `y` and `x`; lazy mod on `x` and `y`; eager push
- `store`: eager pop `n` and `loc`; eager evaluate `loc`;
  eager store `n` to `loc`
- `retrieve`: eager pop `loc`; lazy evaluate `loc`; lazy retrieve from `loc`;
  eager push `heap!!loc`
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
