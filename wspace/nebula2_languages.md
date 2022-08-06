# Nebula 2 languages

## Whitespace

Nebula 2 will support all but the most malformed Whitespace programs.

### Syntaxes

- [x] Whitespace
- [x] Arbitrary mappings
- [x] Bit packed
- [ ] Whitespace assembly (partial)
- [ ] Whitespace Forth
- [ ] GrassMudHorse (partial)

### Instructions

- [ ] Whitespace 0.1 (research needed)
- [x] Whitespace 0.2 and 0.3
- [x] Extensions: `shuffle`, `debug_printstack` and `debug_printheap`, and
  `trace`

### Transformations

- Constraining arbitrary-precision integers
- Converting between versions: 0.3 -> 0.2 and converting debug extensions

It aims to bring excellent tooling to Whitespace, with planned components
including an optimizing compiler, modular intermediate language, interpreter,
and language server.

I aim to have a working release by 1 April 2023, the 20th anniversary of the
Whitespace 0.2 [public release](https://web.archive.org/web/20150717220656/http://compsoc.dur.ac.uk:80/whitespace/explanation.php).

## Brainfuck

- Syntaxes:
  - [x] Brainfuck
  - [ ] Arbitrary mappings
  - [x] Mappings: Ook! and Spoon
- Instructions:
  - [ ] Extensions: `#` and `!` (Brainfuck)
  - [x] Extensions: `Ook? Ook?` (Ook!), `DEBUG` and `EXIT` (Spoon)

## Deadfish

- [ ] Syntaxes: `i d s o` and arbitrary mappings
- [x] Dialects: `deadfish::Inst` and `deadfish::Ir`
- Transformations:
  - [x] Breadth-first search encoding heuristic
  - [ ] Square root encoding heuristic (partial)
