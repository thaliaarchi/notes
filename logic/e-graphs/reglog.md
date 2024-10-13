# reglog: egglog + RVSDGs

Provenance/proofs for what rules construct nodes. This would be more general
than my idea of storing which passes construct nodes. See module comment in
src/function/table.rs. What about merging provenance, since nodes can be
constructed in multiple ways?

Values, if stored directly, could benefit from heterogeneous widths. Kinda like
JIT specialization.

Predicates and properties of nodes can probably be stored on the e-class instead
of the node. In fact, this is already remarked in the [video tutorial](https://www.youtube.com/watch?v=N2RDQGRBrSY):
`(function lower-bound (Math) Rational :merge (max old new))` is only stored
once per e-class.

Use [slotted e-graphs](pldi2024/slotted_e-graphs.md).

Optimize rewrite rules like Cranelift and how Philip Zucker [describes](pldi2024/e-graphs_and_automated_reasoning.md#simplification-and-completion).

Make rewrites be named (like Coq or [Twee](pldi2024/e-graphs_and_automated_reasoning.md#union-find-is-ground-atomic-completion)),
instead of anonymous.

## Regions

By making regions first-class in the e-graph, rewrites can target them
independently of their parent structural node.

Regions would work well in a slotted e-graph. Each region has a slot for each
external value used. Slots are ordered, as in slotted e-graphs, by their usage
ordering within the region, so they can be reused. In RVSDGs, structural nodes
have implicit edges from their input ports to the argument ports of the
contained regions, since they have the same ordering. In reglog, each region has
a slot for each argument port and they're instantiated with the input ports to
the γ-, θ-, λ-, δ-, and ϕ-nodes.

If a region does not use all RVSDG argument ports or has a different order, then
it breaks sharing. Slotted e-graphs order slots by the position in the e-class,
so regions can be shared between structural nodes.

The modeling of their sort may be similar to `UnstableFn`.

optir does not have first-class regions.
