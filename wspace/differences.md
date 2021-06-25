# Implementation differences

Syntax:

- LF
  - LF (wspace)
  - LF, CRLF
  - LF, CRLF, CR
- Number `0`
  - requires sign and bits (conrad)
  - requires sign (wspace)
  - may omit sign (Nebula)
- Label `0`
  - requires bits (conrad)
  - empty allowed (wspace)
- Label leading zeros
  - leading zeros are unique (wspace)
  - leading zeros are ignored (Nebula)
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
  - UTF-8, error on invalid (wspace)
  - UTF-16, error on invalid
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
  - disallowed
- Trailing space
  - allowed (wspace)
  - disallowed
- Space between sign and number
  - allowed (wspace)
  - disallowed (BlueSpace)
- Positive `+` sign
  - allowed (BlueSpace)
  - disallowed (wspace)
- Hex with `0x` prefix
  - allowed (wspace)
  - disallowed
- Octal with `0o` prefix
  - allowed (wspace)
  - disallowed
- Binary with `0b` prefix
  - allowed
  - disallowed (wspace)
- `0` prefix
  - decimal (wspace)
  - octal
- Thousands `,` separator
  - allowed
  - disallowed (wspace)
- `_` separator
  - allowed
  - disallowed (wspace)
- Exponents
  - allowed
  - disallowed (wspace)
- Floating point
  - allowed
  - disallowed (wspace)
- On bad format
  - error (wspace)
  - 0
- Number delimiter
  - line break (TODO: LF/CRLF/CR) (wspace)
  - whitespace

`printi` number format:

- Large numbers
  - exact (wspace)
  - exponential notation (wsjq)
  - rounded
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
