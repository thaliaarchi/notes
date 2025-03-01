# Short notes on papers

## Abstracting Abstract Machines

[“Abstracting Abstract Machines”](https://matt.might.net/papers/vanhorn2010abstract.pdf)
(David Van Horn and Matt Might, ICFP 2010)

> With no recursive structure in the state-space, an abstract machine becomes
> eligible for conversion into an abstract interpreter through a simple
> structural abstraction.

Values in the heap can refer to other values in the heap, thus being recursively
defined. This doesn't mean that the heap itself is recursive, or by extension,
the store? The heap is just a flat address space, so I don't think it would be
recursive.

## CESK machine

[“Writing an interpreter, CESK-style”](https://matt.might.net/articles/cesk-machines/)
(Matt Might, 2012)

> The CESK machine is a state-machine in which each state has four components: a
> (C)ontrol component, an (E)nvironment, a (S)tore and a (K)ontinuation. One
> might imagine these respectively as the instruction pointer, the local
> variables, the heap and the stack.

...

> ```bnf
> lam ::= (λ (var1 ... varN) exp)
>
> aexp ::= lam
>       |  var
>       |  #t  |  #f
>       |  integer
>       |  (prim aexp1 ... aexpN)
>
> cexp ::= (aexp0 aexp1 ... aexpN)
>       |  (if aexp exp exp)
>       |  (call/cc aexp)
>       |  (set! var aexp)
>       |  (letrec ((var1 aexp1) ... (varN aexpN)) exp)
>
> exp ::= aexp
>      |  cexp
>      |  (let ((var exp)) exp)
>
> prim ::= +  |  -  |  *  |  =
> ```

Is `call/cc` like Whitespace `jmp` as opposed to Whitespace `call`?

## Go concurrency bugs

There are only two publicly available Go concurrency bug detectors.

Two orthogonal dimensions measured:
- cause: bugs categorized by misuse of shared memory or message passing
- behavior: blocking or non-blocking bugs

## Souper

TODO: Read it

> Instead of relying on a human, a superoptimizer uses search-based techniques
> to find short, nearly-optimal code sequences. Since [the original 1987 paper](http://www.stanford.edu/class/cs343/resources/superoptimizer.pdf)
> there have been several more papers; my favorite one is [the peephole
> superoptimizer](http://theory.stanford.edu/~aiken/publications/papers/asplos06.pdf)
> from 2006. For a number of years I’ve thought that LLVM would benefit from a
> peephole superoptimizer that operates on the IR.
> https://blog.regehr.org/archives/1109

## Verified compilation of seL4

[“Translation Validation for a Verified OS Kernel”](https://sci-hub.st/10.1145/2491956.2462183)
(Thomas Sewell, Magnus Myreen, and Gerwin Klein, PLDI 2013)

They verify the seL4 microkernel through translation validation of its C source
to ARM machine code. They prove that the artifact (ARM machine code) produced by
an existing compiler (gcc) for a chosen program (seL4) matches the source
semantics (C). The kernel is about 9,500 lines of C code and its specification
is over 200,000 lines of Isabelle/HOL proof.

They've formalized C and ARM semantics and have proven the kernel's correctness.
Since those correctness properties are in terms of its C code, if they used a
verified compiler like [CompCert](../compilers/compcert.md), they would still
have the issue of mismatches between seL4's and CompCert's semantics of C. Plus,
they can benefit from the potentially more aggressive optimizations available in
gcc (though they mention some they had to disable).

Their strategy is to prove in reverse, while CompCert proves a forwards pipeline
of verified passes. The system is structured around a decompiler, which takes
ARM code and its corresponding source C code and is able to automatically prove
equivalence of many cases using SMT. For restrictions imposed by the C standard,
such as forbidding signed arithmetic overflow or null and non-aligned
dereferences, they create guard statements which become verification
obligations.

As the verification is just for seL4, they're willing to make adjustments to the
seL4 source to fit the requirements of the proof or to respond to changes in
gcc, whereas a verified compiler team usually does not write the software
compiled with it.

## Lazy copy on alias

[“Deadlock and Resource Leak Free Languages”](https://www.youtube.com/watch?v=cUUPdE5cz-Q),
Jules Jacobs, 2025

In Rust, when aliasing xor mutability is violated, the program doesn't
typecheck. A more “Pythonic” strategy could be to make a copy if needed. This
changes the semantics of the language. Lazy copy on alias or copy on write.

```rust
let y : Vec<Vec<i32>> = …;
foo(&y[i], &mut y[j]); // ok!
// copy at run-time if i==j
```
