# E-graphs

An [e-graph](https://en.wikipedia.org/wiki/E-graph) is a data structure, that
efficiently stores equivalent terms in a language.

[egg](https://egraphs-good.github.io/) [[docs](https://docs.rs/egg/latest/egg/tutorials/_01_background/index.html)]
[[blog post](https://blog.sigplan.org/2021/04/06/equality-saturation-with-egg/)]
is a Rust library, that uses e-graphs to build program optimizers and
synthesizers in many domains. To use it, [`egg::Language`](https://docs.rs/egg/latest/egg/trait.Language.html)
is derived for for your language.

[Ruler](https://github.com/uwplse/ruler) [[paper](https://dl.acm.org/doi/10.1145/3485496)]
uses e-graphs to automatically infer rewrite rules. It generates more minimal
rule sets, which improves rewriting speeds, and finds rules that may not have
been found manually. It has been used to [generate rules](https://github.com/uwplse/ruler/blob/main/tests/halide.rs)
for [Halide](https://github.com/halide/Halide).

[Caviar](https://github.com/caviar-trs/caviar) [[paper](https://dl.acm.org/doi/10.1145/3497776.3517781)]
[[CC 2022](https://conf.researchr.org/track/CC-2022/CC-2022-research-papers#event-overview)]
is a term-rewriting system for compilers, that improves on the speed of base
e-graph TRSs by stopping construction before reaching saturation. It has been
used for Halide.

E-graphs have a dedicated workshop at PLDI. The first was [EGRAPHS 2022](https://egraphs-good.github.io/workshop/2022.html)
[[video](https://www.youtube.com/watch?v=dbgZJyw3hnk)], and it will occur again
at PLDI 2023.

Philip Zucker has written [notes](https://www.philipzucker.com/notes/Logic/egraphs/)
several [posts](https://www.philipzucker.com/) on e-graphs.

## Datalog with e-graphs

There's currently much work in connecting Datalog and e-graphs, including:
- [“Better Together: Unifying Datalog and Equality Saturation”](https://www.mwillsey.com/papers/egglog)
  (Yihong Zhang, Remy Wang, Oliver Flatt, David Cao, Philip Zucker, Eli
  Rosenthal, Zachary Tatlock, Max Willsey, 2023)
- [“Relational E-matching”](https://arxiv.org/abs/2108.02290)
  (Yihong Zhang, Yisu Remy Wang, Max Willsey, and Zachary Tatlock, 2022)
- [“Logging an Egg: Datalog on E-Graphs”](https://github.com/philzook58/egglog0-talk/raw/main/out.pdf)
  (Philip Zucker, 2022)
  [[PLDI 2022](https://pldi22.sigplan.org/details/egraphs-2022-papers/12/Logging-an-Egg-Datalog-on-E-Graphs)]
  [[code](https://github.com/philzook58/egglog)] [[demo](http://www.philipzucker.com/egglog/)]
  [[nodes and video](https://www.philipzucker.com/pldi22-notes/)]
- [“Your next e-graph framework looks like Datalog”](https://effect.systems/doc/pldi-2022-egraphs/abstract.pdf)
  (Yihong Zhang, 2022)

## Acyclic e-graphs

The Cranelift mid-end has been rearchitected to use acyclic e-graphs (æ-graphs).
This is detailed in the [RFC](https://github.com/bytecodealliance/rfcs/blob/main/accepted/cranelift-egraph.md)
and was enabled by default in version [6.0.0](https://github.com/bytecodealliance/wasmtime/blob/main/RELEASES.md#600).
Chris Fallin will present [“ægraphs: Acyclic E-graphs for Efficient Optimization
in a Production Compiler”](https://pldi23.sigplan.org/details/egraphs-2023-papers/2/-graphs-Acyclic-E-graphs-for-Efficient-Optimization-in-a-Production-Compiler)
on this work at EGRAPHS 2023.

E-graphs have been discussed several times on the Cranelift Zulip:

- [2022-01-03](https://bytecodealliance.zulipchat.com/#narrow/stream/217117-cranelift/topic/Thesis.3A.20Automated.20Code.20Optimization.20with.20E-Graphs)
  Thesis: Automated Code Optimization with E-Graphs
- [2022-08-04](https://bytecodealliance.zulipchat.com/#narrow/stream/217117-cranelift/topic/e-graph.20ISLE.20rules.20questions)
  e-graph ISLE rules questions
- [2022-09-22](https://bytecodealliance.zulipchat.com/#narrow/stream/217117-cranelift/topic/ELI5.3A.20What.20is.20an.20acyclic.20egraph.3F)
  ELI5: What is an acyclic egraph?
- [2022-09-26](https://bytecodealliance.zulipchat.com/#narrow/stream/217117-cranelift/topic/Rematerialization.3A.20egraph.20vs.20regalloc)
  Rematerialization: egraph vs regalloc

## In theorem provers

Siddharth and Andrés Goens built an [egg tactic for Lean](https://github.com/opencompl/egg-tactic-code).
Philip Zucker was interested in building an [e-graph tactic for Coq](https://egraphs.zulipchat.com/#narrow/stream/328975-Theorem-Proving/topic/Coq.20Tactic).
The `auto2` tactic in Isabelle/HOL uses [e-graphs](https://link.springer.com/chapter/10.1007/978-3-319-43144-4_27).

## Deterministic finite tree automata

E-graphs are deterministic finite tree automata (DFTAs) [[post](https://github.com/egraphs-good/egg/discussions/104)].
Tree grammars have also been used, for example, to improve parsing, in
[“Restricting grammars with tree automata”](https://michaeldadams.org/papers/restricting-grammars-with-tree-automata/)
(Michael D. Adams and Matthew Might, 2017).
