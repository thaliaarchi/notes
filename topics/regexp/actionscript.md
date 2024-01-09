# AS3 `RegExp` syntax incompatibilities in Ruffle

## Issues

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

## Implementations

I've reviewed the AS3 spec and each of the similar projects listed in Ruffle's
[Helpful Resources](https://github.com/ruffle-rs/ruffle/wiki/Helpful-Resources#similar-projects)
for how they handle `RegExp`:

- The [draft AS3 Language Specification](https://archives.ecma-international.org/2005/misc/as3lang.pdf)
  does not describe `RegExp` semantics.
- Lightspark [uses](https://github.com/lightspark/lightspark/issues/224) pcre
  from avmplus/Tamarin in [RegExp.h](https://github.com/lightspark/lightspark/blob/master/src/scripting/toplevel/RegExp.h)/[RegExp.cpp](https://github.com/lightspark/lightspark/blob/master/src/scripting/toplevel/RegExp.cpp).
  Which version of pcre and why?
- Mozilla Shumway parses and sanitizes AS3 patterns and flags to equivalent
  JavaScript semantics in [RegExp.as](https://github.com/mozilla/shumway/blob/master/src/libs/builtin/RegExp.as)/[`ASRegExp`](https://github.com/mozilla/shumway/blob/master/src/avm2/nat.ts#L1800-L2075).
  The current design was [written](https://github.com/mozilla/shumway/blob/2bbdb5ce0db7796bfd832dc26c6ec25737eb15d7/src/avm2/nat.ts#L1659-L1926)
  just before ECMAScript 2015 was published, so probably targets ECMAScript 5.1
  `RegExp` semantics. The prior design delegated in [`ASRegExp`](https://github.com/mozilla/shumway/blob/84cafb5801e83ee12e8b3889b25a352d05befa1d/src/avm2/native.ts#L1668-L1814)
  to the [XRegExp](https://github.com/mozilla/shumway/blob/84cafb5801e83ee12e8b3889b25a352d05befa1d/src/avm2/xregexp.ts)
  library, which converts its own extended syntax to JavaScript syntax. The
  current design indicates, that it fixes more tests than XRegExp, which implies
  that XRegExp syntax was not a design inspiration for the AS3 language authors.
- AwayFL does the same thing as Shumway in [`ASRegExp`](https://github.com/awayfl/avm2/blob/dev/lib/nat/ASRegExp.ts).
  Their [initial version](https://github.com/awayfl/swf-loader/blob/b4579d10decc98d0d5a177ead132d2bcc15244df/lib/factories/avm2/nat.ts#L1800-L2075)
  is copied verbatim from Shumway and changes have been made since. Before
  @awayfl/avm2 was [extracted](https://github.com/awayfl/avm2/commit/d8217f69da85104840f229cb2994f81f1576993a)
  as a separate package, it existed as a [subdirectory of @awayfl/swf-viewer](https://github.com/awayfl/swf-loader/tree/v0.3.134/lib/factories/avm2),
  where the git history continues.
- [GNU Gnash](https://www.gnu.org/software/gnash/), [swf2js](https://github.com/swf2js/swf2js),
  [swfdec](https://github.com/mltframework/swfdec), and seemingly [OpenFL](https://github.com/openfl/openfl)
  do not implement `RegExp`. [WAFlash](https://vidkidz.github.io/) is
  closed-source, so I did not investigate it.

The approaches in Shumway and AwayFL remind me of how Scala.js
[compiles regular expressions](https://github.com/scala-js/scala-js/tree/main/javalib/src/main/scala/java/util/regex#readme)
([talk](https://youtu.be/luEmOvCx0WU?t=1648), [release notes](https://www.scala-js.org/news/2021/08/04/announcing-scalajs-1.7.0/)).
They compile Java regex patterns to semantically equivalent JavaScript patterns,
so that the native `RegExp` can be used, with all the browser optimizations that
come with it.

I think a port of the Shumway approach to Rust, with fixes from AwayFL as
appropriate, would be easiest for Ruffle. Shumway's algorithm was written for
ECMAScript 5.1, so the only differences should be only those introduced by
regress implementing ECMAScript 2018. It would allow some modern regular
expression features, that AS3 never had, but would better work around the other
differences. It would be strictly better than Ruffle's current situation, but
not absolutely perfect.
