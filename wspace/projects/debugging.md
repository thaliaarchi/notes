# Improving debugging for Whitespace

Notes from reading [“What a good debugger can do”](https://werat.dev/blog/what-a-good-debugger-can-do/)
[[HN](https://news.ycombinator.com/item?id=35092998)] by Andy Hippo

## Time travel

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

## Omniscient debugging

Omniscient debugging precalculates the states that make up a program trace and
stores them in a database with indexes for efficient querying.

> With the whole program history recorded and indexed, you can ask questions
> like “how many times and where this was variable written?”, “which thread
> freed this chunk of memory?” or even “how was this specific pixel rendered?”.

This only works with one program trace, but if this was made abstract, to work
with all program traces, it could also be used for static analyses, to optimize
during compilation.
