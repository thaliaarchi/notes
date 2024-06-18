# Implementing generators

- Convert into SSA form.
- Split the generator into regions terminated by `yield` or `return`, each a
  separate function, and transform region locals into function parameters.
- Replace `return` with `return None` and `yield x` with `return Some(x)`.
- Reify locals
  - Define a structure in each region for the locals used
  - Define a union of all structures
  - Replace uses with fields
- Perform inlining, constant propagation, and dead code elimination
- Eliminate dead fields and unreachable regions

## Return types

If a generator was transformed to implement the Rust `Iterator` trait, the
argument to `yield` would have the type `Self::Item` and the argument to
`return` would have the type `()`.

```rust
trait Iterator {
    type Item;

    fn next(&mut self) -> Option<Self::Item>;
}
```

How could return types be generalized?

In Python, `for` loops may have an [`else` clause](https://docs.python.org/3/tutorial/controlflow.html#break-and-continue-statements-and-else-clauses-on-loops),
which is executed after the final iteration, if the loop did not break early.

Combined with blocks-as-values, `for` loops could then produce a value. If added
to Rust, this could be:

```rust
let x = for a in [1, 2, 3] {
    break a;
} else {
    4
};
```

Which is equivalent to the following scoped break:

```rust
let x = 'block: {
    for a in [1, 2, 3] {
        break 'block a;
    }
    4
};
```

Then, `Iterator` could be extended to enable return types:

```rust
trait Iterator {
    type Item;
    type Break;

    fn next(&mut self) -> Result<Self::Item, Self::Break>;
}
```

In [Bolin](https://bolinlang.com/), in addition to `on complete` (`for`-`else`),
loops may have `on break` and `on empty`.

```bolin
v := 0
for value in [10, 20, 30] {
	break
}
on break { v .= 100 }
on empty { v .= 200 }
on complete { v .= 300 }
assert(v == 100)
```
