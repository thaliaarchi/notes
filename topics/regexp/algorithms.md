# Exploration of representing specialized string-searching

I want to include matching with the Knuth–Morris–Pratt and Aho–Corasick
string-searching algorithms in my regexp engine.

```rust
enum Regexp {
    /// Matches anything (e.g., `.*`).
    Match,
    /// Character literal.
    Char(char),
    /// String literal.
    String(String),
    /// Unanchored string literal, that captures the first occurrence
    /// (i.e., `.*lit.*`, `.*?(lit).*`, and `.*?(lit).*?`).
    /// Matches using the Knuth–Morris–Pratt algorithm.
    UnanchoredStringFirst(KMP),
    /// Unanchored string literal, that captures the last occurrence
    /// (i.e., `.*(lit).*` and `.*(lit).*?`).
    /// Matches using the Knuth–Morris–Pratt algorithm in reverse.
    UnanchoredStringLast(KMP),
    // …
}

struct KMP { … }
```

Knuth–Morris–Pratt initialization would be performed upon `Regexp` construction.
If the regexp is static, `String`s could be `Box<str>`.

Byte operations could be included or separate. It would probably be advantageous
to always compile string regexps to byte regexps, in which case, the specialized
matchers should be moved to the byte regexp type.

`UnanchoredStringFirst` functions as matching `.*(lit)` followed by a `Match`,
but combined. Could it be used when other expressions follow the literal? The
internal search state would need to be saved, so that it could resume searching,
when the following expression backtracks. I'm unsure whether
`UnanchoredStringLast`, if matching from the right, could meaningfully split off
the preceding or following expressions.

Aho–Corasick would match similarly, but for regexps of the form
`.*(lit|lit|…|lit).*`.
