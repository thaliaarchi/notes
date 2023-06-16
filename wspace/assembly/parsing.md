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
- Line break: LF, CRLF, CR

Grammar:

```bnf
word          ::= XID_Start XID_Continue*
integer       ::= dec_integer | bin_integer | oct_integer | hex_integer
dec_integer   ::= /[-+]?[1-9][0-9_]*|0*/
bin_integer   ::= /[-+]?0[bB][01_]*/
oct_integer   ::= /[-+]?0[oO]_*[0-7][0-7_]*/
hex_integer   ::= /[-+]?0[xX]_*[0-9a-fA-F][0-9a-fA-F_]*/
char          ::= "'" … "'"
string        ::= "\"" … "\""
colon         ::= ":"
semi          ::= ";"
lbrack        ::= "["
rbrack        ::= "]"
comma         ::= ","
line_comment  ::= "#" … | "//" … | "--" …
block_comment ::= "/*" … "*/" | "{-" … "-}"
space         ::= " " | "\t"
line_break    ::= "\n" | "\r\n" | "\r"
```

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

| Text   | Whitespace |
| ------ | ---------- |
| 0      | S          |
| -0     | T          |
| 7      | S TTT      |
| -7     | T TTT      |
| 00     | illegal    |
| 007    | illegal    |
| 0b     |            |
| 0b0    | S          |
| 0b00   | S S        |
| 0b000  | S SS       |
| -0b    | illegal    |
| -0b0   | T          |
| -0b00  | T S        |
| -0b000 | T SS       |
| 0b1    | S T        |
| 0b01   | S ST       |
| -0b1   | T T        |
| -0b01  | T ST       |
| 0o     | illegal    |
| 0o0    | S          |
| 0o00   | S SSS      |
| 0o2    | S TS       |
| 0o02   | S STS      |
| 0o002  | S STSSTS   |
| -0o    | illegal    |
| -0o0   | T          |
| -0o00  | T SSS      |
| -0o2   | T TS       |
| -0o02  | T STS      |
| -0o002 | T STSSTS   |
| 0x     | illegal    |
| 0x0    | S          |
| 0x00   | S SSSS     |
| 0x7    | S TTT      |
| 0x07   | S STTT     |
| 0x007  | S SSSSSTTT |
| -0x    | illegal    |
| -0x0   | T          |
| -0x00  | T SSSS     |
| -0x7   | T TTT      |
| -0x07  | T STTT     |
| -0x007 | T SSSSSTTT |

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
