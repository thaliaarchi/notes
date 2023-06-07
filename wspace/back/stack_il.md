# Stack substrate IL ideas from Kitten

## Syntax

- Quotations: `[...]`
- Definition: `define word [...]`

## Whitespace control flow

- `call word`: `word`
- `jmp word`: `[word] jmp` (generates a label, if the quotation is not a single
  word)
- `jz word`: `[word] COND jz` or `[word] [] COND if`
- `jz word`: `[word] COND jz` or `[word] [] COND 0= if`
- `jn word`: `[word] COND jn` or `[word] [] COND neg? if`

Or without using quotes, also have a label quote: `%word`

```
%word jmp
%word COND jz
%word COND jn
```

That removes the incongruence, where a quotation is local like a lambda, but a
jmp is to a non-local label.

More idiomatically, `jz` and `jn` can be written as `if`, but I think I want to
keep lower-level conditional branching (maybe find a name that unifies the two;
`br`?).

```
%word COND 0 = br
%word COND 0 < br
[word] [] COND 0 = if
```

(How to do then-only ifs?)

I can build further abstractions using labels on top of that, such as `switch`.
Then, I can desugar quotations to generated labels.

Kind of like Racket `cond`:

```
[then1] [1 =] cond
[then2] [2 =] cond
[then3] [3 =] cond
[else] else
```

To avoid successive conditions after the matching one from being evaluated,
maybe the conditions need to be quoted?

This is ugly, but would do the trick:

```
[[[[then1] 1= cond]
   [then2] 2= cond]
   [then3] 3= cond]
   [else] else]
```

Hmm. If I'm understanding `if` with quotations correctly, it must be syntax
sugar or something, in order for the quotation to be ignored for the condition,
e.g., in `[then] [else] dup = 0 if`, the `dup` would refer to the element under
the first quotation.

## Types

Statically-typed.

Type specification:
- Values need not be named, but can optionally be
- Maybe like Haskell, Kitten, or strict Forth comments

Types as values:
- Inferred types with Coq `{T}` syntax
- Like Zig `comptime` types; no runtime representation

Strategies for code reuse:
- Generics like Rust with traits that scope words to the types
- Quotations (e.g., compare and swap for quicksort)

## IRs

- With quotations and labels
- Quotations lowered to generated labels
