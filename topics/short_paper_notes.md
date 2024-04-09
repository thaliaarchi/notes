# Short notes on papers

## Souper

TODO: Read it

> Instead of relying on a human, a superoptimizer uses search-based techniques
> to find short, nearly-optimal code sequences. Since [the original 1987 paper](http://www.stanford.edu/class/cs343/resources/superoptimizer.pdf)
> there have been several more papers; my favorite one is [the peephole
> superoptimizer](http://theory.stanford.edu/~aiken/publications/papers/asplos06.pdf)
> from 2006. For a number of years I’ve thought that LLVM would benefit from a
> peephole superoptimizer that operates on the IR.
> https://blog.regehr.org/archives/1109

## SSA is functional programming

[“SSA is Functional Programming”](https://dl.acm.org/doi/abs/10.1145/278283.278285)
(Andrew W. Appel, 1998)

Appel explains phi-nodes in SSA form by first demonstrating a naïve algorithm to
merge values across blocks, where a phi-functions is produced every time a value
refers to a definition in another block, instead of just at control flow merges.
He observes that the program can then be viewed as a set of mutually recursive
functions (blocks), where each takes as arguments the full set of all variables
and call each other. (This is starting to look like the block argument style of
SSA!) Phi-functions correspond, in an inside-out way, to the real functions.

Then, the algorithm for nesting functions to eliminate unnecessary argument
passing is the algorithm for converting to SSA form. That is, using a dominator
tree (citations for algorithm listed). This automatically converts a procedure
into a well-structured functional program with nested scope.

Arrays are handled with dependence analysis techniques in parallelizing
compilers.

How would this interact with irreducible control flow?

> **Advertisement.** Chapter 19 of my new *Modern Compiler Implementation*
> textbooks [3, 4, 5] has readable and detailed coverage of many relevant
> topics:
>
> - SSA form and its rationale;
> - Dominance frontiers and calculation of SSA form;
> - The Lengauer-Tarjan algorithm for efficient calculation of dominators;
> - Optimization algorithms using SSA: dead-code elimination, conditional
>   constant propagation; control dependence; construction of register
>   interference graphs;
> - Structural properties of SSA form;
> - Functional intermediate representations (CPS, ANF) and their relation to
>   SSA.
>
> For more information about the book, visit
> http://www.cs.princeton.edu/~appel/modern.

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
