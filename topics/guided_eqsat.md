# Guided equality saturation

This paper is incredibly cool.

It introduces guided equality saturation. It lets you fill in a sketch of a
proof from intuition, giving steps that would be computationally difficult to
find, and let the solver prove it. Even if it can't solve a goal, it will select
the minimal AST cost equivalent version. It uses e-graphs, which I think I told
you a bit about. They integrated it with Lean 4 and use egg (though not its
newer Datalog/e-graph powered cousin, egglog).

They also apply rewriting to program optimizations and are able to assist in
matrix multiplication opts for an array language. It's all the same with
Curry-Howard-Lambek, but there's usually surprisingly little crossover with
tooling. It would be *really* cool to let programmers write optimization proofs
inline with their code. Come to think of it, this kind of work is a perfect
melding of my compiler and formal verification inclinations!

https://thok.eu/publications/2024/popl.pdf

There will be a lightning talk on this in about three hours (9 PDT). Hopefully I
can make it.
https://egraphs.org/meeting/2024-03-21-lightning-talks

I don't yet see a thread for it on Zulip, but here's last month's:
https://egraphs.zulipchat.com/#narrow/stream/328972-general/topic/EGRAPHS.20Meeting.202024-02-15.20-.20Welcome

The other day I was wanting to write some proofs to build up to implementing
IEEE-754 floating point arithmetic purely in terms of Z integers with `+`, `-`,
`*`, `/`, and `%`, and I would love to write them in a guided style like this.
It's particularly tricky, because the proofs unify the theories of Z, bit
vectors, and floating point, which neither Z3 nor CVC5 seem to handle well at
all. I could barely get them to prove the simplest lemma that uses both Z and
bitvec. I'm confident I could do it in Coq, but it would be tedious. Lean 4
looks good and I want to learn it, but it would still be mostly manual.
