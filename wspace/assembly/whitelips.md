# Whitelips IDE (javascript/vii5ard-whitelips-ide)

[[code](https://github.com/vii5ard/whitespace/blob/master/ws_asm.js)]
[[docs](https://vii5ard.github.io/whitespace/help.html)]

```bnf
program ::= space* (inst space+)* inst? space*
inst ::=
    | "push" space+ (number | string)
    | "dup"
    | "copy" space+ number
    | "swap"
    | "drop"
    | "slide" space+ number
    | "add" (space+ number)?
    | "sub" (space+ number)?
    | "mul" (space+ number)?
    | "div" (space+ number)?
    | "mod" (space+ number)?
    | "store"
    | "retrieve" (space+ number)?
    | word ":"
    | "label" space+ word
    | "call" space+ word
    | "jmp" space+ word
    | "jz" space+ word
    | "jn" space+ word
    | "ret"
    | "end"
    | "printc"
    | "printi"
    | "readc" (space+ number)?
    | "readi" (space+ number)?
    | "include" space+ string
    | "macro" space+ word ":" … "$$"

keywords ::=
    | "$$"
    | "$label"
    | "$number"
    | "$string"
    | "$redef"

token ::=
    | word
    | word ":"
    | number
    | string
    | space
word ::= [0-9a-zA-Z_$.]+
number ::= [+-]?\d*
string ::=
    | "\"" ([^"\n\\] | \\[nt] | \\[0-9]+ | \\.)*? "\""
    | "'" ([^'\n\\] | \\[nt] | \\[0-9]+ | \\.)*? "'"
space ::=
    | [ \t\n\r]+
    | ";" [^\n]*
    | "#" [^\n]*
    | "--" [^\n]*
    | "{-" .*? "-}"
```

Strings may contain escape sequences: `\n` as LF; `\t` as tab; `\` followed by
greedy decimal digits, parsed as the decimal value; or `\` followed by a UTF-16
code unit (including LF, allowing for line continuations). `"`-strings are
NUL-terminated, but `'`-strings are not.

Labels starting with `.` are local labels. A non-local label definition (the
parent) opens a block until the next non-local label definition. Any local label
definitions and references in a block are scoped to that block and are encoded
by prepending the parent label to the local labels. The entry block before the
first non-local label prepends nothing. The mnemonic label definition form does
not scope local labels.

Macros are only applied when the types of the successive tokens match the
parameter types expected by the macro. Macros names can shadow mnemonics as a
way to overload them. When the argument types do not match, if the name shadows
a mnemonic, that instruction is used instead; otherwise, the macro invocation is
replaced with nothing.

Bugs in the assembler:
- The mnemonic label definition form does not scope local labels
- `call`, `jmp`, `jz`, and `jn` allow numbers as arguments, but label resolution
  always fails, because labels cannot be defined by numbers
- Space is optional after a word or number, if followed by a `;`-comment, but is
  required when followed by other comments or a string. Space is optional after
  a string or comment.
- It uses `\s` sometimes instead of `[ \t\n\r]`, so these extra space characters
  would become start word token

Notes:
- UTF-16 code unit–oriented
- Uses `BigInt` for numbers and string characters
- Labels are assigned sequentially from `0` in definition order
- Multiline comments are not nested
- The pattern `.` includes `\n` here
