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
Whitelips already allows multiple instructions on a line. Optional arguments are
included, although no program uses them.

## Changes to Whitelips since Respace

([Compare Whitelips by commits](https://github.com/vii5ard/whitespace/compare/b19aedadc672e2110d8833a93f93639a48c49670..a42adf9407063fd4be09047e6d254364c5e5b9d2))

- `example/lib/alias.wsa` and `example/lib/std.wsa`:
  - Add `retrive` alias for `retrieve`
  - Add argument aliases for `add`, `sub`, `mul`, and `div`
  - Add `test` macro for `dup push $number sub`
- Create programs:
  - `example/mal.wsa` (one per line)
  - `example/vm/bf.wsa`/`.ws` (one per line)
  - `example/vm/mal.wsa`/`.ws` (one per line)
  - `example/wc/bf2wsa.wsa`/`.ws` (multi per line)
- Add Brainfuck and Malbolge support

Find:

- When was multi per line support added?

Changes:

- 0.13.0
  - Big int
- 0.10.1:
  - Added optional parameters
  - Added `example/wc/bf2wsa.ws`
  - EOF is interpreted as "no change"
- Some time
  - `<title>` from “Whitelips the Whitespace IDE” to “Whitespace the Esoteric
    Language IDE” and in modal from “Whitelips IDE for Whitespace” to Whitelips
    IDE for esoteric languages”
    => Maybe rename to just Whitelips in my usage?
  - `ws_asm.js`
    - Undocumented `$n` macro meta labels added (search for
        `builder.macroCallCounter`)
    - `--`- and `{-` `-}`–comments added (search for `parseMultiLineComment` and
      `getTokens`)
    - Macros used to fail when the argument types didn't match; now they
      silently don't apply
    - Duplicate labels are forbidden
    - Labels starting with `.` or `_` used to be assigned by a counter, but now
      they're scoped to the parent label
  - `ws_core.js`
    - Optional parameters added for `add`, `sub`, `mul`, `div`, `mod`,
      `retrieve`, `readc`, and `readi`

Contributions:

- Is `example/mal.wsa` different from `example/vm/mal.wsa`?
- Remove optional parameters from macros since handled in core
