# Lime Whitespace (c/manarice)

[[code](https://github.com/ManaRice/whitespace/blob/master/wsa.c)]
[[docs](https://github.com/ManaRice/whitespace/blob/master/ws/wsa/README.md)]

```bnf
program ::= space* (inst space+)* inst? space*
inst ::=
    | ("MACRO" | "macro")
        space+ identifier
        space* "["
        (space* identifier (space+ identifier)*)?
        space* "]"
    | identifier
    | ("PUSH" | "push") space+ number
    | "DUPE" | "dupe" | "DUP" | "dup"
    | ("COPY" | "copy") space+ number
    | "SWAP" | "swap"
    | "DROP" | "drop"
    | ("SLIDE" | "slide") space+ number
    | "ADD" | "add"
    | "SUB" | "sub"
    | "MUL" | "mul"
    | "DIV" | "div"
    | "MOD" | "mod"
    | "STORE" | "store"
    | "FETCH" | "fetch" | "RETRIEVE" | "retrieve"
    | "." identifier ":"
    | ("CALL" | "call") space+ identifier
    | ("JMP" | "jmp") space+ identifier
    | ("JZ" | "jz") space+ identifier
    | ("JN" | "jn") space+ identifier
    | "RET" | "ret"
    | "END" | "end"
    | "PRINTC" | "printc"
    | "PRINTI" | "printi"
    | "READC" | "readc"
    | "READI" | "readi"
identifier ::= [^ \t\n.:;\[\]*/\\'"#$-]+
number ::=
    | "-"? [0-9]{1,64}
    | "0x" [0-9 a-f A-F]{1,64}
    | "'" . "'"
    | "'\\" ([nt] | .) "'"
space ::=
    | [ \t\n]*
    | "//" .*? "\n"
    | "/*" .*? "*/"
    | ";" .*? "\n"
```

Bugs in the assembler:
- The first digit of a number and the first byte of a label may be any value
- Negative hex numbers are not handled
- Line comments can't end with EOF
- `space` is optional between tokens, when either is one of `.` `:` `;` `[` `]`
  `*` `/` `\` `'` `"` `#` `$` `-` or `` ` ``. This means that space isn't
  required before or after a label definition, after a macro definition, before
  a negative number, or before or after a char.

Notes:
- Byte-oriented
- The mnemonics look to be inspired by Whitelips IDE and bf.wsa was adapted from
  there
- Labels and macro names cannot be mnemonics
- Numbers are limited to 64 digits when parsing and encoding
- Labels are encoded as signed integers incrementing from 0x4a00 in order of
  definition and are limited to 64 bits
- `'\n'` and `'\t'` escapes are handled, while any other characters are used
  unchanged
- `push 0` and `push -0` are encoded as `SS SSL`
