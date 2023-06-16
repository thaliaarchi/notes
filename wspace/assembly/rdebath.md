# rdebath assembly

- Corpus: [c/rdebath](https://github.com/wspace/corpus/blob/main/c/rdebath/project.json)
- Source: [code](https://github.com/rdebath/whitespace)
  (last updated [2021-08-11](https://github.com/wspace/rdebath-c/tree/31315a56a064029e5486eececf144bc833b526cb))

## wsa.l

### Grammar

```bnf
program ::= (line lf)* line?
line ::= space? (inst | label_def inst?)? space? comment?

inst ::=
    | "push" space number
    | "dup"
    | ("copy" | "pick") space number
    | "swap"
    | "drop" | "discard"
    | "slide" space number
    | "add"
    | "sub"
    | "mul"
    | "div"
    | "mod"
    | "store"
    | "fetch" | "retrieve" | "retrive" | "retreive"
    | "label" space label
    | "call" space label
    | ("jmp" | "jump") space label
    | "jz" space label
    | "jn" space label
    | "ret" | "return"
    | "quit" | "exit" | "end"
    | "outc" | "outchar" | "printc"
    | "outn" | "outnum" | "printi"
    | "readc" | "readchar"
    | "readn" | "readnum" | "readi"
label_def ::=
    | [0-9]+ ":"
    | name space? ":"

number ::=
    | "-"? [0-9]+
    | "'" [^\\] "'"
    | "'\\" [ntab'] "'"
label ::=
    | [0-9]+
    | name
name ::= "."? [a-z A-Z _ $] [a-z A-Z 0-9 _ $]*
comment ::=
    | ";" .*?
    | "#" .*?
space ::= [ \t]+
lf ::= "\n"
```

### Bugs in assembler

- It allows a `'''` char

## Mnemonics

The assemblers allow various mnemonics and emit code that's linked with
`ws_gencode.h`. The mnemonics defined therein can be considered the preferred
mnemonics.

Standard instructions:
- `push`
- `dup`
- `pick`
- `swap`
- `drop`
- `slide`
- `add`
- `sub`
- `mul`
- `div`
- `mod`
- `store`
- `fetch`
- `label`
- `call`
- `jump`
- `jz`
- `jn`
- `return`
- `exit`
- `outc`
- `outn`
- `readc`
- `readn`

Extension instructions:
- `pushs`
- `jp`
- `jzp`
- `jzn`
- `jnz`
