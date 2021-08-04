# Analysis errors draft

Warnings are for non-portable patterns.

- Error: jump to missing label
- Error: negative `copy` argument
- Error: invalid UTF-8
- Warn: trailing whitespace characters after program
- Warn: invalid UTF-8 after program
- Warn: implicit `end`
- Warn: `slide` count negative
- Warn: `slide` count underflow
- Warn: `push` argument empty
- Warn: `printc` of surrogate (U+D800 to U+DFFF)
- Warn: `printc` out of range (U+0000 to U+10FFFF, i.e. 0 to 1114111)
- Warn: labels differ only by leading zeros
- Warn: label with leading zeros is not valid UTF-8
- Info: unused label
- Info: unused value
- Info: `copy 0` can be replaced with `dup`
