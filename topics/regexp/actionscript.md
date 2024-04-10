# ActionScript 3 `RegExp`

ActionScript 3 [`RegExp`](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/RegExp.html)
uses syntax similar to ECMAScript 3 with some additions.

`RegExp` compatibility in Ruffle and other emulators is tracked in [issue #14651](https://github.com/ruffle-rs/ruffle/issues/14651).

## AS3 specifications

The ActionScript 3 [Developer's Guide](https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ea9.html)
states that ActionScript 3.0 implements regular expressions as defined in the
ECMAScript 3 specification, but additionally adds [named capture groups](https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e9a.html#WS5b3ccc516d4fbf351e63e3d118a9b90204-7e9a__WS5b3ccc516d4fbf351e63e3d118a9b90204-7e80).
It also documents the [`x` flag](https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ea7.html),
but does not note that it is not a part of ECMAScript 3.

The [draft AS3 Language Specification](https://archives.ecma-international.org/2005/misc/as3lang.pdf)
does not describe `RegExp` semantics. Is there a better specification?

## Implementations

I've reviewed each of the similar projects listed in Ruffle's [Helpful Resources](https://github.com/ruffle-rs/ruffle/wiki/Helpful-Resources#similar-projects)
for how they handle `RegExp`. The [open source Flash petition](https://github.com/open-source-flash/open-source-flash)
also has a good list.

### Ruffle

Ruffle uses [`regress`](https://github.com/ridiculousfish/regress) as its
`RegExp` engine in [regexp.rs](https://github.com/ruffle-rs/ruffle/blob/master/core/src/avm2/regexp.rs)
and [RegExp.as](https://github.com/ruffle-rs/ruffle/blob/master/core/src/avm2/globals/RegExp.as).
`regress` [implements](https://docs.rs/regress/latest/regress/#supported-syntax)
the `RegExp` syntax of ECMAScript 2018, which has more features than ECMAScript
3 and is missing the AS3 additions.

I've surveyed the Ruffle issues and PRs for anything with “regex” or “regexp”.
All issues are from differences between ECMAScript 3 and AS3 syntaxes:

- `(?P<` `>)` named captures exist in AS3 ([#13278](https://github.com/ruffle-rs/ruffle/issues/13278),
  [#10395](https://github.com/ruffle-rs/ruffle/issues/10395), [#10511](https://github.com/ruffle-rs/ruffle/issues/10511)).
  [ECMAScript 3](https://ecma-international.org/wp-content/uploads/ECMA-262_3rd_edition_december_1999.pdf)
  has no named captures (see 15.10.1). ECMAScript 2018 has `(?<` `>)` named
  captures (see [21.2.1](https://262.ecma-international.org/9.0/#prod-GroupSpecifier)).
- `x` extended flag exists in AS3 ([#13965](https://github.com/ruffle-rs/ruffle/issues/13965)),
  but not ECMAScript 3 (see 15.10.4.1) or ECMAScript 2018 (see [12.2.8.1](https://262.ecma-international.org/9.0/#sec-primary-expression-regular-expression-literals-static-semantics-early-errors)).

Differences between ECMAScript 3 and 2018 should not break already working
regexps, but would allow newer features.

### avmplus

avmplus (also known as [Tamarin](https://en.wikipedia.org/wiki/Tamarin_(software)))
implements `RegExp` in:

- [RegExp.as](https://github.com/adobe/avmplus/blob/master/core/RegExp.as)
- [RegExp.cpp](https://github.com/adobe/avmplus/blob/master/core/RegExp.cpp),
  [h](https://github.com/adobe/avmplus/blob/master/core/RegExp.h)
- [RegExpClass.cpp](https://github.com/adobe/avmplus/blob/master/core/RegExpClass.cpp),
  [h](https://github.com/adobe/avmplus/blob/master/core/RegExpClass.h)
- [RegExpObject.cpp](https://github.com/adobe/avmplus/blob/master/core/RegExpObject.cpp),
  [h](https://github.com/adobe/avmplus/blob/master/core/RegExpObject.h)

It seems to use both [PCRE](https://github.com/adobe/avmplus/tree/master/pcre)
and [PCRE2](https://github.com/adobe/avmplus/tree/master/pcre2), possibly
interchangeably.

The [initial commit](https://github.com/adobe/avmplus/commit/65a05927767f3735db37823eebf7d743531f5d37)
of avmplus records that it is the source code for the ActionScript VM in the
Adobe Flash Player for December 2013.

More background on Tamarin is on [Wikipedia](https://en.wikipedia.org/wiki/Tamarin_(software)),
formerly on [MDN](https://web.archive.org/web/20161003214723/https://developer.mozilla.org/en-US/docs/Archive/Mozilla/Tamarin),
and in [response](https://github.com/open-source-flash/open-source-flash/issues/54)
to a petition to open-source Adobe Flash Player.

### Lightspark

Lightspark [uses](https://github.com/lightspark/lightspark/issues/224) PCRE from
avmplus in [RegExp.h] and [RegExp.cpp].

Which version of PCRE is this and why was it selected?

[RegExp.h]: https://github.com/lightspark/lightspark/blob/master/src/scripting/toplevel/RegExp.h
[RegExp.cpp]: https://github.com/lightspark/lightspark/blob/master/src/scripting/toplevel/RegExp.cpp

### Shumway

Mozilla Shumway parses and sanitizes AS3 patterns and flags to equivalent
JavaScript semantics in [RegExp.as] and [`ASRegExp`]. The current design was
[written](https://github.com/mozilla/shumway/blob/2bbdb5ce0db7796bfd832dc26c6ec25737eb15d7/src/avm2/nat.ts#L1659-L1926)
just before ECMAScript 2015 was published, so it probably targets ECMAScript 5.1
`RegExp` semantics. The prior design delegated in [`ASRegExp`](https://github.com/mozilla/shumway/blob/84cafb5801e83ee12e8b3889b25a352d05befa1d/src/avm2/native.ts#L1668-L1814)
to the [XRegExp](https://github.com/mozilla/shumway/blob/84cafb5801e83ee12e8b3889b25a352d05befa1d/src/avm2/xregexp.ts)
library, which converts its own extended syntax to JavaScript syntax. The
current design indicates, that it fixes more tests than XRegExp, which implies
that XRegExp syntax was not a design inspiration for the AS3 language authors.

The approach in Shumway (and AwayFL) reminds me of how Scala.js
[compiles regular expressions](https://github.com/scala-js/scala-js/tree/main/javalib/src/main/scala/java/util/regex#readme)
([talk](https://youtu.be/luEmOvCx0WU?t=1648), [release notes](https://www.scala-js.org/news/2021/08/04/announcing-scalajs-1.7.0/)).
They compile Java regex patterns to semantically equivalent JavaScript patterns,
so that the native `RegExp` can be used, with all the browser optimizations that
come with it.

Shumway has a few [`RegExp`-specific tests](https://github.com/mozilla/shumway/tree/master/test/avm2/acceptance/as3/RegExp).

[RegExp.as]: https://github.com/mozilla/shumway/blob/master/src/libs/builtin/RegExp.as
[`ASRegExp`]: https://github.com/mozilla/shumway/blob/master/src/avm2/nat.ts#L1800-L2075

### AwayFL

AwayFL does the same thing as Shumway in [`ASRegExp`](https://github.com/awayfl/avm2/blob/dev/lib/nat/ASRegExp.ts).
Their [initial version](https://github.com/awayfl/swf-loader/blob/b4579d10decc98d0d5a177ead132d2bcc15244df/lib/factories/avm2/nat.ts#L1800-L2075)
is copied verbatim from Shumway and changes have been made since. Before
@awayfl/avm2 was [extracted](https://github.com/awayfl/avm2/commit/d8217f69da85104840f229cb2994f81f1576993a)
as a separate package, it existed as a [subdirectory of @awayfl/swf-viewer](https://github.com/awayfl/swf-loader/tree/v0.3.134/lib/factories/avm2),
where the Git history continues.

### Others

[GNU Gnash](https://www.gnu.org/software/gnash/), [swf2js](https://github.com/swf2js/swf2js),
[swfdec](https://github.com/mltframework/swfdec), and seemingly [OpenFL](https://github.com/openfl/openfl)
do not implement `RegExp`. [WAFlash](https://vidkidz.github.io/) is
closed-source, so I did not investigate it.

## Recommendation for Ruffle

If sticking with an existing library, keeping `regress` would be better than
switching to `regex`, because `regex` deliberately does not support
backreferences—a far more significant feature than any of those delineated
above—and its syntax is derived from RE2 rather than ECMAScript, so has larger
differences.

I've done significant work on regular expression engines and have been bitten
before by differing syntaxes between languages, so that's a problem I'm
interested in tackling in a general-purpose way, and Ruffle could benefit from
that effort. Now that `regex-automata` exposes its HIR, other crates could
handle parsing and generate HIR. If a backtracking engine were added to
`regex-automata`, it could fallback to it when backreferences are used, while
still having the [extremely fast](https://github.com/BurntSushi/rebar)
performance of `regex` when not using backtracking. If there is interest in
Ruffle, that could be my motivation to pursue this.

I think a port of the Shumway approach to Rust, with the fixes from AwayFL as
appropriate, would be easiest for Ruffle. Shumway's algorithm was written for
ECMAScript 5.1, so the only differences should be only those introduced by
regress implementing ECMAScript 2018. It would allow some modern regular
expression features, that AS3 never had, but would better work around the other
differences. It would be strictly better than Ruffle's current situation, but
not absolutely perfect.

Replacing `regress` with [`fancy_regex`](https://github.com/fancy-regex/fancy-regex),
with the proper parsing changes, would be the most powerful approach.
`fancy_regex` is a hybrid engine that delegates to `regex` when possible and
falls back to backtracking when necessary.
