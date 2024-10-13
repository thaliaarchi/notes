# Architecture of egglog

## `actions`

## `ast`

- ast
- ast::desugar
- ast::expr
- ast::remove_globals

## `constraint`

## `core`

## `extract`

## `function`

- function
- function::binary_search
- function::index

### `function::table`

> A table type used to represent functions.
>
> Tables are essentially hash table mapping from vectors of values to values,
> but they make different trade-offs than standard HashMaps or IndexMaps:
>
> * Like indexmap, tables preserve insertion order and support lookups based on
>   vector-like "offsets" in addition to table keys.
>
> * Unlike indexmap, these tables support constant-time removals that preserve
>   insertion order. Removals merely mark entries as "stale."
>
> These features come at the cost of needing to periodically rehash the table.
> These rehashes must be done explicitly because they perturb the integer table
> offsets that are otherwise stable. We prefer explicit rehashes because
> column-level indexes use raw offsets into the table, and they need to be
> rebuilt when a rehash happens.
>
> The advantage of these features is that tables can be sorted by "timestamp,"
> making it efficient to iterate over subsets of a table matching a given
> timestamp range.
>
> Note on rehashing: We will eventually want to keep old/stale entries around to
> facilitate proofs/provenance. Early testing found that removing this in the
> "obvious" way (keeping 'vals' around, avoiding `mem::take()`s for stale
> entries, keeping stale entries out of `table` made some workloads very slow.
> It's likely that we will have to store these "on the side" or use some sort of
> persistent data-structure for the entire table.

It's is a form of memoization.

Values in the function table are stored by ID.

What does the timestamp represent? Its sequential, so not physical time. They
can be transformed to indices via binary search (`Table::transform_range`).

## `gj`

## `lib`

## `main`

## `serialize`

## `sort`: Sorts

By convention, primitive functions which have a result of `Option<()>` return
`Some(())` iff their predicate is true.

### `Unit` sort

Primitives:

| Name | Signature               | Operation |
| ---- | ----------------------- | --------- |
| `!=` | `() * () -> Option<()>` |           |

Is unit actually `()` or `Option<()>`?

### `String` sort

Primitives:

| Name            | Signature                            | Operation |
| --------------- | ------------------------------------ | --------- |
| `+`             | `string... -> string`                |           |
| `replace`       | `string * string * string -> string` |           |
| `count-matches` | `string * string -> i64`             |           |

### `bool` sort

Primitives:

| Name  | Signature             | Operation   |
| ----- | --------------------- | ----------- |
| `not` | `bool -> bool`        |             |
| `and` | `bool * bool -> bool` |             |
| `or`  | `bool * bool -> bool` |             |
| `xor` | `bool * bool -> bool` |             |
| `=>`  | `bool * bool -> bool` | Implication |

### `i64` sort

Primitives:

| Name        | Signature                  | Operation |
| ----------- | -------------------------- | --------- |
| `+`         | `i64 * i64 -> i64`         |           |
| `-`         | `i64 * i64 -> i64`         |           |
| `*`         | `i64 * i64 -> i64`         |           |
| `/`         | `i64 * i64 -> Option<i64>` |           |
| `%`         | `i64 * i64 -> Option<i64>` |           |
| `&`         | `i64 * i64 -> i64`         |           |
| `\|`        | `i64 * i64 -> i64`         |           |
| `^`         | `i64 * i64 -> i64`         |           |
| `<<`        | `i64 * i64 -> Option<i64>` |           |
| `>>`        | `i64 * i64 -> Option<i64>` |           |
| `not-i64`   | `i64 -> i64`               |           |
| `log2`      | `i64 -> i64`               |           |
| `<`         | `i64 * i64 -> Option<()>`  |           |
| `>`         | `i64 * i64 -> Option<()>`  |           |
| `<=`        | `i64 * i64 -> Option<()>`  |           |
| `>=`        | `i64 * i64 -> Option<()>`  |           |
| `bool-=`    | `i64 * i64 -> bool`        |           |
| `bool-<`    | `i64 * i64 -> bool`        |           |
| `bool->`    | `i64 * i64 -> bool`        |           |
| `bool-<=`   | `i64 * i64 -> bool`        |           |
| `bool->=`   | `i64 * i64 -> bool`        |           |
| `min`       | `i64 * i64 -> i64`         |           |
| `max`       | `i64 * i64 -> i64`         |           |
| `to-string` | `i64 -> Symbol`            |           |

### `f64` sort

Primitives:

| Name        | Signature          | Operation      |
| ----------- | ------------------ | -------------- |
| `neg`       | `f64 -> f64`       |                |
| `+`         | `f64 * f64 -> f64` |                |
| `-`         | `f64 * f64 -> f64` |                |
| `*`         | `f64 * f64 -> f64` |                |
| `^`         | `f64 * f64 -> f64` | Exponentiation |
| `/`         | `f64 * f64 -> f64` |                |
| `%`         | `f64 * f64 -> f64` |                |
| `<`         | `f64 * f64 -> f64` |                |
| `>`         | `f64 * f64 -> f64` |                |
| `<=`        | `f64 * f64 -> f64` |                |
| `>=`        | `f64 * f64 -> f64` |                |
| `min`       | `f64 * f64 -> f64` |                |
| `max`       | `f64 * f64 -> f64` |                |
| `abs`       | `f64 -> f64`       |                |
| `to-f64`    | `f64 -> f64`       |                |
| `to-i64`    | `f64 -> f64`       |                |
| `to-string` | `f64 -> f64`       |                |

### `Rational` sort

Primitives:

| Name                | Signature             | Operation              |
| ------------------- | --------------------- | ---------------------- |
| `+`                 | `R * R -> Option<R>`  | Checked addition       |
| `-`                 | `R * R -> Option<R>`  | Checked subtraction    |
| `*`                 | `R * R -> Option<R>`  | Checked multiplication |
| `/`                 | `R * R -> Option<R>`  | Checked division       |
| `min`               | `R * R -> R`          |                        |
| `max`               | `R * R -> R`          |                        |
| `neg`               | `R -> R`              |                        |
| `abs`               | `R -> R`              |                        |
| `floor`             | `R -> R`              |                        |
| `ceil`              | `R -> R`              |                        |
| `round`             | `R -> R`              |                        |
| `rational`          | `i64 * i64 -> R`      | Constructor            |
| `numer`             | `R -> i64`            |                        |
| `denom`             | `R -> i64`            |                        |
| `to-f64` `R -> f64` |                       |                        |
| `pow`               | `R * R -> Option<R>`  | Checked exponentiation |
| `log`               | `R -> Option<R>`      | Unimplemented          |
| `sqrt`              | `R -> Option<R>`      | Integer square root    |
| `cbrt`              | `R -> Option<R>`      | Unimplemented          |
| `<`                 | `R * R -> Option<()>` |                        |
| `>`                 | `R * R -> Option<()>` |                        |
| `<=`                | `R * R -> Option<()>` |                        |
| `>=`                | `R * R -> Option<()>` |                        |

where `R` is short for `Rational`.

### `Map` sorts

Sort constructor: `var` (not eq container sort), `var` (not container sort)

Primitives:

| Name               | Signature           | Operation |
| ------------------ | ------------------- | --------- |
| `rebuild`          | `M -> M`            |           |
| `map-empty`        | `() -> M`           |           |
| `map-insert`       | `M * K * V -> M`    |           |
| `map-get`          | `M K -> V`          |           |
| `map-not-contains` | `M K -> Option<()>` |           |
| `map-contains`     | `M K -> Option<()>` |           |
| `map-remove`       | `M K -> M`          |           |
| `map-length`       | `M -> i64`          |           |

where `M` is a map sort, `K` is its key sort, and `V` is its value sort.

### `Set` sorts

Sort constructor: `var` (not container sort)

Primitives:

| Name               | Signature             | Operation |
| ------------------ | --------------------- | --------- |
| `rebuild`          | `S -> S`              |           |
| `set-of`           | `E... -> S`           |           |
| `set-empty`        | `() -> S`             |           |
| `set-insert`       | `S * E -> S`          |           |
| `set-not-contains` | `S * E -> Option<()>` |           |
| `set-contains`     | `S * E -> Option<()>` |           |
| `set-remove`       | `S * E -> S`          |           |
| `set-get`          | `S * i64 -> E`        |           |
| `set-length`       | `S -> i64`            |           |
| `set-union`        | `S * S -> S`          |           |
| `set-diff`         | `S * S -> S`          |           |
| `set-intersect`    | `S * S -> S`          |           |

where `S` is a set sort and `E` is its element sort.

### `Vec` sorts

Sort constructor: `var` (not eq container sort)

Primitives:

| Name               | Signature           | Operation |
| ------------------ | ------------------- | --------- |
| `rebuild`          | `V -> V`            |           |
| `vec-of`           | `E... -> V`         |           |
| `vec-append`       | `V... -> V`         |           |
| `vec-empty`        | `() -> V`           |           |
| `vec-push`         | `V E -> V`          |           |
| `vec-pop`          | `V -> V`            |           |
| `vec-not-contains` | `V E -> Option<()>` |           |
| `vec-contains`     | `V E -> Option<()>` |           |
| `vec-length`       | `V -> i64`          |           |
| `vec-get`          | `V i64 -> E`        |           |
| `vec-set`          | `V i64 E -> V`      |           |
| `vec-remove`       | `V i64 -> V`        |           |

where `V` is a vec sort and `E` is its element.

### `UnstableFn` sorts

> Sort to represent functions as values.
>
> To declare the sort, you must specify the exact number of arguments and the
> sort of each, followed by the output sort:
> `(sort IntToString (UnstableFn (i64) String))`
>
> To create a function value, use the `(unstable-fn "name" [<partial args>])`
> primitive and to apply it use the `(unstable-app function arg1 arg2 ...)`
> primitive. The number of args must match the number of arguments in the
> function sort.
>
> The value is stored similar to the `vec` sort, as an index into a set, where
> each item in the set is a `(Symbol, Vec<Value>)` pairs. The `Symbol` is the
> function name, and the `Vec<Value>` is the list of partially applied
> arguments.

Constructor: variadic number of sorts

Primitives:

| Name           | Signature       | Operation |
| -------------- | --------------- | --------- |
| `unstable-fn`  | `F * V... -> V` |           |
| `unstable-app` | `F * V... -> V` |           |

where F is a function sort.

### Misc

| Name           | Signature             | Operation |
| -------------- | --------------------- | --------- |
| `value-eq`     | `T * T -> Option<()>` |           |
| `ordering-min` | `T * T -> T`          |           |
| `ordering-max` | `T * T -> T`          |           |

## `termdag`

## `typechecking`

## `unionfind`

- `struct UnionFind`: Baseline union-find implementation without sizes or ranks,
  using path halving for compression.
  - `parents: Vec<Cell<Id>>`: An index map from `Id` (the index) to the node's
    parent in the e-class.
  - `staged_ids: HashMap<Symbol, Vec<Id>>`: A set of `Id`s which have been
    marked as non-canonical; partitioned by sort.
  - `fn find(&mut self, id: Id) -> Id`: Looks up the canonical member of the
    given e-class. Halves the path.
  - `fn union(&mut self, id1: Id, id2: Id, sort: Symbol) -> Id`: Unifies the two
    e-classes and makes `id1` the canonical member. Adds the re-parented node,
    if any, to `self.staged_ids`.
  - `fn union_values(&mut self, val1: Value, val2: Value, sort: Symbol) -> Value`:
    Like `union`, but operates on value-numbered values of the same sort. Adds
  - `fn union_raw`: Like `union`, but does not stage re-parented nodes.

Why is `staged_ids` partitioned by sort?

## `util`

## `value`

## Other

- build.rs
- tests/files.rs
- tests/integration_test.rs
- tests/terms.rs
- web-demo/src/lib.rs
