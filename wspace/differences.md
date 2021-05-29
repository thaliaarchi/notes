# Implementation differences

## EOF

- 0
- -1
- error

## Number arguments

- empty allowed
- sign-only allowed

## Label arguments

- empty allowed
- leading zeros are unique
- allowed character set for ASCII label translation

## Duplicate labels

- disallowed
- use first
- use last
- use next
- use previous
- use arbitrary
- leading zeros distinguishing

## Integer bounds

- arbitrary precision
- 64-bit int
- 32-bit int
- 16-bit int
- 8-bit int
- 53-bit float

## Heap bounds

- (-inf, inf)
- [0, inf)
- [0, bound]
- [-bound, bound]

## Characters

- ASCII (byte)
- UTF-8
- UTF-16

## Number reading

- leading/trailing spaces allowed
- one per line or multiple allowed
- thousands separators
- exponents
- hex
- binary
- floating point
- panic on bad format

## Flushing

- Flush each char (pi.ws)
- Flush before print (calc.ws):
  - wspace-0.3: yes
  - LOLCODE: no

## Division

- divide by zero panic or continue

## Modulo

- sign of dividend
- sign of divisor
- modulo by zero panic or continue

## Extended instructions

- pushs appends NUL or not

## Laziness

- parsing

## Other

wspace 0.3 quirks as explained in
[BlueSpace docs](https://cpjsmith.uk/whitespace):

> Known incompatibilities between BlueSpace 1.1 and WSpace 0.3:
>
> - The ReadNumber instruction (tab-linefeed-tab-tab): WSpace accepts
>   spaces between the negative sign and the number (e.g. - 123 is
>   accepted as equivalent to -123) which BlueSpace does not.
>   Conversely, BlueSpace accepts a leading plus. (e.g. +12 is
>   equivalent to 12) which is rejected by WSpace.
> - WSpace ignores all trailling characters after the last point in the
>   code that is visited; BlueSpace requires the entire input to be a
>   valid Whitespace program. For example, the program consisting of
>   four linefeeds is the null program according to WSpace, but
>   BlueSpace reports a syntax error since the fourth linefeed does not
>   constitute a valid command. This is due to WSpace's lazy parsing
>   semantics.
> - If a program defines the same label more than once, WSpace jumps to
>   the first instance, while BlueSpace jumps to the last. I consider
>   such a program to be erroneous and later versions of BlueSpace may
>   report this as such.
