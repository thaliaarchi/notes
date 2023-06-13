# Improving debugging for Whitespace

## What a good debugger can do

Notes from reading [“What a good debugger can do”](https://werat.dev/blog/what-a-good-debugger-can-do/)
[[HN](https://news.ycombinator.com/item?id=35092998)] by Andy Hippo:

### Time travel

> Many debuggers support \[time travel] in some way. GDB implements time travel
> by [recording the register and memory modifications](https://stackoverflow.com/questions/1470434/how-does-reverse-debugging-work)
> made by each instruction, which makes it trivial to undo the changes. However,
> this incurs a significant performance overhead, so it may be not as practical
> in non-interactive mode. Another popular approach is based on the observation
> that most of the program execution is deterministic. We can snapshot the
> program whenever something non-deterministic happens (syscall, I/O, etc) and
> then we just reconstruct the program state at any moment by rewinding it to
> the nearest snapshot and executing the code from there. This is basically what
> [UDB](https://undo.io/solutions/products/udb/), [WinDBG](https://msrc.microsoft.com/blog/2019/05/time-travel-debugging-its-a-blast-from-the-past/)
> and [rr](https://rr-project.org/) do.

Time travel would be very valuable in a Whitespace debugger. Are IO instructions
the only non-determinism in Whitespace? How would its laziness affect this?

### Omniscient debugging

Omniscient debugging precalculates the states that make up a program trace and
stores them in a database with indexes for efficient querying.

> With the whole program history recorded and indexed, you can ask questions
> like “how many times and where this was variable written?”, “which thread
> freed this chunk of memory?” or even “how was this specific pixel rendered?”.

This only works with one program trace, but if this was made abstract, to work
with all program traces, it could also be used for static analyses, to optimize
during compilation.

## V8 Deopt Explorer

Ideas from reading [“Introducing Deopt Explorer”](https://devblogs.microsoft.com/typescript/introducing-deopt-explorer/)
by Ron Buckton:

To address performance issues in the TypeScript compiler, they built a VS Code
extension, the Deopt Explorer, to explore the deoptimizations, inline caches,
and object types, that V8 produces while executing. It analyzes trace logs
produced by V8, to highlight locations in the code that cause deoptimizations.
It allows an engineer, who's knowledgeable of these runtime internals, to drill
into the memory layout of V8 and understand the performance issues.

In Whitespace, when designing a program to run on the reference interpreter, it
is important to keep in mind the space leaks and performance characteristics of
the heap. To assist with this, it would be useful to model the lazy semantics
exactly in a similar tool. Unlike lazy-wspace, it would need to track retained
references (e.g., from `retrieve`), instead of optimizing them away.

It would be vital to verify that the model corresponds to the actual
characteristics of the Haskell code, which would require an understanding of
Haskell memory analysis tools and GHC's strictness analysis. Otherwise, this
tool would be profiling against a theoretical model.
