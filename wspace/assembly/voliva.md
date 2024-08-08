# voliva assembly

- Source: [code](https://github.com/voliva/wsa)
  (last updated [2024-07-25](https://github.com/voliva/wsa/commit/3a99669b57f266e7328143e49579f6d33da7c6f5))
- Corpus: [typescript/voliva-wsa](https://github.com/wspace/corpus/blob/main/typescript/voliva-wsa/project.json)

## Grammar

```bnf
program ::= (line "\n")* line?
line ::=
    | WHITESPACE instruction WHITESPACE
    | WHITESPACE comment
comment ::= ";" .*

# BUG: Arities are not enforced.
# BUG: Mnemonics are compared using String.prototype.toLocaleLowerCase, which
# has locale-aware case folding. Thus, in Turkish (tr) and Azeri (az) locales,
# İ (U+0130, LATIN CAPITAL LETTER I WITH DOT ABOVE) compares equal to i (U+0069,
# LATIN SMALL LETTER I). In all locales, K (U+212A, KELVIN SIGN) compares equal
# to k (U+006B, LATIN SMALL LETTER K), but no mnemonics use k. The characters
# used are [a-eg-jl-pr-z].
instruction ::=
    | (?i)"push" required_int
    | (?i)"dup" ignored
    | (?i)"copy" required_int
    | (?i)"swap" ignored
    | (?i)"pop" ignored
    | (?i)"slide" required_int
    # When non-empty, that number is pushed before the operation. As an
    # optimization, add 0, sub 0, mul 1, and div 1 are substituted with nothing
    # (where 0 and 1 are the parsed values).
    | (?i)"add" optional_int
    | (?i)"sub" optional_int
    | (?i)"mul" optional_int
    | (?i)"div" optional_int
    | (?i)"mod" optional_int
    | (?i)"and" ignored
    | (?i)"or" ignored
    | (?i)"not" ignored
    | (?i)"store" optional_int
    | (?i)"storestr" required_string
    | (?i)"retrieve" optional_int
    | (?i)"label" required_label
    | (?i)"call" required_label
    | (?i)"jump" required_label
    | (?i)"jumpz" required_label
    | (?i)"jumpn" required_label
    | (?i)"jumpp" required_label
    | (?i)"jumpnz" required_label
    | (?i)"jumppz" required_label
    | (?i)"jumppn" required_label
    | (?i)"jumpnp" required_label
    | (?i)"ret" ignored
    | (?i)"exit" ignored
    | (?i)"outn" ignored
    | (?i)"outc" ignored
    | (?i)"readn" ignored
    | (?i)"readc" ignored
    | (?i)"valuestring" SPACE ident (SPACE arg)?
    | (?i)"valueinteger" SPACE ident (SPACE bigint)?
    | (?i)"debugger" ignored
    | (?i)"include" (SPACE arg)?

# BUG: A value can be omitted and it is 0 when empty.
required_int ::= (SPACE int)?
# When empty (not including the SPACE), no argument is present.
optional_int ::= (SPACE int)?
# Labels are unrestricted.
required_label ::= (SPACE arg)?
required_string ::= (SPACE string)?

int ::=
    | bigint
    | char
    | ident
string ::=
    | arg
    | ident
    # BUG: A char should not be valid here; it is converted to a BigInt, then to
    # a string, then to codepoints.
    | char
char ::= "'" . "'"
ident ::= "_" NON_SPACE*
arg ::= .*
ignored ::= (SPACE arg)?

# BigInt constructor (ref. https://tc39.es/ecma262/multipage/abstract-operations.html#sec-stringtobigint).
bigint ::=
    | WHITESPACE? bigint_integer WHITESPACE?
    | WHITESPACE? # Empty is 0
# Note: A 0-prefixed number is decimal not octal and _ digit separators and
# non-decimal signs are not supported.
bigint_integer ::=
    | ("-" | "+") [0-9]+
    | ("0b" | "0B") [01]+
    | ("0o" | "0O") [0-7]+
    | ("0x" | "0X") [0-9 a-f A-F]+

# Whitespace and line terminators in BigInt constructor (ref. https://tc39.es/ecma262/multipage/abstract-operations.html#prod-StrWhiteSpaceChar)
# and in String.prototype.trim (ref. https://tc39.es/ecma262/multipage/text-processing.html#sec-string.prototype.trim).
WHITESPACE ::=
    | <TAB> | <VT> | <FF> | <ZWNBSP> | <USP>
    | <LF> | <CR> | <LS> | <PS>

SPACE ::= " "
NON_SPACE ::= [^ ]
```

## Bugs in the assembler

- Arities are not enforced.
- Mnemonics are compared with locale-aware Unicode case folding.
- `storestr` with a character literal is invalid.
