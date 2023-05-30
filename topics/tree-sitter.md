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
