# littleBugHunter assembly

- Corpus: [csharp/littlebughunter-assembler](https://github.com/wspace/corpus/blob/main/csharp/littlebughunter-assembler/project.json)
- Source: [code](https://github.com/littleBugHunter/WhitespaceAssembler),
  [docs](https://github.com/littleBugHunter/WhitespaceAssembler/blob/master/README.md)
  (last updated [2019-12-27](https://github.com/littleBugHunter/WhitespaceAssembler/tree/fd8a7a0189537507cc29eac4e286386192c8b6e7))

## Grammar

```bnf
program ::= (trim_space? (inst | comment)? trim_space? line_break)*
            trim_space? (inst | comment)? trim_space? line_break?
inst ::=
    | "push" space (number | variable)
    | "dup"
    | "swap"
    | "pop"
    | "add" arith_op
    | "sub" arith_op
    | "mul" arith_op
    | "div" arith_op
    | "mod" arith_op
    | "store" (space number (space number)?)?
    | "retrieve" (space number)?
    | "lbl" space label
    | "call" space label
    | "jmp" space label
    | "jpz" space label
    | "jpn" space label
    | "ret"
    | "exit"
    | "print_char"
    | "print_number"
    | "read_char"
    | "read_number"
arith_op ::=
    | ε
    | space number
    | space variable
    | space variable space number
    | space number space variable
    | space variable space variable

number ::=
    | [0-9]+
    | "#" [0-9 a-f A-F]+
    | "'" . "'"
    | "&" .*?
label ::= "." .*?
variable ::= "*" .*?
comment ::= "//" .*?

line_break ::= "\n" | "\r" | "\r\n"
space ::= [ \t]+
trim_space ::= (Char.IsWhiteSpace NOT line_break)+
```

Opcodes are matched case-insensitively.

[Char.IsWhiteSpace](https://learn.microsoft.com/en-us/dotnet/api/system.char.iswhitespace?view=net-8.0#system-char-iswhitespace(system-char))
allows many more characters than just space and tab.

## Optional arguments

- `push var` -> `push addr`, `retrieve`
- `add num` -> `push num`, `add`
- `add var` -> `push addr`, `retrieve`, `add`
- `add var num` -> `push addr`, `retrieve`, `push num`, `add`
- `add num var` -> `push num`, `push addr`, `retrieve`, `add`
- `add var1 var2` -> `push addr1`, `retrieve`, `push addr2`, `retrieve`, `add`
- `store num` -> `push num`, `swap`, `store`
- `store num1 num2` -> `push num2`, `push num1`, `store`
- `retrieve num` -> `push num`, `retrieve`

## Parsing

Numbers are parsed and stored as signed 32-bit integers and cannot be outside
those bounds. Hex numbers are parsed as unsigned 32-bit integers, but
interpreted as signed.

## Encoding

Variables are assigned addresses, incrementing from 0, in order of first use
(variables are not defined). Labels are encoded as numbers, incrementing from 0,
in order of first use or definition.

## Bugs in the assembler

- Numbers cannot have a negative sign
- The actual pattern for chars is `'..`, not `'.'`
- The empty variable name, i.e., `&`, is allowed
- The trimmed and delimiter whitespace characters don't match
