# Static single-assignment form and continuation-passing style

## Kelsey 1995

[“A Correspondence between Continuation Passing Style and Static Single
Assignment Form”](https://mumble.net/~kelsey/papers/cps-ssa.ps.gz)
(Richard A. Kelsey, 1995)

Since functional programs use small procedures, most optimization requires
interprocedural analysis when in CPS. This paper annotates lambdas which are
continuations, to reduce the number of full procedures. In SSA, procedures are
larger, so this is less of a problem [§1]. When the source language does not do
such annotation, they can be determined by finding a set of procedures which are
always called with the same continuation, substituting in that continuation for
the variables. Those procedures are now continuations nested within a single
large procedure [§8].

Not all CPS programs can be translated to SSA with this paper's algorithm. For
example, non-local returns, such as longjumps in C or
call-with-current-continuation in Scheme, are neither passed as a procedure's
continuation nor called exclusively tail-recursively within the same procedure.

My Whitespace IRs were intended to be SSA, but the decoupling of the argument
and return stacks probably make it neither SSA nor CPS. Is there a way to
represent such control flow without a dynamic return stack?

## Appel 1998

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
