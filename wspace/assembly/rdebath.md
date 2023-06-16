# rdebath assembly

- Corpus: [c/rdebath](https://github.com/wspace/corpus/blob/main/c/rdebath/project.json)
- Source: [code](https://github.com/rdebath/whitespace)
  (last updated [2021-08-11](https://github.com/wspace/rdebath-c/tree/31315a56a064029e5486eececf144bc833b526cb))

## wsa.l

### Grammar

```bnf
program ::= (line lf)* line?
line ::= space? (label_def space?)? inst? space? comment?

inst ::=
    | "push" number
    | "dup"
    | ("copy" | "pick") number
    | "swap"
    | "drop" | "discard"
    | "slide" number
    | "add"
    | "sub"
    | "mul"
    | "div"
    | "mod"
    | "store"
    | "fetch" | "retrieve" | "retrive" | "retreive"
    | "label" label
    | "call" label
    | ("jmp" | "jump") label
    | "jz" label
    | "jn" label
    | "ret" | "return"
    | "quit" | "exit" | "end"
    | "outc" | "outchar" | "printc"
    | "outn" | "outnum" | "printi"
    | "readc" | "readchar"
    | "readn" | "readnum" | "readi"
label_def ::=
    | [0-9]+ ":"
    | "."? name space? ":"

number ::=
    | space [0-9]+
    | space? "-" [0-9]+
    | space? "'" [^\\] "'"
    | space? "'\\" [ntab'] "'"
label ::=
    | space [0-9]+
    | space name
    | space? "." name
name ::= [a-z A-Z _ $] [a-z A-Z 0-9 _ $]*
comment ::=
    | ";" .*?
    | "#" .*?
space ::= [ \t]+
lf ::= "\n"
```

### Bugs in assembler

- It allows a `'''` char

## wsa.sed

### Grammar

```bnf
program ::= (line lf)* line?
line ::= space? inst? space?
inst ::=
    | "push" integer
    | "pushs" string
    | "doub"
    | "swap"
    | "pop"
    | "add" integer?
    | "sub" integer?
    | "mul"
    | "div"
    | "mod"
    | "store" integer?
    | "retrive" integer?
    | "label" label
    | "call" label
    | "jump" label
    | "jumpz" label
    | "jumpn" label
    | "jumppz" label
    | "jumpnz" label
    | "jumpp" label
    | "jumppn" label
    | "jumpnp" label
    | "ret"
    | "exit"
    | (?i)"outC"
    | (?i)"outN"
    | (?i)"InC"
    | (?i)"InN"
    | "test" integer
    | "ifoption" identifier
    | "endoption"
    | "include" identifier
    | "debug_printheap"
    | "debug_printstack"

integer ::= space? "-"? [0-9]+
string ::= space? "\"" [^"]* "\""
identifier ::= space? [a-z A-Z][a-z A-Z 0-9 _]*
label ::= identifier
space ::= [ \t]+
lf ::= "\n"
```

### Notes

- Assemble a near-Burghard dialect

### Bugs in assembler

- Only the I/O mnemonics are case-insensitive
- Some tab literals have been replaced with spaces in the script

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
- `pushs` (Burghard `pushs`)
- `jp` (Burghard `jumpp`)
- `jzp` (Burghard `jumppz`)
- `jzn` (Burghard `jumpnz`)
- `jnz` (Burghard `jumpnp`/`jumppn`)
