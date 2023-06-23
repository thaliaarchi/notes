# Respace assembly

- Source: [code](https://github.com/thaliaarchi/respace/blob/master/programs/preprocess.sh)
  (last updated [2018-05-20](https://github.com/thaliaarchi/respace/blob/57b1313484880261c623dc5e371bbdd2b39b520f/programs/preprocess.sh))
- Corpus: [cpp/thaliaarchi-respace](https://github.com/wspace/corpus/blob/main/cpp/thaliaarchi-respace/project.json)

## Grammar

```bnf
program ::= (inst lf)*
inst ::=
    | space? (whitelips_inst (sep whitelips_inst)*)?
    | space? "@include" space? "\"" .+? "\""
    | space? "@define" space ident
        ((space | space? macro_params space?) macro_body)?
    | space? ident macro_params?
    | space? "@ifdef" space ident lf program*
      (space? "@else" lf program*)?
      space? "@endif"
whitelips_inst ::= …
macro_params ::=
    | "(" space? ident (space ident)* space? ")"
macro_body ::=
    | (whitelips_inst | number | string)? (sep whitelips_inst)*
ident ::= [a-zA-Z_$][a-zA-Z0-9_$]*
sep ::= space? ";" space?
comment ::= "#" [^\n]*
lf ::= space? comment? ("\n" | EOF)
space ::= \s+
```

where `whitelips_inst` is the [Whitelips](whitelips.md) definition of `inst`,
excluding `include`, `macro`, and macro invocations.

This grammar is stricter than the Respace preprocessor, in an effort to make it
better represent useful programs and express the intent of the syntax.

Respace syntax is a preprocessing layer over Whitelips syntax, using a C
preprocessor. Because of this, there is residue of C syntax (e.g., line
continuations, `//`- and `/*` `*/`–comments, and universal character names) and
Whitelips syntax (e.g., `include`, `macro`, macro invocations, and `--`- and
`{-` `-}`–comments).

Respace allows any C preprocessor directive, where the `#` is replaced with `@`.
Programs only use `@include "…"`, `@define`, `@ifdef`, `@else`, and `@endif`,
and `@include <…>` is not handled. Since the semantics of the other directives
is unclear, they have been excluded. C macros can insert arbitrary tokens, but
this grammar limits it to an optional literal (for an instruction argument),
followed by any number of instructions. The semantics of line continuations
combined with `;`-delimiters is unclear, so they are not included. Token quoting
with `#` and `##` does not work, because of the conflict with `#`-comments. The
`ident` pattern is any valid C identifier, excluding `@`.

Whitelips defines its own macro system. While it would be supported by Respace,
it fills the same purpose as `@define`, so is also excluded from the grammar.
Optional arguments are included, although no program uses them.
