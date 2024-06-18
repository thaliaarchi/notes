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

## Recursion

An in-order traversal for a tree as a generator would look like such:

```rust
struct Tree<T> {
    value: T,
    left: Option<Box<Tree<T>>>,
    right: Option<Box<Tree<T>>>,
}

impl<T> Tree<T> {
    gen fn in_order(&self) -> &T {
        if let Some(left) = self.left.as_ref() {
            for x in left.in_order() {
                yield x;
            }
        }
        yield self.value;
        if let Some(right) = self.right.as_ref() {
            for x in right.in_order() {
                yield x;
            }
        }
    }
}
```

To support recursive generators, the call stack needs to be reified. It would
be desugared to:

```rust
struct Stack<D, Y>(Vec<Frame<D, Y>>);
struct Frame<D, Y> {
    state: fn(&mut Stack<D, Y>) -> Option<Y>,
    data: D,
}

fn in_order<T>(t: &Tree<T>) -> impl Generator<&T> {
    let mut stack = Stack::new();
    stack.push(Frame { state: in_order_states'0, data: t });
    RecGenerator::new(stack)
}

fn in_order_states<T>(stack: &mut Stack<&Tree<T>, &T>) -> Option<&T> {
'entry:
    let frame = stack.top_mut();
    goto frame.state;
'0:
    if let Some(left) = frame.data.left.as_ref() {
        stack.push(Frame { state: in_order_states'0, data: &*left });
        frame.state = in_order_states'1;
        goto 'entry;
    }
    return Some(&frame.t.value);
'1:
    if let Some(right) = frame.data.right.as_ref() {
        stack.push(Frame { state: in_order_states'0, data: &*right });
        frame.state = in_order_states'2;
        goto 'entry;
    }
'2:
    stack.pop();
    None
}
```

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
