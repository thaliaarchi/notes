# Syntax error recovery

## Background

Whitespace syntax is not [self-synchronizing](https://en.wikipedia.org/wiki/Self-synchronizing_code),
so syntax errors in the middle of a Whitespace document change the
meaning of the following instructions. Programs often have missing or
or extra line feeds at the end when copied from webpages, but this only
affects the final instruction. When editing a document, however,
insertions and deletions outside of numbers, labels, and comments will
invalidate later instructions. To improve the editing experience,
error-recovery heuristics are needed to invalidate the smallest ranges
possible.

## Long lines

A long line is usually a control flow instruction with a UTF-8 label or
has a large `push` at the end.

To detect a labeled instruction:

1. Decode the line as UTF-8 (S is 0, T is 1) in reverse from the right
   in groups of 8, until less than 8 characters remain. This is the
   label.
2. Check the start of the line before the label:
   - If two characters remain, consume L from the previous line and emit
     the matched instruction:
     - LSS ...L: `label`
     - LST ...L: `call`
     - LTS ...L: `jz`
     - LTT ...L: `jn`
   - If no characters remain and the line is preceded with LSL, then
     consume LSL and emit `jmp`:
     - LSL ...L: `jmp`
3. If a UTF-8 encoding error is encountered, then try to interpret it
   instead as an integer label in the range [0, 256) without leading
   zeros:
   - If the line starts with S(S|T)T and is 10 characters long or less,
     consume L from the previous line and emit the matched instruction:
     - LSS T...L: `label`
     - LST T...L: `call`
   - If the line starts with T, is 8 characters long or less, and is
     preceded by LSL, then consume LSL and emit `jmp`:
     - LSL T...L: `jmp`
   - If the line starts with T(S|T)T and is 10 characters long or less,
     consume L from the previous line and emit the matched instruction:
     - LTS T...L: `jz`
     - LTT T...L: `jn`

Otherwise, the line likely ends with a `push`. There may be zero or more
`add`, `sub`, `div`, `mod`, `store`, or `retrieve` instructions before
the push. Since the start of the `push` cannot be determined by scanning
backwards, skip this line and resume parsing on the next line.

## Undefined instructions

Since the Whitespace instruction prefix tree is not full, there are some
sequences that an instruction can not start with: STT, TSTL, TSL, TTL,
TLSL, TLTL, TLL, LLS, and LLT. Assume then, that any occurrences of
these sequences are valid and occur elsewhere in an instruction. Those
contain L can not occur within numbers or labels, so some combinations
are unambiguous.
