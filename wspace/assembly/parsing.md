# Parsing any Whitespace assembly dialect

## Tokens

- Word
- Integer
- Character: `' '`
- String: `" "`
- Colon: `:`
- Semicolon: `;`
- Comma: `,`
- Left bracket: `[`
- Right bracket: `]`
- Line comment: `#`, `//`, `--`
- Block comment: `/* */`, `{- -}` (nested)
- Space
- Line break: LF, CRLF

Grammar:

```bnf
word           ::= (XID_Start | word_symbol) (XID_Continue | word_symbol)*
word_symbol    ::= [!$%&*+-./<=>?@\\^_|~]
integer        ::= [-+]? (dec_integer | bin_integer | oct_integer | hex_integer)
dec_integer    ::= ([1-9] ("_"* [0-9])* | "0")
bin_integer    ::= "0" [bB] ("_"* [01])*
oct_integer    ::= "0" [oO] ("_"* [0-7])+
hex_integer    ::= "0" [xX] ("_"* [0-9 a-f A-F])+
char           ::= "'" … "'"
string         ::= "\"" … "\""
colon          ::= ":"
semi           ::= ";"
comma          ::= ","
lbracket       ::= "["
rbracket       ::= "]"
line_comment   ::= ("#" | "//" | "--") [^\n]*
block_comment  ::= "/*" .* "*/"
nested_comment ::= "{-" .*? (nested_comment .*?)* "-}"?
space          ::= " " | "\t"
line_break     ::= "\n" | "\r\n"
```

`word_symbol` is all ASCII symbols except for ``:;"'`()[]{}``.

Examples:

- `push 1`: word `push`, space, integer `1` => `push 1`
- `3slide`: integer `3`, word `slide` => `slide 3`
- `-1-`: integer `-1`, word `-` => `push -1`, `sub`
- `^2`: word `^`, integer `2` => `copy 2`

Unicode `XID_Start` and `XID_Continue` properties exclude `Pattern_Syntax`,
which may not be appropriate. Other characters probably need to be included.

Note that leading zeros are forbidden for decimal integers. This is because
leading zeros denote leading zeros in the base-2 Whitespace encoding and 10 is
not a power of two, making it ambiguous. It also avoids confusion with C-style
octal literals.

`[` and `]` are used for Lime Whitespace–style macro definitions. When not in a
macro definition, they should be treated as part of adjacent words.

### Integer literals

Whitespace integer literals are encoded in binary with a sign, or as an empty
sequence without a sign. To allow for representing all patterns of literals,
Whitespace assembly distinguishes leading zeros and allows the empty sequence.

Assembly integer literals can be written in decimal (no prefix), binary (with a
`0b` prefix), octal (`0o`), or hexadecimal (`0x`). In decimal, leading zeros are
forbidden, since 10 is not a power of 2, to avoid ambiguity in the number of
leading zeros to use in binary. In binary, octal, and hexadecimal, a `0` after
the prefix indicates that the rest of the integer is encoded in binary, with
each digit padded to a width of 1, 3, or 4 bits, respectively. The empty integer
is represented as the literal `0b`.

Examples:

| Text   | Whitespace  |
| ------ | ----------- |
| 7      | S TTT       |
| -7     | T TTT       |
| 007    | illegal     |
| 0b1    | S T         |
| 0b01   | S ST        |
| -0b1   | T T         |
| -0b01  | T ST        |
| 0o2    | S TS        |
| 0o02   | S STS       |
| 0o002  | S STSSTS    |
| -0o2   | T TS        |
| -0o02  | T STS       |
| -0o002 | T STSSTS    |
| 0x7    | S TTT       |
| 0x07   | S STTT      |
| 0x007  | S SSSSSTTT  |
| -0x7   | T TTT       |
| -0x07  | T STTT      |
| -0x007 | T SSSSSTTT  |

Although octal and hexadecimal are powers of two and could have leading zeros
unambiguously map to binary, it is confusing.

For example, `0x7` is 111 in binary. In the common case, leading zeros are not
wanted, so this should be encoded as S TTT. If we wanted it padded to the nybble
boundary, the syntax could be `0x07`, which would be encoded as S STTT. With a
leading zero nybble, it would be `0x007` as S SSSS STTT. This behavior is
non-obvious when there are multiple leading zeros.

With this behavior carried over to binary, `0b01` would be S T and `0b001` would
be S ST. In binary, it would be ideal if the bits as written in the literal
corresponded exactly to the encoded bits, but this breaks that intuition. Since
octal and hexadecimal are unlikely to need this leading zero feature, I instead
forbid leading zeros entirely.

