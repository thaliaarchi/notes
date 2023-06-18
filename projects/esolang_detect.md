# Detecting esolang polyglots

Language polyglots could be detected by scanning for the tokens in all
recognized languages and counting occurrences. Esolangs often ignore any text
outside their grammar, making them ideal for writing polyglots.

Multi-character tokens could be scanned by Aho–Corasick with overlapping search:

- Whitespace: `[Space]` `[Tab]` `[LF]`
  - Gorispace (en): `hoo` `hooo` `hoooo` `hoos` `hooos` `hoooos` `wraagh`
    `wraaagh` `wraaaagh`
- Ook!: `Ook.` `Ook?` `Ook!`
- Nospace: `func` `let` `if` `elsif` `else` `while` `return` `==` `!=` `<=` `>=`
  `+=` `-=` `*=` `/=` `%=` (perhaps less false positives when including colons
  after keywords)

Single-character tokens could be detected by simple UTF-8 codepoint iteration
and lookups:

- Whitespace: space, tab, LF
  - GrassMudHorse: `草` `泥` `马` `河` `蟹`
  - Gorispace (ja): `ウ` `ホ` `ッ` `ー`
  - Tomato: `番` `茄` `干`
  - szm: `水` `沝` `淼`
- Brainfuck: `>` `<` `+` `-` `.` `,` `[` `]`
  - Spoon: `0` `1`
- AsciiDots: `~` `#` `@` `$` `[` `]` `{` `}` `-` `|` `:` `;` `\` `/` `(` `)` `>`
  `<` `^` `v` `*` `` ` `` `+` `-` `*` `/` `÷` `%` `^` `&` `o` `x` `=` `!` `≠`
  `>` `G` `≥` `<` `L` `≤`
- Deadfish: `i` `d` `s` `o`
- Aheui: Hangul Syllables Unicode block (U+AC00–U+D7A3)
- Nospace: `(` `)` `{` `}` `[` `]` `<` `>` `=` `:` `;` `,` `+` `-` `*` `/` `%`
  `!` `&`
