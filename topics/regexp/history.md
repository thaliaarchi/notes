# Regular expression engine history

## Russ Cox

- Posts
  - [“Regular Expression Matching Can Be Simple And Fast”](https://swtch.com/~rsc/regexp/regexp1.html)
    (January 2007)
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
- [RE2](https://github.com/google/re2)
- [Code Search](https://github.com/google/codesearch)
- [Go `regexp`](https://github.com/golang/go/tree/master/src/regexp)
  - [`rsc.io/binaryregexp`](https://github.com/rsc/binaryregexp): simple fork of
    Go `regexp`, changing it to work on Latin1, instead of UTF-8
- [pfalcon/re1.5](https://github.com/pfalcon/re1.5): fork of re1 to add features
  for real-world use. Contains history of re1 migrated to git, with the only
  difference being that commits with an empty author name in Mercurial use
  `Unknown`.

## Rob Pike

- [kyx0r/pikevm](https://github.com/kyx0r/pikevm): fork of re1.5 with only
  pikevm

## Others

- [Rust `regex`](https://github.com/rust-lang/regex) by Andrew Gallant
- [Doug McIlroy's regex](https://github.com/arnoldrobbins/mcilroy-regex)
  - Includes contributions [from Russ Cox](https://github.com/arnoldrobbins/mcilroy-regex/commits?author=rsc)
  - Features (see Background.txt):
    - Implements intersection and negation
    - Breaks out separate sublanguages for special treatment, all the way down
      to Knuth-Morris-Pratt string-searching, that uses only concatenation
