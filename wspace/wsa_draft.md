# Whitespace Assembly Syntax

## Tokens

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

## Style

- consistent mnemonic names
- consistent mnemonic casing
- analogous mnemonic naming (e.g. not `printc` and `outnum` together)
- consistent comment styles
