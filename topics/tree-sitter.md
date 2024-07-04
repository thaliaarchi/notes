# Tree-sitter

## How Tree-sitter works

[“Tree-sitter - a new parsing system for programming tools”](https://www.youtube.com/watch?v=Jes3bD6P0To)
by Max Brunsfeld, 2018.

Tree-sitter parses without backtracking like LR parsing, but uses a generalized
form, GLR parsing, which forks the parse stack for every possibility to resolve
ambiguities. This reminds me of the [Pike VM](https://swtch.com/~rsc/regexp/regexp2.html)
for regexp matching, in that all possibilities are simultaneously matched
without backtracking.

When an error is encountered, it proceeds by inserting error nodes and forking
for each way to recover, then selecting the branch that most closely matches a
valid parse.

Incremental parsing marks nodes in the old tree, where text was modified, then
parses the file again, reusing nodes that were not marked.

## Ideas

### Flat AST

AST fork tree. Arena with u32 IDs. Operations: commit, fork, and prune. Each
sub-arena in the fork tree starts its IDs just above its parent's last ID. When
a sub-tree is committed, it is merged into the tree under it, which is extended
with its elements.

Could fork points converge to start with common nodes?

Since ASTs have span information, each token is unique and no unique table is
needed. Thus, tokens do not need to be unified between branches.

How does Tree-sitter store its ASTs?

```rust
pub struct AstArena { … }

impl AstArena {
    fn new() -> Self;
    fn edit(&self) -> AstBuilder<'_>;
}

pub struct AstBuilder<'arena> {
    children: Vec<AstBuilder<'arena>>,
}

impl<'arena> AstBuilder<'arena> {
    fn push(&self, node: Node) -> NodeId;
    fn fork(&self) -> AstBuilder<'arena>;
    fn commit(self);
}
```

### Variable fidelity

Concrete (`syn` fidelity) vs abstract (compiler fidelity) syntax trees.

### Spans

Store only lengths of nodes and reconstruct the absolute spans on descent, as
opposed to storing them directly, for reusability with incremental updates and
space savings. [Bracket pair colorization](https://code.visualstudio.com/blogs/2021/09/29/bracket-pair-colorization#_the-basic-algorithm)
in VS Code stores the line and column lengths of nodes, compressed as a single
integer, (instead of the byte length) and balances the tree for logarithmic
access.
