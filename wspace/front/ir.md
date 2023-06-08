# IR for Whitespace

## Expressions

Use a DAG for expressions, e.g.,

| #   | Type   | Left | Right | Value |
| --- | ------ | ---- | ----- | ----- |
| 0   | NAME   |      |       | x     |
| 1   | NAME   |      |       | a     |
| 2   | INT    |      |       | 10    |
| 3   | ITOF   | 2    |       |       |
| 4   | FADD   | 1    | 3     |       |
| 5   | FMUL   | 4    | 4     |       |
| 6   | ASSIGN | 0    | 5     |       |

See [*Introduction to Compilers and Language Design*](https://www3.nd.edu/~dthain/compilerbook/),
2020, by Douglas Thain, section 8.3 Directed Acyclic Graph.

This simplifies CSE and constant folding.

How would this interact with lazy expressions? How would this interact with
opaque heap references and aliasing?

## Whitespace semantics

```
n number value
t expression thunk
e error

op = add|sub|mul
op n n : n
op t n|t, op n t : t
op e n|t|e, op n|t e : e

op = div|mod
op n n : n|e
op t n|t, op n t : t|e
op e n|t|e, op n|t e : e
```

## Commuting operations

Lazy operations should be moved as late as possible, but no later than its first
eager usage. When it is used in only one successor of its basic block, it should
be moved to that successor. When it is used in all successors, it should remain
in its block.

Similarly, effectful eager operations should be moved as early possible, but no
earlier than other effects. If all successors of a basic block start with the
same effect, move it to that predecessor.

For example,

```wsf
^ 5+ swap 1 store
```

would have resemble this in an IR:

```ir
guard_stack 1
%0 = get_stack 0
%1 = Lit 5
%2 = Add %0 %1
%3 = Lit 1
eval %0
store %0 %3
push %2
```

By moving `eval` and `store` statements before the `Add` expression, the
arguments to `Add` are both numbers and it cannot error. The LHS would then not
be evaluated after its constructed.

```ir
guard_stack 1
%0 = get_stack 0
eval %0
%1 = Lit 1
store %0 %1
%2 = Lit 5
%3 = Add %0 %2
push %3
```

### Heap dependencies

- read-after-write dependency
- write-after-read dependency
- write-after-write dependency

It could be useful to have an API to follow these dependencies in either
direction, such as `follow_use_defs` and `follow_def_uses`.
