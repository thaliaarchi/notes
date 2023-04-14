# Whitespace assembly syntax

## Integer literals

Whitespace integer literals are encoded in binary with a sign, or as an empty
sequence without a sign. To allow for representing all patterns of literals,
Whitespace assembly distinguishes leading zeros and allows the empty sequence.

Assembly integer literals can be written in decimal (no prefix), binary (with a
`0b` prefix), octal (`0o`), or hexadecimal (`0x`). In decimal, leading zeros are
forbidden, since 10 is not a power of 2, to avoid ambiguity in the number of
leading zeros to use in binary. In binary, octal, and hexadecimal, a `0` after
the prefix indicates that the rest of the number is encoded in binary, with each
digit padded to a width of 1, 3, or 4 bits, respectively. The empty integer is
represented as the literal `0b`.

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
| 0o2    | S TS       |
| 0o02   | S STS      |
| 0o002  | S STSSTS   |
| -0o2   | T TS       |
| -0o02  | T STS      |
| -0o002 | T STSSTS   |
| 0x7    | S TTT      |
| 0x07   | S STTT     |
| 0x007  | S SSSSSTTT |
| -0x7   | T TTT      |
| -0x07  | T STTT     |
| -0x007 | T SSSSSTTT |

## Permissive mode

### Tokens

- instruction mnemonic
- identifier
- unsigned integer
- signed integer
- char:                 `''`
- string:               `""`
- colon:                `:`
- semicolon:            `;`
- line comment:         `#`, `//`, `--`
- block comment:        `/* */`
- nested block comment: `{- -}`, `(* *)`
- line break:           LF, CRLF

### Style

- consistent mnemonic names
- consistent mnemonic casing
- analogous mnemonic naming (e.g. not `printc` and `outnum` together)
- consistent comment styles
