# Deadfish language

## Semantics

Deadfish is a non-Turing-complete language, that consists of four commands: `i`
(increment), `d` (decrement), `s` (square), and `o` (output). They operate on a
single value, the accumulator, which is a 32-bit integer with wrapping
arithmetic semantics. The accumulator has an initial value of 0. After a
command, if the accumulator is equal to `256` or `-1`, then it is set to `0`
instead. `o` prints a the accumulator as a signed integer.

The [reference implementation](https://esolangs.org/w/index.php?title=Deadfish&oldid=6598),
which was written in C, defines the commands as `x++`, `x--`, `x = x * x`, and
`printf("%d\n", x)`, respectively. The accumulator `x` is defined as
`unsigned int`, but printed as `int`.

The interpreter prints `">> "` before every command and `\n` for any
unrecognized command (essentially another command). Command reading is buffered,
so input and output are not strictly ordered.

## Commands

| Command | Operation         |
| ------- | ----------------- |
| `i`     | Increment         |
| `d`     | Decrement         |
| `s`     | Square            |
| `o`     | Output            |
| other   | Print a line feed |

The only effects from a Deadfish program are the sequence of numbers, prompts,
and blank lines printed, so its intermediate representation can be simply:

| IR instruction  | Operation                   |
| --------------- | --------------------------- |
| `number n`      | Output a number             |
| `prompts count` | Print `">> "` shell prompts |
| `blanks count`  | Print line feeds            |

## Encoding

A Deadfish program can be trivially evaluated to a constant array or string. In
the converse, generating the minimal program to produce a sequence of numbers is
more complicated, which is what makes Deadfish interesting.

Less interesting is the prompt printed for every character in the program
source, including for non-instruction characters. This enforces a constraint on
the number of instructions to produce a number. If the encoding is minimal, yet
the prompt count is less than the path length, that indicates a bug in the
encoder or an impossible constraint. If the prompt count is greater than the
path count, the path needs to be padded. When the path contains 0, it can be
padded with an arbitrary number of `d` instruction. When the padding amount is
even, it can insert repeated `id` or `di` pairs, as appropriate to avoid
resetting to 0. Otherwise, it would need to search for another path.

## Inverses

For all values, except for 255 and 1<<32 - 2, `i` has an inverse with `d`. For
all values, except for 0 and 257, `d` has an inverse with `i`. For all squares,
`s` has an inverse with integer square root. For all modular squares, `s` has
at least one inverse with modular square root.

## Resources

- Implementations by the creator:
  - [C (reference)](https://esolangs.org/w/index.php?title=Deadfish&oldid=6598)
  - [Python](https://esolangs.org/w/index.php?title=Deadfish&oldid=9122#Python)
  - [Creator's site](https://web.archive.org/web/20100425075447/http://www.jonathantoddskinner.com/projects/deadfish.html)
    with [source archives](https://web.archive.org/web/20071019052558/http://www.jonathantoddskinner.com/projects/deadfish.tar.gz)
- [Esolang wiki](https://esolangs.org/wiki/Deadfish)
- Encodings for 0 to 255 on [Code Golf](https://codegolf.stackexchange.com/questions/40124/short-deadfish-numbers)
  and [Esolang](https://esolangs.org/wiki/Deadfish/Constants)
