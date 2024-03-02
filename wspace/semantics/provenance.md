# Whitespace integer provenance

> Oh no, I think integers in lazy Whitespace have provenance 😱

My reaction while reading the Rust RFC [“Rust Has Provenance”](https://github.com/rust-lang/rfcs/blob/master/text/3559-rust-has-provenance.md#integers-do-not-have-provenance)
by Ralf Jung.

## Brief semantics

The section “Integers do not have provenance” says, in part:

> While pointers have provenance for the reasons stated above, integers do not.
> This means that values of integer type are fully determined by the bits one
> can observe during execution of a compiled program. (This is in contrast to
> other types where seeing the bits is insufficient to reconstruct the abstract
> value, since one cannot deduce if a byte is initialized or which provenance a
> pointer carries.)

In contrast, Whitespace integers are more complicated. Whitespace has mixed
[lazy and eager evaluation](./laziness.md) for its instructions. Due to its
reference implementation in Haskell, it inherited some of its laziness, but
without any of its principled design. Even though Whitespace only has an integer
type, its values are actually expression thunks, which are evaluated when
demanded. Only then are errors thrown, which could be never.

The fully correct model is to use reduce programs to the same STG intermediate
representation that GHC uses, but I'm convinced there are more specialized IRs
that are better for representing Whitespace.

## Transformations

Continued:

> This is crucial to obtain all the usual arithmetic operations on integers:
> integers with provenance have difficulty supporting transformations such as
> `x * 0 --> 0` (which forgets the fact that the final value used to
> syntactically depend on `x`), and they are fundamentally incapable of doing
> optimizations like the following:
>
> ```rust
> if x == y {
>   // in this block, replace `x` by `y` or vice versa
> }
> ```

While implementing integer peephole transformations in lazy-wspace, I saw many
cases where the typical transformations do not work in Whitespace, due to this
provenance. The example `x * 0 --> 0` transformation is unsound in Whitespace,
because arithmetic instructions are lazy and only compute their result when
demanded. Results are demanded in a few instances, most noticeably by I/O
instructions, but not by arithmetic instructions. Consider the program `push 5,
push 0, div, end`. Even though a division by zero occurs, that subexpression is
never demanded, so the program does not error. Thus, `(y / 0) * 0 !--> 0`.
Instead, it could be transformed as `(y / 0) * 0 --> y / 0`, but this only works
when the fallibility of all subexpressions is known. In the general case,
`x * 0 --> 0` iff `x` produces an integer and `x * 0 --> x` otherwise (iff `x`
produces an error).

I modeled this in lazy-wspace as [`error_or`] with the signature
`%r = error_or %maybe_error %or_value`, which selects the LHS, if it's an error,
otherwise the RHS. This would then be `%r = error_or %x 0`.

[`error_or`]: https://github.com/thaliaarchi/lazy-wspace/blob/1e3c11f4b685eb75995d9bd0ca7714b458605fa4/lazy-wspace/src/ir/instructions.rs#L354-L357

## Error tag

The NaT (“not a thing”) flag bit on ia64 reminds me of Whitespace integers.

NaT signals that the register does not contain a valid value, propagates
similarly to NaN and is usually set from speculative execution. With it, each
register is 65 bits. Raymond Chen [explains it][ia64] and Ralf Jung references
that in a [post][uninit] on uninitialized memory.

This suggests a different way of thinking of errors, as a value * error tuple,
instead of a value + error union. When it's an error, the value is not used and
can be anything. Transformations could replace error expressions with any other
that has the same error flag (though this is likely limited to subexpressions in
most cases, since errors are tied to the source location). Optimizations for NaN
may be useful here.

[ia64]: https://devblogs.microsoft.com/oldnewthing/20040119-00/?p=41003
[uninit]: https://www.ralfj.de/blog/2019/07/14/uninit.html#what-the-hardware-does-considered-harmful

## Runtime

Here's a possible runtime representation for integers and errors:

When the LSB is set, it denotes a 63-bit integer. Arithmetic operations shift it
right before operating on it and shift it left and set the bit again before
storing it. When the LSB is unset, it either denotes a GMP integer or an error.
We could use another bit unused from the alignment to mark an error. (This
incurs two branches for the GMP case; can that be reduced?) Since the set of
errors is static, it indexes into a table.

Runtime functions (e.g., `wspace_add`, etc.) are polymorphic over these three
representations. They would eagerly compute results and not expose errors until
demanded, but not use thunks. This allows it to use more traditional SSA form
IRs and not need an STG machine. Whenever the precise type is known by the
compiler, specialized calls can be used.

GMP integers would be reference counted and would usually use RC-aware
functions. Operations consume their operands, decrementing their counters and
reusing them when zero. Then, even `mpz_t` needs to be allocated, not just its
limbs. If there is a way to allocate the data inline with the `size` and `alloc`
fields of `mpz_t`, omitting the `d` pointer, and including the reference count,
then they could be referenced by thin pointers without extra indirection.
[Custom allocators](https://gmplib.org/manual/Custom-Allocation) would be setup,
which manage the prefixed fields, offsetting the allocation GMP sees, and
handling errors like the reference interpreter. Since functions take `mpz_t`,
not `*mpz_t`, they would be passed by registers and the fields could be unpacked
from the heap data first.
