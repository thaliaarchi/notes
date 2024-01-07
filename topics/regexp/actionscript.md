# AS3 `RegExp` syntax incompatibilities in Ruffle

AS3 [`RegExp`](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/RegExp.html)
uses the same syntax as ECMAScript 3, according to the [Developer's Guide](https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ea9.html).
However, there are instances where the syntaxes diverge. Furthermore, Ruffle
uses `regress`, which [supports](https://docs.rs/regress/latest/regress/#supported-syntax)
the syntax of ECMAScript 2018.

I've surveyed the Ruffle issues and PRs for anything with “regex” or “regexp”.
All issues are cases, where ECMAScript 3 and AS3 syntaxes differ:

- `(?P<` `>)` named captures exist in AS3 ([#13278](https://github.com/ruffle-rs/ruffle/issues/13278),
  [#10395](https://github.com/ruffle-rs/ruffle/issues/10395), [#10511](https://github.com/ruffle-rs/ruffle/issues/10511)).
  [ECMAScript 3](https://ecma-international.org/wp-content/uploads/ECMA-262_3rd_edition_december_1999.pdf)
  has no named captures (see 15.10.1). ECMAScript 2018 has `(?<` `>)` named
  captures (see [21.2.1](https://262.ecma-international.org/9.0/#prod-GroupSpecifier)).
- `/` `/x` extended flag exists in AS3 ([#13965](https://github.com/ruffle-rs/ruffle/issues/13965)),
  but not ECMAScript 3 (see 15.10.4.1) or ECMAScript 2018 (see [12.2.8.1](https://262.ecma-international.org/9.0/#sec-primary-expression-regular-expression-literals-static-semantics-early-errors)).

If sticking with an existing library, keeping `regress` would be better than
switching to `regex`, because `regex` deliberately does not support
backreferences—a far more significant feature than any of those delineated
above—and its syntax is derived from RE2 rather than ECMAScript, so has larger
differences.

Is there a document that better specifies the syntax of AS3 `RegExp`, such as a
language specification or standard implementation? (I am new to AS3.) The
mention in the Developer's Guide does not seem normative and has contradictions.

I've done significant work on regular expression engines and have been bitten
before by differing syntaxes between languages, so that's a problem I'm
interested in tackling in a general-purpose way, and Ruffle could benefit from
that effort. Now that `regex-automata` exposes its HIR, other crates could
handle parsing and generate HIR. If a backtracking engine were added to
`regex-automata`, it could fallback to it when backreferences are used, while
still having the [extremely fast](https://github.com/BurntSushi/rebar)
performance of `regex` when not using backtracking. If there is interest in
Ruffle, that could be my motivation to pursue this.

An easier approach would be to extend `regress` to conditionally handle AS3
syntax, since it's already close. If matching performance is not a goal for
Ruffle, like it is for `regex`, then this would be fine.
