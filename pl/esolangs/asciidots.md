# AsciiDots

- [Language documentation](https://ajanse.me/asciidots/language/)
- [Reference interpreter](https://github.com/aaronjanse/asciidots)
- [Esolang wiki](https://esolangs.org/wiki/AsciiDots)

| Op      | Effect             |
| ------- | ------------------ |
| ` `     | dead               |
| `~`     |                    |
| `#`     | value              |
| `@`     | id                 |
| `$`     | print              |
| `[` `]` | vert -> dead       |
| `{` `}` | vert -> dead       |
| `-`     | vert -> dead       |
| `\|`    | horiz -> dead      |
| `:`     | value == 0 -> dead |
| `;`     | value == 1 -> dead |
| `\`     | (x, y) -> (y, x)   |
| `/`     | (x, y) -> (-y, x)  |
| `(`     | right              |
| `)`     | left               |
| `>`     | vert -> right      |
| `<`     | vert -> left       |
| `^`     | horiz -> up        |
| `v`     | horiz -> down      |
| `*`     | duplicate          |
| `` ` `` | comment start      |

## Operations

| Symbol     | Python | Operation                |
| ---------- | ------ | ------------------------ |
| `+`        | `+`    | Addition                 |
| `-`        | `-`    | Subtraction              |
| `*`        | `*`    | Multiplication           |
| `/` or `÷` | `/`    | Division                 |
| `%`        | `%`    | Modulus                  |
| `^`        | `**`   | Exponent                 |
| `&`        | `&`    | Boolean AND              |
| `o`        | `\|`   | Boolean OR               |
| `x`        | `^`    | Boolean XOR              |
| `=`        | `==`   | Equal to                 |
| `!` or `≠` | `!=`   | Not equal to             |
| `>`        | `>`    | Greater than             |
| `G` or `≥` | `>=`   | Greater than or equal to |
| `<`        | `<`    | Less than                |
| `L` or `≤` | `<=`   | Less than or equal to    |

Grammar revisions:
- Changed `≥` to `G` and `≤` to `L` (2017-09-09, [#27](https://github.com/aaronjanse/asciidots/pull/27))
- Removed `÷` and `≠` aliases (2017-09-10, [#26](https://github.com/aaronjanse/asciidots/issues/26))
