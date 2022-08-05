# Deadfish language

## Semantics

Deadfish consists of four commands: increment, decrement, square, and output,
which operate on an accumulator. The [reference implementation](https://esolangs.org/w/index.php?title=Deadfish&oldid=6598),
which was written in C, defines the commands as `x++`, `x--`, `x = x * x`, and
`printf("%d\n", x)`, respectively. The accumulator `x` is signed, with the type
`int` (it's defined as `unsigned int`, but printed as signed). After a command,
if `x` is equal to `256` or `-1`, then it is set to `0`.

The interpreter prints `">> "` before every command and `\n` for any
unrecognized command (essentially another command). Command reading is buffered,
so input and output are not strictly ordered.

Deadfish is not Turing complete; however, it can be interesting to search for
minimal programs that will produce a sequence of prints.

## Commands

| Command | Operation         |
| ------- | ----------------- |
| `i`     | Increment         |
| `d`     | Decrement         |
| `s`     | Square            |
| `o`     | Output            |
| other   | Print a line feed |

The only effects from a Deadfish program are the sequence of numbers and blank
lines printed, so its intermediate representation can be simply:

| IR instruction | Operation        |
| -------------- | ---------------- |
| `number n`     | Output a number  |
| `blanks count` | Print line feeds |

## Resources

- Implementations by the creator:
  - [C (reference)](https://esolangs.org/w/index.php?title=Deadfish&oldid=6598)
  - [Python](https://esolangs.org/w/index.php?title=Deadfish&oldid=9122#Python)
  - [Creator's site](https://web.archive.org/web/20100425075447/http://www.jonathantoddskinner.com/projects/deadfish.html)
    with [source archives](https://web.archive.org/web/20071019052558/http://www.jonathantoddskinner.com/projects/deadfish.tar.gz)
- [Esolang wiki](https://esolangs.org/wiki/Deadfish)
