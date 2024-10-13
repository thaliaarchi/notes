# reglog: egglog + RVSDGs

Provenance/proofs for what rules construct nodes. This would be more general
than my idea of storing which passes construct nodes. See module comment in
src/function/table.rs. What about merging provenance, since nodes can be
constructed in multiple ways?

Do regions need to be a sort like `UnstableFn`? What does optir do for this?

Values, if stored directly, could benefit from heterogeneous widths. Kinda like
JIT specialization.

Predicates and properties of nodes can probably be stored on the e-class instead
of the node. In fact, this is already remarked in the [video tutorial](https://www.youtube.com/watch?v=N2RDQGRBrSY):
`(function lower-bound (Math) Rational :merge (max old new))` is only stored
once per e-class.

Use [slotted e-graphs](pldi2024/slotted_e-graphs.md).
