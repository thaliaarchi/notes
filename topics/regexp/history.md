# Regular expression engine history

## Russ Cox

- Posts
  - [“Regular Expression Matching Can Be Simple And Fast”](https://swtch.com/~rsc/regexp/regexp1.html)
    (January 2007)
    - Andrew Gallant [translated](https://github.com/BurntSushi/rsc-regexp) the
      Thompson NFA to Rust
  - [“Regular Expression Matching: the Virtual Machine Approach”](https://swtch.com/~rsc/regexp/regexp2.html)
    (December 2009)
  - [“Regular Expression Matching in the Wild”](https://swtch.com/~rsc/regexp/regexp3.html)
    (March 2010)
  - [“Regular Expression Matching with a Trigram Index”](https://swtch.com/~rsc/regexp/regexp4.html)
    (January 2012)
- [re1](https://code.google.com/archive/p/re1/) [[original](http://code.google.com/p/re1/)]:
  A simple engine by Russ Cox, predating the first re2 commit by four months
  - [Issues](https://web.archive.org/web/20160529162431/https://code.google.com/p/re1/issues/list)
    (including attachments)
    - Issue #1: fixed by commit #2
    - Issue #2: not fixed
    - Issue #3: not fixed
    - Issue #4: not fixed
  - Source trees in “Downloads” are redundant to commits
  - It has no wiki
- Go `regexp`
  - In the Google TechTalk for the initial release of Go, Rob Pike mentions that
    some packages, including `regexp`, “work fine but are too simple”. I should
    analyze earlier designs of `regexp`, including [at the initial release](https://github.com/golang/go/blob/c90d392ce3d3203e0c32b3f98d1e68c4c2b4c49b/src/pkg/regexp/regexp.go).
- rsc code for POSIX semantics:
  https://swtch.com/~rsc/regexp/nfa-posix.y.txt
- rsc code for postfix notation regexp:
  https://swtch.com/~rsc/regexp/nfa.c.txt
  (Check IA for all URL patterns under /regexp/*)

## Rob Pike

- sam
  - From [“Regular Expression Matching: the Virtual Machine Approach”](https://swtch.com/~rsc/regexp/regexp2.html)
    by Russ Cox (2009)
    > In a “threaded” implementation like thompsonvm above, we simply add the
    > saved pointer set to the thread state. Rob Pike first used this
    > approach, in the text editor sam.

    > The most interesting technique in this article is the one of storing
    > submatch information in the regular expression thread state. The
    > earliest instance I know of this technique in a regular expression
    > engine is in Rob Pike's sam editor, written around 1985. (The
    > modifications to store submatches were contributed by Bruce Janson a
    > couple of years after the original implementation.) The technique makes
    > a cameo in a textbook in 1974 but then seems to get lost until its
    > reappearance in sam.

## Ken Thompson

- [grep](https://en.wikipedia.org/wiki/Grep)
  - fgrep (not by him) uses the Aho–Corasick string-matching algorithm
- > Ken Thompson wrote a regex engine which compiled (at runtime) regexes into
  > data structures containing executable machine code, and invoked them (from C
  > source) by jumping into the data i.e. treating its location as a function
  > pointer. That's what's happening here except it's the start code inserted by
  > the linker which is jumping into main.
  https://news.ycombinator.com/item?id=27506134

## Others

- [Doug McIlroy's regex](https://github.com/arnoldrobbins/mcilroy-regex)
  - Includes contributions [from Russ Cox](https://github.com/arnoldrobbins/mcilroy-regex/commits?author=rsc)
  - Features (see Background.txt):
    - Implements intersection and negation
    - Breaks out separate sublanguages for special treatment, all the way down
      to Knuth-Morris-Pratt string-searching, that uses only concatenation
- tests (linked in regexp2, along with other tess):
  https://web.archive.org/web/20130420020035/http://www2.research.att.com/~gsf/testregex/
- [Ragel state machine compiler](https://github.com/adrian-thurston/ragel).
  Maybe has an interesting regexp implementation.
  - Has a pcre grammar, that I am unsure of whether it is an example usage of
    Ragel or used within Ragel.
    - Source: https://github.com/adrian-thurston/ragel/tree/master/grammar/pcre
    - Introduction commit: https://github.com/adrian-thurston/ragel/commit/a8ff0c82a3a26adf1547e8bef9919f29341849b1
  - Wikipedia writes that Ragel uses Thompson's construction:
    https://en.wikipedia.org/wiki/Ragel#See_also
- Brzozowski Derivatives and much more in the comments:
  https://news.ycombinator.com/item?id=35053328
  - > We built the new engine behind .NET's RegexOptions.NonBacktracking with
    > derivatives. We will have a paper at PLDI this year on the work that went
    > into that.
    https://news.ycombinator.com/item?id=35058237

## Algorithms

- [Knuth–Morris–Pratt algorithm](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm)
  for searching with a literal string pattern
- [Aho–Corasick algorithm](https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm)
  for searching with a set of literal string patterns (Equivalent to the `|` of
  those strings?)
