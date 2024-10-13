# Egraphs and Automated Reasoning: Looking Back to Look Forward

Philip Zucker

[[conference details](https://pldi24.sigplan.org/details/egraphs-2024-papers/13/E-graphs-and-Automated-Reasoning-Looking-back-to-look-forward)]
[[pre-recorded video](https://www.youtube.com/watch?v=74VP0SbNHDE)]
[[conference video](https://www.youtube.com/watch?v=XW8yl7OGNwk&list=PLyrlk8Xaylp4UHRXP0VkuYen9nkn4bczW&index=14)]
[[live video (at 00:24:43)](https://www.youtube.com/watch?v=JPA8QwLHNzo&t=1483s)]
[[slides](https://github.com/philzook58/egraphs2024-talk/blob/main/egraphs_talk.ipynb)]

[[blog post](https://www.philipzucker.com/egraph2024_talk_done/)]
[[abstract](https://github.com/philzook58/egraphs2024-talk/blob/main/egraphs2024_abstract.pdf)]

(The audio is corrupted for most of the conference-recorded talk.)

### Simplification and completion

Basic form of completion:
1. Orient according to term order. Make a bidirectional rule directed in the
   direction of which would yield a cheaper result, e.g.,
   `[X * 2 = X << 2] ==> {X * 2 -> X << 2}`.
2. Add critical pairs (CPs) as equations. Find possible phase ordering problems:
   two LHSes which can overlap in a non-trivial way. Derive equations, e.g.,
   `{X * 2 -> X << 1; (X * Y) / Y -> X} => [(X << 1) / 2 = X]`.
3. Reduce equations. Reduce the equations wrt the rewrite rules, to simplify and
   discard redundant equations that the system can already prove.
4. Repeat.

This repairs confluence.

More advanced completion (Baader and Nipkow):
- Deduce
- Orient
- Delete
- Simplify-identify
- R-simplify-rule
- L-simplify-rule

If new rewrite rules are derived, which imply the old, then the R-simplify and
L-simplify rules let you compact and canonicalize your rewrite system.

Completion sounds like what Cranelift does statically to its rewrite rules
before generating core for them.

### Union-find is Ground Atomic Completion

Union-find is an instance of completion, in particular ground atomic completion.
Instead of variables for patterns, we have atomic symbols.

| Term rewrite system | Union-find                         |
| ------------------- | ---------------------------------- |
| Run TRS             | Find                               |
| Add equation        | Union                              |
| R/L simplify        | Path compression                   |
| Term ordering       | Tie breaking (e.g., depth or rank) |

Twee has the best visualization of proof production of any automated theorem
prover he's seen. Remark: The user names axioms (rewrites), which would help for
identification and provenance.

### E-Graph is Ground Term Completion

| TRS            | E-graph              |
| -------------- | -------------------- |
| Canonical term | E-class              |
| R/L-simplify   | Canonicalization     |
| Run rules      | Extraction           |
| Term orders    | Extraction objective |
| KBO weights    | Weights              |

**Most important point**: a Compressed Ground Rewrite System can be
diagrammatically represented in just as compelling or a simpler way than
e-graphs:

- Terms point to a cheaper term in the same e-class (instead of to the e-class
  root or in addition?); a dotted red line. This is refinement instead of just
  equality.
- Terms use terms instead of e-classes (as opposed to e-nodes, which use
  e-classes). Terms have a better notion of scope, which has been a serious
  problem in the e-graph and extending it with new notions.
- An e-graph is a lossy representation of this.

#### Where are the e-classes and e-nodes?

Flattening: introduce fresh constants for every term and rank them less in term
ordering.

This has two types of rules: `f(e1, e2) -> e3` uses the e-node table
(which e-nodes belong to which e-classes) and `e3 -> e1` uses union-find
(e-class ID to e-class ID).

- This is not obviously possible possible for scoped terms. Maybe slots would
  work (see “Slotted E-Graphs”).
- Completion is an e-graph with universal (forall) variables or first-class
  rules.
- Tree automata. Describes sets of trees by describe finite folds over those
  trees, which can fold to an accepting state or not. `cons(q1, q1) -> q1` is a
  bottom-up tree automata.

#### E-matching

Run rules in reverse to generate all equivalent terms.

Bottom-up e-matching is perhaps related to the ae-graph.

Bottom-up e-matching is better behaved in regards to polynomial and destructive
rewrites.

#### Strategies

In completion, everything is put into a single sack and run repeatedly. In
e-graphs, there's a distinction between the rules and e-graph; rules don't apply
to each other to make inferences.

Set of Support strategy: there are active and passive rules, where passive rules
aren't allowed to infer among themselves; only active against passive or active
against active is allowed. Passive is the eqsat rewrite rules and active is the
e-graph.

Prolog and Datalog can be seen as incomplete strategies on resolution.

#### Propositional and equational system correspondences

| Propositional             | Equational                                         |
| ------------------------- | -------------------------------------------------- |
| Resolution                | Paramodulation                                     |
| Ordered resolution        | Superposition                                      |
| ?                         | Completion                                         |
| Ground Ordered Resolution | E-graph / Ground Completion / Ground Superposition |
| Prolog                    | Functional Logic Programming                       |
| Datalog                   | Egglog                                             |
| Answer Set Programming    | ?                                                  |
| Lambda Prolog             | ?                                                  |
| Hypothetical Datalog      | ?                                                  |
| Minikanren                | ?                                                  |
