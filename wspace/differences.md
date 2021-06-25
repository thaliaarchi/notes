# Implementation differences

Syntax:

- LF
  - LF (wspace)
  - LF, CRLF
  - LF, CRLF, CR
- Number `0`
  - requires sign and bits
  - requires sign (wspace)
  - may omit sign (Nebula)
- Label `0`
  - empty allowed
- Labels
  - leading zeros distinguishing
- Label character set
  - `[A-Za-z_][A-Za-z0-9_]*` (rdebath)
- Laziness
  - lazy (wspace)
  - eager (Nebula, BlueSpace)
- Duplicate labels
  - error (Nebula)
  - use first (wspace)
  - use last (BlueSpace)
  - use next
  - use previous
  - use arbitrary

Bounds:

- Number bounds
  - arbitrary precision (wspace)
  - 64-bit int (Nebula)
  - 32-bit int
  - 64-bit float (wsjq)
- Heap bounds
  - (-inf, inf)
  - [0, inf)
  - [0, max]
  - [min, max]

I/O:

- Character set
  - ASCII
  - UTF-8
  - UTF-16
- Reading line breaks
  - CRLF is collapsed to LF (wsjq on Windows)
- EOF behavior
  - error (wspace)
  - 0
  - -1
- Flushing
  - flush after print, e.g. pi.ws (wspace)
  - flush before read, e.g. calc.ws
  - buffered (LOLCODE)

`readi` number format:

- Leading space
  - allowed (wspace)
- Trailing space
  - allowed (wspace)
- Space between sign and number
  - allowed (wspace)
- Positive `+` sign
  - allowed (BlueSpace)
  - disallowed (wspace)
- Number delimiter
  - line break (TODO: LF/CRLF/CR) (wspace)
  - whitespace
- Hex `0x` format
  - allowed (wspace)
- Octal `0o` prefix
  - allowed (wspace)
- Binary `0b` prefix
  - disallowed (wspace)
- `0` prefix
  - decimal (wspace)
  - octal
- Thousands `,` separator
  - disallowed (wspace)
- `_` separator
  - disallowed (wspace)
- Exponents
  - disallowed (wspace)
- Floating point
  - disallowed (wspace)
- On bad format
  - error (wspace)
  - 0

`printi` number format:

- Exponential notation for large numbers
  - yes (wsjq)
- Signed zero
  - positive zero
  - positive zero and negative zero

Division and modulo:

- Zero divisor
  - error (wspace)
  - undefined behavior
- Division rounding
  - truncated
  - floored
  - Euclidean
  - ceiling
  - rounding
