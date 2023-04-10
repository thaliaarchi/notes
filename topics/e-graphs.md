# E-graphs

An [E-graph](https://en.wikipedia.org/wiki/E-graph) is a data structure, that
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

E-graphs even had a dedicated workshop, [EGRAPHS 2022](https://egraphs-good.github.io/workshop/2022.html),
at PLDI 2022.

Philip Zucker has written [notes](https://www.philipzucker.com/notes/Logic/egraphs/)
several [posts](https://www.philipzucker.com/) on e-graphs.

E-graphs are deterministic finite tree automata (DFTAs) [[post](https://github.com/egraphs-good/egg/discussions/104)].
Tree grammars have also been used, for example, to improve parsing, in
[“Restricting grammars with tree automata”](https://michaeldadams.org/papers/restricting-grammars-with-tree-automata/)
(Michael D. Adams and Matthew Might, 2017).
