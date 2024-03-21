# Guided equality saturation

[“Guided Equality Saturation”](https://thok.eu/publications/2024/popl.pdf)
by Thomas Koehler, Andrés Goens, Siddharth Bhat, Tobias Grosser, Phil Trinder,
and Michel Steuwer, 2024

This paper is incredibly cool.

It introduces guided equality saturation. It lets you fill in a sketch of a
proof from intuition, giving steps that would be computationally difficult to
find, and let the solver prove it. Even if it can't solve a goal, it will select
the minimal AST cost equivalent version. They integrated it with Lean 4 and use
egg (though not its newer Datalog/e-graph powered cousin, egglog).

They also apply rewriting to program optimizations and are able to assist in
matrix multiplication opts for an array language. It's all the same with
Curry-Howard-Lambek, but there's usually surprisingly little crossover with
tooling. It would be *really* cool to let programmers write optimization proofs
inline with their code. Come to think of it, this kind of work is a perfect
melding of my compiler and formal verification inclinations!

The other day I was wanting to write some proofs to build up to implementing
IEEE-754 floating point arithmetic purely in terms of Z integers with `+`, `-`,
`*`, `/`, and `%`, and I would love to write them in a guided style like this.
It's particularly tricky, because the proofs unify the theories of Z, bit
vectors, and floating point, which neither Z3 nor CVC5 seem to handle well at
all. I could barely get them to prove the simplest lemma that uses both Z and
bitvec. I'm confident I could do it in Coq, but it would be tedious. Lean 4
looks good and I want to learn it, but it would still be mostly manual.

## Lightning talk

Thomas Koehler gave a [lightning talk](https://egraphs.org/meeting/2024-03-21-lightning-talks)
on guided equality saturation at the second EGRAPHS community meeting.

### Remark

They use an example of loop tiling, but instead of rewriting imperative loops,
as I'm used to, it's in terms of functional `map` with lambdas. Outside of an
e-graphs context, I assume it would use different algorithms (CPS?) than the
typical SSA transforms.

### Question 1

Guided eqsat sounds essentially like a meet-in-the-middle algorithm for proof
search.

> I think that's right, except that the "middle" can sometimes be specified as a
> partial program. When it's a complete program, I think it's the same. (Max
> Willsey)

### Question 2

Can GES be used today?

> We open-sourced the Lean tactic and Andés Goens is working on improving its
> usability, so it can be used but the user experience is not polished yet.
> https://github.com/opencompl/egg-tactic-code
>
> There's also a library implementing sketches for egg that can be used for
> playing with things: https://github.com/Bastacyclop/egg-sketches
>
> (Thomas Koehler)

### Question 3

With GES, are sketches machine-checked for correctness too or just accepted as
axioms?

> Sketches don't need to be checked because eqsat will find a rewrite path,
> proving equality by transitivity -- but the tactic can fail to find a path
> (Thomas Koehler)

Interesting. It feels different from what I’m used to in Coq (modus ponens
applications of assumptions to the goal) because an invalid assumption would
invalidate the whole thing.
