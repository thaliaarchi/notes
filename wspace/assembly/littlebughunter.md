# littleBugHunter assembly

- Corpus: [csharp/littlebughunter-assembler](https://github.com/wspace/corpus/blob/main/csharp/littlebughunter-assembler/project.json)
- Source: [code](https://github.com/littleBugHunter/WhitespaceAssembler),
  [docs](https://github.com/littleBugHunter/WhitespaceAssembler/blob/master/README.md)
  (last updated [2019-12-27](https://github.com/littleBugHunter/WhitespaceAssembler/tree/fd8a7a0189537507cc29eac4e286386192c8b6e7))

```bnf
program ::= (trim_space* (inst | comment)? trim_space* line_break)*
            trim_space* (inst | comment)? trim_space* line_break?
inst ::=
    | "push" space+ (number | star)
    | "dup"
    | "swap"
    | "pop"
    | "add" arith_op
    | "sub" arith_op
    | "mul" arith_op
    | "div" arith_op
    | "mod" arith_op
    | "store" (space+ number (space+ number)?)?
    | "retrieve" (space+ number)?
    | "lbl" space+ label
    | "call" space+ label
    | "jmp" space+ label
    | "jpz" space+ label
    | "jpn" space+ label
    | "ret"
    | "exit"
    | "print_char"
    | "print_number"
    | "read_char"
    | "read_number"
arith_op ::=
    | ε
    | space+ number
    | space+ star
    | space+ star space+ number
    | space+ number space+ star
    | space+ star space+ star
number ::=
    | [0-9] …
    | "&" …
    | "#" …
    | "'" . "'"
label ::= "." …
star ::= "*" …
comment ::= "//" .+

line_break ::= "\n" | "\r" | "\r\n"
space ::= " " | "\t"
trim_space ::= Char.IsWhiteSpace NOT line_break
```

TODO: How does the subscript operator work for strings? Bytes?

Notes:
- Opcodes are matched case-insensitively

Bugs in the assembler:
- Negative numbers are not allowed
- The actual pattern for chars is `'..`, not `'.'`
