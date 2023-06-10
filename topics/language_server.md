# Language server design

In [“Zig Language Server and Cancellation”](https://matklad.github.io/2023/05/06/zig-language-server-and-cancellation.html),
Alex Kladov discusses approaches to the data model of a language server, in
their case for Zig.

1. **Sequential**: The trivial solution is to block until operations complete.
   Reads for completions block writes to update the source. Generally, writes
   should be prioritized over reads, because they reflect more up-to-date data.
2. **Immutable**: Data is not modified in-place, completions proceed in
   parallel, and edits are accepted immediately. This costs memory for the extra
   copies and CPU for computing out-of-date completions.
3. **Cancellation**: rust-analyzer cancels any in-flight work when an edit
   occurs and applies the modification in-place.
4. **Snapshots**: The proposed solution to use multiple snapshots of the state,
   inspired by Carmack's architecture for functional games, which uses two
   copies when updating frames. This approach fixes the issues of the others.

In the snapshot approach, the language server would have three snapshots: A
fully analyzed *ready* snapshot with the source files, their ASTs, ZIRs, and
AIRs (analyzed IR), and pre-computed cross-references. The *working* snapshot
has essentially the same data, but with the AIR being constructed. It also holds
the ASTs in *pending* for files currently being modified.

Edits are synchronously applied per-file to *pending*. When there are no syntax
errors, for example, a batch of errors is collected from *pending*, sent to
*working* for analysis in the background. Once *working* is fully processed,
*ready* is atomically updated to that.

This approach always returns correct results for AST queries, while other
queries may have some divergence.

In the [Hacker News](https://news.ycombinator.com/item?id=36268247) discussion,
some commenters note this may be over-engineered. For example, the AST need not
be completely re-parsed on every update, as it will most likely fail, and can
instead map positions to edited positions by tracking deltas.
