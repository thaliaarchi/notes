# Recross ideas

## Backreferences

> Backreferences. Backreferences are trivial in backtracking implementations. In
> Pike's VM, they can be accommodated, except that the argument about discarding
> threads with duplicate PCs no longer holds: two threads with the same PC might
> have different capture sets, and now the capture sets can influence future
> execution, so an implementation has to keep both threads, a potentially
> exponential blowup in state. GNU grep combines both approaches: it rewrites
> backreferences into an approximate regular expression that can be used with a
> DFA (for example, (cat|dog)\1 becomes (cat|dog)(cat|dog), which has a
> different, broader meaning than the original) and then the matches that the
> DFA turns up can be checked with the backtracking search.

in [regexp2](https://swtch.com/~rsc/regexp/regexp2.html)

I could expand backreferences to approximate regular expressions, where each
occurrence has the same length, when clipped.

## Character classes

> Character classes are represented [in RE2] not as a simple list of ranges or
> as a bitmap but as a balanced binary tree of ranges. This representation is
> more complex than a simple list but crucial for handling large Unicode
> character classes.

in [regexp3](https://swtch.com/~rsc/regexp/regexp3.html)

I don't think Rust regexp uses a binary tree. Should I?