It is often useful to write leading zeros, such as when dealing with characters
like writing `0x0a` or `0b00001010` for LF. These should not be padded, which
suggests that a separate syntax for raw binary literals is needed. Perhaps an
`r` prefix like `0xr0a`, `0br00001010`, or only `0r00001010`.

Zeros:

| Whitespace assembly      | Whitespace  |
| ------------------------ | ----------- |
| `0`, `+0`                | S           |
| `-0`                     | T           |
| `00`, `+00`, `-00`       | illegal     |
| `0b`                     |             |
| `+0b`                    | S           |
| `0b0`, `+0b0`            | S S         |
| `0b00`, `+0b00`          | S SS        |
| `-0b`                    | T           |
| `-0b0`                   | T S         |
| `-0b00`                  | T SS        |
| `0o`, `+0o`, `-0o`       | illegal     |
| `0o0`, `+0o0`            | S           |
| `-0o0`                   | T           |
| `0o00`, `+0o00`, `-0o00` | illegal     |
| `0x`,   `+0x`,   `-0x`   | illegal     |
| `0x0`,  `+0x0`           | S           |
| `-0x0`                   | T           |
| `0x00`, `+0x00`, `-0x00` | illegal     |

### Unresolved

The rules for underscores in integers should be compared to other languages. It
may make sense to forbid trailing or multiple consecutive underscores. Trailing
underscores may be problematic when abutted with a word and, if allowed, may
need to be consumed lazily in the integer grammar, so they are a part of the
word token; however, I cannot think of a case where such a token pair would be
parsed separately instead of joined a single identifier.

Perhaps underscores or another symbol could represent leading zeros in
Whitespace assembly numeric literals. Underscores have no semantic meaning in
other languages, though, so this could be confusing. Only allowing leading zeros
in powers-of-two bases seems to still be a better approach.

## Parsing

### Consistent mnemonics

Files must be internally consistent with mnemonics and other syntax options.

Although some other assemblers support multiple mnemonics per instruction, I
don't know of any program that are inconsistent. This could arise, if programs
of differing styles were concatenated, but that would also have issues with
label encoding and would be better supported by imports.

### Resolving semicolon ambiguity

A `;` can denotes a line comment or an instruction delimiter. Parsing should
support both and detect which is used.

First try to parse assuming `;`-comments and detect the style with heuristics as
it goes. If `;`-delimiters cannot be ruled out, try to parse again assuming
`;`-delimiters and accept the AST with fewer errors. `;`-delimiters are far less
common than `;`-comments, so the additional cost when used is acceptable.

The subset of the program with `;`-comments removed will not necessarily be
syntactically valid. If a macro uses `;`-delimiters, the macro terminator could
interpreted as commented out. Instructions do not have this problem, because
they cannot span multiple lines and thus cannot have `;`-comments between
arguments.

There should be few false positives when detecting `;`-delimiters and most
programs cannot be parsed in both styles. Although, this does leave the
possibility for malicious programs, that would be parsed differently with
`;`-comments or `;`-delimiters, I think the benefits outweigh the risk.

### Modes

- Semicolon:
  - Comment
  - Instruction delimiter
- Push:
  - Postfix: `push n`
  - Literal: `n`
- Operands:
  - None
  - Space:
    - `(add|sub|mul|div|mod) (lhs? rhs)?`
    - `store (addr? value)?`
    - `retrieve value?`
  - Comma:
    - `(add|sub|mul|div|mod) ((lhs ",")? rhs)?`
    - `store ((addr ",")? value)?`
    - `retrieve value?`
- Label definition:
  - Colon: `l ":"`
  - Mnemonic: `label l`
  - Sigil: `"@" l`, `"." l`, `"label_" l`, etc.
- Label operand:
  - Postfix: `(call|jmp|jz|jn) l`
  - Prefix: `l (call|jmp|jz|jn)`
- Macro style:
  - Whitelips: `macro name: … $$`
  - Lime: `macro name[…]` (implies that `[` and `]` are tokens)

### Heuristics

- Almost every program will have `push`; detect push style.
- If multiple instructions appear on the same line separated by spaces, then `;`
  denotes a comment.
- If a line starts with a `;` or there are consecutive `;`s, then `;` denotes a
  comment. If a program has one instruction per line, then commented code would
  almost always appear at the start of a line.
- Literal pushes are mutually exclusive with optional arguments or `;`
  separators.
- `:` always denotes a label. It is mutually exclusive with a label mnemonic.
- `,` always denotes an argument delimiter. It is mutually exclusive with
  space-delimited arguments.
- Forth-style calls without the `call` mnemonic are too ambiguous with
  permissive mnemonic inference and not allowed.

## Style

- Consistent mnemonic names
- Consistent mnemonic casing
- Analogous mnemonic naming (e.g. not `printc` and `outnum` together)
- Consistent comment styles
