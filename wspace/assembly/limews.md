# Lime Whitespace assembly

- Source: [code](https://github.com/ManaRice/whitespace/blob/master/wsa.c),
  [docs](https://github.com/ManaRice/whitespace/blob/master/ws/wsa/README.md)
  (last updated [2022-05-30](https://github.com/ManaRice/whitespace/tree/e8db8719e170c12875dac571c39ac811c7d0ec52))
- Corpus: [c/manarice-lime](https://github.com/wspace/corpus/blob/main/c/manarice-lime/project.json)

## Grammar

```bnf
program ::= space? (inst space)* inst? space?
inst ::=
    | ("PUSH" | "push") space number
    | "DUPE" | "dupe" | "DUP" | "dup"
    | ("COPY" | "copy") space number
    | "SWAP" | "swap"
    | "DROP" | "drop"
    | ("SLIDE" | "slide") space number
    | "ADD" | "add"
    | "SUB" | "sub"
    | "MUL" | "mul"
    | "DIV" | "div"
    | "MOD" | "mod"
    | "STORE" | "store"
    | "FETCH" | "fetch" | "RETRIEVE" | "retrieve"
    | label ":"
    | ("CALL" | "call") space label
    | ("JMP" | "jmp") space label
    | ("JZ" | "jz") space label
    | ("JN" | "jn") space label
    | "RET" | "ret"
    | "END" | "end"
    | "PRINTC" | "printc"
    | "PRINTI" | "printi"
    | "READC" | "readc"
    | "READI" | "readi"
    | ("MACRO" | "macro")
        space word
        space? "["
        (space? (word | label | number)
                (space (word | label | number))*)?
        space? "]"
    | word

word ::= [^ \t\n.:;\[\]*/\\'"#$-]+
label ::= "." word
number ::=
    | "-"? [0-9]{1,64}
    | "0x" [0-9a-fA-F]{1,64}
    | "'" ([^\\] | \\[nt] | \\.) "'"
space ::= ([ \t\n] | comment)+
comment ::=
    | "//" .*? "\n"
    | "/*" .*? "*/"
    | ";" .*? "\n"
```

The pattern `.` includes `\n` here.

## Notes

- Byte-oriented
- The mnemonics are inspired by Whitelips IDE
- Labels and macro names cannot be mnemonics
- Numbers are limited to 64 digits when parsing and encoding
- Labels are encoded as signed integers incrementing from 0x4a00 in definition
  order and are limited to 64 bits
- Numbers and labels are stored as signed 64-bit integers
- `'\n'` and `'\t'` escapes are handled, while any other characters are used
  unchanged
- `push 0` and `push -0` are encoded as `SS SSL`
- It prepends the shebang `#!lwsvm`

## Bugs in the assembler

- The first digit of a number and the first byte of a label may be any value
- Negative hex numbers are not handled
- Line comments can't end with EOF
- A label may be used in place of a number
- Space is optional between tokens, when either is one of `.` `:` `;` `[` `]`
  `*` `/` `\` `'` `"` `#` `$` `-` or `` ` ``. This means that space isn't
  required before or after a label definition, after a macro definition, before
  a negative number, or before or after a char.
