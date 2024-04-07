# Regular expression implementations

- awk

- Code Search [[src](https://github.com/google/codesearch)]

  Background in [“Regular Expression Matching with a Trigram Index—or—How Google
  Code Search Worked”](https://swtch.com/~rsc/regexp/regexp4.html) by Russ Cox (2012)

- ECMAScript `RegExp`

  - JavaScript `RegExp`
    - V8 Irregexp
      - Gecko Irregexp [[src](https://github.com/mozilla/gecko-dev/tree/master/js/src/irregexp)]
    - SerenityOS LibJS [[src](https://github.com/SerenityOS/serenity/blob/master/Userland/Libraries/LibJS/Runtime/RegExpPrototype.cpp)]
    - XRegExp [[src](https://github.com/slevithan/xregexp)]: extended parsing
  - ActionScript 3 `RegExp`
    - Ruffle: `RegExp` compatibility in Ruffle and other emulators is tracked in
      [issue #14651](https://github.com/ruffle-rs/ruffle/issues/14651)
    - avmplus
    - Shumway

- Go `regexp` [[src](https://github.com/golang/go/tree/master/src/regexp)]
  [[docs](https://pkg.go.dev/regexp)]

  - `rsc.io/binaryregexp` [[src](https://github.com/rsc/binaryregexp)]: simple
    fork of Go `regexp`, changing it to work on Latin1, instead of UTF-8

- Java `java.util.regex` [docs [1.4.2][java-1.4.2], [5.0][java-5.0], [6][java-6],
  [7][java-7], [8][java-8], [9][java-9], [10][java-10], [11][java-11],
  [12][java-12], [13][java-13], [14][java-14], [15][java-15], [16][java-16],
  [17][java-17], [18][java-18], [19][java-19], [20][java-20], [21][java-21]]

  - Scala.js

- McIlroy's `regex` [[src](https://github.com/arnoldrobbins/mcilroy-regex)]

  Author: Doug McIlroy

- .NET `System.Text.RegularExpressions` [[docs](https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expressions)]

  - `dlclark/regexp2` [[src](https://github.com/dlclark/regexp2)]: port of .NET
    `System.Text.RegularExpressions` to Go, which has RE2 and ECMAScript
    compatibility modes

- PCRE (Perl Compatible Regular Expressions) [[src](https://github.com/PCRE2Project/pcre2)]
  [[Wikipedia](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions)]

- Perl

- Plan 9 `grep` [[src](https://github.com/plan9foundation/plan9/tree/main/sys/src/cmd/grep)]
  [docs [grep(1)](https://github.com/plan9foundation/plan9/blob/main/sys/man/1/grep)]

  - Plan 9 from User Space `grep` [[src](https://github.com/9fans/plan9port/tree/master/src/cmd/grep)]

- Plan 9 `sam` [[src](https://github.com/plan9foundation/plan9/tree/main/sys/src/cmd/sam/regexp.c)]

  Author: Rob Pike

  Introduced Pike VM [history [vm](https://swtch.com/~rsc/regexp/regexp2.html#pike),
  [submatch](https://swtch.com/~rsc/regexp/regexp2.html#ahu74)]

  - Plan 9 from User Space `sam` [[src](https://github.com/9fans/plan9port/blob/master/src/cmd/sam/regexp.c)]:
    ported to Unix by Russ Cox
  - Plan 9 `libregexp` [[src](https://github.com/plan9foundation/plan9/tree/main/sys/src/libregexp)]
    [docs [regexp(2)](https://github.com/plan9foundation/plan9/blob/main/sys/man/2/regexp),
    [regexp(6)](https://github.com/plan9foundation/plan9/blob/main/sys/man/6/regexp)]
    - Plan 9 from User Space `libregexp` [[src](https://github.com/9fans/plan9port/tree/master/src/libregexp)]
      [docs [regexp(3)](https://9fans.github.io/plan9port/man/man3/regexp.html),
      [regexp(7)](https://9fans.github.io/plan9port/man/man7/regexp.html)]:
      ported to Unix by Russ Cox
      - tylov/regexp9 [[src](https://github.com/tylov/regexp9)]: fork with more
        modern features
    - 9legacy `libregexp-fixes.diff` [[src](http://9legacy.org/9legacy/patch/libregexp-fixes.diff)]:
      patch by David du Colombier
    - Inferno `libregexp` [[src](https://github.com/inferno-os/inferno-os/tree/master/utils/libregexp)]
      [docs [regex(2)](https://github.com/inferno-os/inferno-os/blob/master/man/2/regex),
      [regexp(6)](https://github.com/inferno-os/inferno-os/blob/master/man/6/regexp)]:
      copied to Inferno
  - A library in Eighth Edition Unix [[history][rsc-history]]:
    extracted by Dave Presotto

- POSIX `regex.h`

  - SerenityOS LibRegex [[src](https://github.com/SerenityOS/serenity/tree/master/Userland/Libraries/LibRegex)]

- Python `re` (Secret Labs' Regular Expression Engine, SRE) [src [py](https://github.com/python/cpython/tree/main/Lib/re),
  [c](https://github.com/python/cpython/tree/main/Modules/_sre)]

  Author: Fredrik Lundh [[initial commit](https://github.com/python/cpython/commit/b700df9824a768893fb83dec41779ac89035313e)]

  It was part of [PEP 100 – Python Unicode Integration](https://peps.python.org/pep-0100/#regular-expressions)

  - tinyre [[src](https://github.com/fy0/TinyRe)]: fork of `re`

- Python 1.5 `re` (PCRE) [[working group](https://web.archive.org/web/19980422202951/http://starship.skyport.net/crew/amk/regex/)]

- Python `regex` and `regsub` (removed)

  Deprecated in Python 2.0, removed in [Python 2.5](https://docs.python.org/3/whatsnew/2.5.html#new-improved-and-removed-modules)

  [Migrating to `re`](https://web.archive.org/web/19980526014452/http://www.python.org/doc/howto/regex-to-re/)

- QED text editor [[Wikipedia](https://en.wikipedia.org/wiki/QED_(text_editor))]
  [[algorithm](https://swtch.com/~rsc/regexp/regexp2.html#thompsonvm)]

  Author: Ken Thompson

  Introduced Thompson's construction [[history][rsc-history]], [[attribution](https://swtch.com/~rsc/regexp/regexp2.html#attrib)]

- re1 [[src](https://code.google.com/archive/p/re1/)] [[blog](https://swtch.com/~rsc/regexp/regexp2.html)]

  Author: Russ Cox

  - pfalcon/re1.5 [[src](https://github.com/pfalcon/re1.5)]: fork of re1 to add
    features for real-world use. Contains the Mercurial history of re1 migrated
    to git, with the only difference being that commits with an empty author
    name use `Unknown`.
    - kyx0r/pikevm [[src](https://github.com/kyx0r/pikevm)]: fork of re1.5 with
      only pikevm
  - jameysharp/pikevm [[src](https://github.com/jameysharp/pikevm)]: pikevm
    implementation in Rust

- RE2 [[src](https://github.com/google/re2)]

- Rust `regex` [[src](https://github.com/rust-lang/regex)]
  [[docs](https://docs.rs/regex/latest/regex/)]

- Spencer's library [[algorithm](https://swtch.com/~rsc/regexp/regexp2.html#backtrack)]

  Author: Henry Spencer

  Introduced backtracking widely [[history][rsc-history]]

- Unicode Regular Expressions [[standard](https://www.unicode.org/reports/tr18/)]

- Unix `ed` [[history][rsc-history]]

  Author: Ken Thompson

  First appeared in First Edition Unix

- Unix `egrep` [[history][rsc-history]]

  Author: Al Aho

  First appeared in Seventh Edition Unix

- Unix `grep` [[history][rsc-history]]

  First appeared in Fourth Edition Unix

More are listed in Wikipedia's [Comparison of regular expression engines](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines).


[rsc-history]: https://swtch.com/~rsc/regexp/regexp1.html#History
[java-1.4.2]: https://web.archive.org/web/20111126092902/http://docs.oracle.com/javase/1.4.2/docs/api/java/util/regex/package-summary.html
[java-5.0]: https://docs.oracle.com/javase/1.5.0/docs/api/java/util/regex/package-summary.html
[java-6]: https://docs.oracle.com/javase/6/docs/api/java/util/regex/package-summary.html
[java-7]: https://docs.oracle.com/javase/7/docs/api/java/util/regex/package-summary.html
[java-8]: https://docs.oracle.com/javase/8/docs/api/java/util/regex/package-summary.html
[java-9]: https://docs.oracle.com/javase/9/docs/api/java/util/regex/package-summary.html
[java-10]: https://docs.oracle.com/javase/10/docs/api/java/util/regex/package-summary.html
[java-11]: https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/regex/package-summary.html
[java-12]: https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/util/regex/package-summary.html
[java-13]: https://docs.oracle.com/en/java/javase/13/docs/api/java.base/java/util/regex/package-summary.html
[java-14]: https://docs.oracle.com/en/java/javase/14/docs/api/java.base/java/util/regex/package-summary.html
[java-15]: https://docs.oracle.com/en/java/javase/15/docs/api/java.base/java/util/regex/package-summary.html
[java-16]: https://docs.oracle.com/en/java/javase/16/docs/api/java.base/java/util/regex/package-summary.html
[java-17]: https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/regex/package-summary.html
[java-18]: https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/regex/package-summary.html
[java-19]: https://docs.oracle.com/en/java/javase/19/docs/api/java.base/java/util/regex/package-summary.html
[java-20]: https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/regex/package-summary.html
[java-21]: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/regex/package-summary.html
