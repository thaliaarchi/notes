# Whitelips assembly

- Source: [code](https://github.com/vii5ard/whitespace/blob/master/ws_asm.js),
  [docs](https://vii5ard.github.io/whitespace/help.html#assembly)
  (last updated [2023-07-14](https://github.com/vii5ard/whitespace/tree/3745b952b731f0bc7d60c0eabe99210ff5bc72ab))
- Corpus: [javascript/vii5ard-whitelips](https://github.com/wspace/corpus/blob/main/javascript/vii5ard-whitelips/project.json)

## Grammar

```bnf
program ::= space? (inst space)* inst? space?
inst ::=
    | "push" space (number | string)
    | "dup"
    | "copy" space number
    | "swap"
    | "drop"
    | "slide" space number
    | "add" (space number)?
    | "sub" (space number)?
    | "mul" (space number)?
    | "div" (space number)?
    | "mod" (space number)?
    | "store"
    | "retrieve" (space number)?
    | label ":"
    | "label" space label
    | "call" space label
    | "jmp" space label
    | "jz" space label
    | "jn" space label
    | "ret"
    | "end"
    | "printc"
    | "printi"
    | "readc" (space number)?
    | "readi" (space number)?
    | "include" space string
    | "macro" space label ":" space? (macro_inst space)* "$$"
    | label (space (label | number | string))*
macro_inst ::=
    | inst
    | "$label"
    | "$number"
    | "$string"
    | "$redef"
    | "$" [0-9]+

label ::= [a-zA-Z_$.][a-zA-Z0-9_$.]*
number ::= [+-]?\d*
string ::=
    | "\"" ([^"\n\\] | \\[nt] | \\[0-9]+ | \\.)*? "\""
    | "'" ([^'\n\\] | \\[nt] | \\[0-9]+ | \\.)*? "'"
space ::= ([ \t\n\r] | comment)+
comment ::=
    | ";" [^\n]*
    | "#" [^\n]*
    | "--" [^\n]*
    | "{-" .*? "-}" | "{-" .* EOF
```

The pattern `.` includes `\n` here.

## Semantics

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

`include` assembles the named file, with all already seen symbols visible to the
child assembler, and appends it to the end of the including file. Only the first
`include` for a filename is expanded. `include`s are not expanded in a macro
definition.

### Macros

Macros are only applied when the types of the successive tokens match the
parameter types expected by the macro. When the argument types do not match, if
it has the name of a mnemonic, that instruction is used instead; otherwise, the
macro invocation is silently replaced with nothing.

A macro can be named anything, that's a valid label token. This includes
instruction mnemonics, the names of previously defined macros, or labels. It
only shadows a mnemonic if the arguments are of the appropriate types. Macros
shadow previously defined macros of the same name. Macros do not expand in label
position, so do not conflict with labels. Unless shadowed, `$$`, `$label`,
`$number`, `$string`, and `$redef` are reserved outside of a macro. The `$n`
label form is not reserved. A macro named as any of these keywords cannot be
referenced within a macro.

Labels can be generated in a macro using the form `$n`, where `n` is a decimal
number. These are replaced with a token of the form `.__id__n__`, where `id` is
the global count of macro expansions, starting from 1.

A macro cannot contain `$$`, so it cannot expand to a full macro definition
without the caller adding `$$`.

Macros are in scope for their body and any successive instructions, as well as
any files included after the definition. Macros defined in an included file are
introduced into the scope of the parent file. Macros are supposed to have a
recursion depth of 16, but it does not seem to work.

## Notes

- UTF-8–oriented
- Uses `BigInt` for numbers and string characters
- Labels are assigned sequentially from `0` in definition order
- Multiline comments are not nested

## Bugs in the assembler

- Macro recursion is not properly implemented or restricted

### Bugs fixed in my fork

- The mnemonic label definition form does not scope local labels
- `call`, `jmp`, `jz`, and `jn` allow numbers as arguments, but label resolution
  always fails, because labels cannot be defined by numbers
- `{-`-comments can be unterminated
- Space is optional after a label reference or number, if followed by a
  `;`-comment, but is required when followed by other comments or a string.
  Space is optional after a string or comment.
- It uses `\s` sometimes instead of `[ \t\n\r]`, so these extra space characters
  would become the start of a label token
