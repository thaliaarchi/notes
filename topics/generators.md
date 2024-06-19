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

To support recursive generators, the call stack needs to be reified. It must be
heap allocated if the generator escapes.

What about non-tail recursive functions or recursive calls that do not consume
the entire sequence? Such recursive calls would need to construct a new
iterator, so it could drive the iteration, but they could reuse the same stack,
but with a lower bound, to not underflow the sub-frame. If some states are not
reachable by the sub-iterator and the unused fields are at the tail, the state
structure could be shrunk without needing code duplication.

### Example

An in-order traversal for a tree as a generator would look like such:

```rust
pub struct Tree<T> {
    value: T,
    left: Option<Box<Tree<T>>>,
    right: Option<Box<Tree<T>>>,
}

impl<T> Tree<T> {
    pub gen fn in_order(&self) -> &T {
        if let Some(left) = self.left.as_deref() {
            for x in left.in_order() {
                yield x;
            }
        }
        yield self.value;
        if let Some(right) = self.right.as_deref() {
            for x in right.in_order() {
                yield x;
            }
        }
    }
}
```

With the states expressed as an enum and the call stack reified, it would be
desugared to (valid code):

```rust
struct TreeInOrderIter<'a, T> {
    stack: Vec<State<'a, T>>,
}
enum State<'a, T> {
    S0 { t: &'a Tree<T> },
    S1 { t: &'a Tree<T> },
    S2 { t: &'a Tree<T> },
    S3,
}

impl<T> Tree<T> {
    pub fn in_order(&self) -> impl Iterator<Item = &T> {
        let mut stack = Vec::new();
        stack.push(State::S0 { t: self });
        TreeInOrderIter { stack }
    }
}

impl<'a, T> Iterator for TreeInOrderIter<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            let state = self.stack.last_mut()?;
            match *state {
                State::S0 { t } => {
                    *state = State::S1 { t };
                    if let Some(left) = t.left.as_deref() {
                        self.stack.push(State::S0 { t: left });
                    }
                }
                State::S1 { t } => {
                    *state = State::S2 { t };
                    return Some(&t.value);
                }
                State::S2 { t } => {
                    *state = State::S3;
                    if let Some(right) = t.right.as_deref() {
                        self.stack.push(State::S0 { t: right });
                    }
                }
                State::S3 => {
                    self.stack.pop();
                }
            }
        }
    }
}
```

It could then be transformed to use a function pointer and a union, instead of
a tagged union:

```rust
struct TreeInOrderIter<'a, T> {
    stack: Vec<Frame<'a, T>>,
}
struct Frame<'a, T> {
    state: fn(TreeInOrderIter<'a, T>) -> Option<Y>,
    t: &'a Tree<T>,
}

impl<T> Tree<T> {
    pub fn in_order(&self) -> impl Iterator<Item = &T> {
        let mut stack = Vec::new();
        stack.push(Frame { state: TreeInOrderIter::next'0, t: self });
        TreeInOrderIterator { stack }
    }
}

impl<'a, T> Iterator for TreeInOrderIter<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<Self::Item> {
    'entry:
        let frame = self.stack.last_mut()?;
        goto frame.state;
    'entry_fast:
        let frame = self.stack.last_mut().unwrap_unchecked();
        goto frame.state;
    '0:
        if let Some(left) = t.left.as_deref() {
            frame.state = TreeInOrderIter::next'1;
            self.stack.push(Frame { state: TreeInOrderIter::next'0, t: left });
            goto 'entry_fast;
        }
    '1:
        frame.state = TreeInOrderIter::next'2;
        return Some(&frame.t.value);
    '2:
        if let Some(right) = t.right.as_deref() {
            frame.state = TreeInOrderIter::next'3;
            self.stack.push(Frame { state: TreeInOrderIter::next'0, t: right });
            goto 'entry_fast;
        }
    '3:
        self.stack.pop();
        goto 'entry;
    }
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
