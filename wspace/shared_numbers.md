# Low-level representation for shared numbers

A higher-level API using Rug's API:

```rust
use rug::{Integer, integer::BorrowInteger};

enum Val {
    Owned(Integer),
    Borrowed(BorrowInteger<'static, Integer>),
    Small(u64),
    Thunk(Op, Rc<UnsafeCell<Val>>, Rc<UnsafeCell<Val>>),
}
```

A lower-level API directly using the GMP API:

```rust
// mpz_t is usually 16 bytes on 64-bit systems
use gmp_mpfr_sys::gmp::mpz_t;

enum Val { // 24 bytes
    /// An owned arbitrary-precision number
    Big(mpz_t), // 16 bytes
    /// An owned 64-bit number. It's an inlined BorrowInteger. If all the
    /// relevant mpz operations accept u32, this may not be necessary.
    Small(mpz_t, [u32; 2]), // 24 bytes
    /// An owned unevaluated binary arithmetic expression.
    Thunk(Op, NonZero<StrongRc<Val>>, NonZero<StrongRc<Val>>), // 24 bytes
    /// An owned unevaluated error expression.
    Error(ValError),

    /// A heap-allocated, reference-counted value reference.
    Ref(NonZero<StrongRc<Val>>), // 8 bytes
    /// A reference to an immutable arbitrary-precision number, usually in
    /// static data.
    Const(NonZero<mpz_t>), // 8 bytes
}

/// A more compact reference-counted value, than `Rc`. The weak count is
/// unneeded and the strong count is changed from `usize` to `u32`. Containing
/// an `mpz_t`, it would be 20 bytes.
struct StrongRc<T: ~Sized> {
    inner: T,
    count: Cell<NonZeroU32>,
}
```

Reference counting should have instructions in the IR, so that operations can be
coalesced. See [Wikipedia](https://en.wikipedia.org/wiki/Reference_counting#Dealing_with_inefficiency_of_updates)
for an overview of algorithms for optimization.
