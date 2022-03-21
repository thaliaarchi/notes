# Rust Enum Expressivity

## Enum

Exhaustive

```rust
enum E {
    A(i32),
    B { y: String },
    C,
}

fn test(v: E) {
    match v {
        E::A(42) => ...,
        E::A(x) if x > 0 => ...,
        E::A(x) => ...,
        E::B { y } => ...,
        E::C => ...,
    }
}
```

## Wrapped enum

Exhaustive, stutters

```rust
struct A(42);
struct B { y: String };
struct C;

enum E {
    A(A),
    B(B),
    C(C),
}

fn test(v: E) {
    match v {
        E::A(A(42)) => ...,
        E::A(A(x)) if x > 0 => ...,
        E::A(A(x)) => ...,
        E::B(B { y }) => ...,
        E::C(C) => ...,
    }
}
```

## Coercively wrapped enum

Exhaustive, stutters, boilerplate

```rust
struct A(42);
struct B { y: String };
struct C;

enum_set!(E { A, B, C });

fn test(v: Into<E>) {
    match E::from(v) {
        E::A(A(42)) => ...,
        E::A(A(x)) if x > 0 => ...,
        E::A(A(x)) => ...,
        E::B(B { y }) => ...,
        E::C(C) => ...,
    }
}
```

which expands to:

```rust
struct A(42);
struct B { y: String };
struct C;

enum E {
    A(A),
    B(B),
    C(C),
}

impl From<A> for E { fn from(v: A) -> E { E::A(v) } }
impl From<B> for E { fn from(v: B) -> E { E::B(v) } }
impl From<C> for E { fn from(v: C) -> E { E::C(v) } }

fn test(v: Into<E>) {
    match E::from(v) {
        E::A(A(42)) => ...,
        E::A(A(x)) if x > 0 => ...,
        E::A(A(x)) => ...,
        E::B(B { y }) => ...,
        E::C(C) => ...,
    }
}
```

### IR example

The enum IDs are not globally-consistent

```rust
#[derive(Value)]
struct Const(i64);
#[derive(Value)]
struct Read;
#[derive(Value)]
struct Sub(Value, Value);
#[derive(Value)]
struct Neg(Value);

inst_set!(Base { Value, Read, Sub, Neg });
inst_set!(NoUnary { Value, Read, Sub });

// Moves and changes enum ID on each transformation
fn lower(inst: Base) -> NoUnary {
    match inst {
        Base::Neg(Neg(x)) => NoUnary::Neg(NoUnary::Const(0), x),
        // Ugly; want a safe conversion with a trait
        Base::Const(v) => NoUnary::Const(v),
        Base::Read(v) => NoUnary::Read(v),
        Base::Sub(v) => NoUnary::Sub(v),
    }
}
```

which expands to:

```rust
struct Const(i64);
struct Read;
struct Sub(Value, Value);
struct Neg(Value);

impl Value for Const { ... }
impl Value for Read { ... }
impl Value for Sub { ... }
impl Value for Neg { ... }

enum Base {
    Value(Value),
    Read(Read),
    Sub(Sub),
    Neg(Neg),
}

impl From<Value> for Base { fn from(x: Value) -> Base { Base::Value(x) } }
impl From<Read> for Base { fn from(x: Read) -> Base { Base::Read(x) } }
impl From<Sub> for Base { fn from(x: Sub) -> Base { Base::Sub(x) } }
impl From<Neg> for Base { fn from(x: Neg) -> Base { Base::Neg(x) } }

enum NoUnary {
    Value(Value),
    Read(Read),
    Sub(Sub),
}

impl From<Value> for NoUnary { fn from(x: Value) -> NoUnary { NoUnary::Value(x) } }
impl From<Read> for NoUnary { fn from(x: Read) -> NoUnary { NoUnary::Read(x) } }
impl From<Sub> for NoUnary { fn from(x: Sub) -> NoUnary { NoUnary::Sub(x) } }
impl From<Neg> for NoUnary { fn from(x: Neg) -> NoUnary { NoUnary::Neg(x) } }

// Moves and changes enum ID on each transformation
fn lower(inst: Base) -> NoUnary {
    match inst {
        Base::Neg(Neg(x)) => NoUnary::Neg(NoUnary::Const(0), x),
        // Ugly; want a safe conversion with a trait
        Base::Const(v) => NoUnary::Const(v),
        Base::Read(v) => NoUnary::Read(v),
        Base::Sub(v) => NoUnary::Sub(v),
    }
}
```

## Dynamic type match

Non-exhaustive, needs to be generated

The macro could take the name of a set, which it could then check for
exhaustiveness, since the pattern matching is split from the type
matching.

```rust
struct A(42);
struct B { y: String };
struct C;

type_set!(E { A, B, C })

fn test(v: &dyn std::any::Any) {
    #[type_match(E)]
    match v {
        A(42) => ...,
        A(x) if x > 0 => ...,
        A(x) => ...,
        B { y } => ...,
        C => ...,
    }
}
```

which expands to:

```rust
struct A(42);
struct B { y: String };
struct C;

fn test(v: &dyn std::any::Any) {
    let v_any = &v as &dyn ::std::any::Any;
    match v_any.type_id() {
        const { ::std::any::TypeId::of<A>() } => {
            match unsafe { v_any.downcast_ref_unchecked::<A>() } {
                A(42) => ...,
                A(x) if x > 0 => ...,
                A(x) => ...,
            }
        },
        const { ::std::any::TypeId::of<B>() } => {
            let B { y } = unsafe { v_any.downcast_ref_unchecked::<B>() };
            ...
        },
        const { ::std::any::TypeId::of<C>() } => ...,
        _ => unreachable!(),
    }
}
```
