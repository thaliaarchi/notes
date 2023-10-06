# Coffee Compiler Club 2023-10-06 with Simon Peyton Jones

[Recording](https://www.youtube.com/watch?v=pYNgu7dG0Tc)

Graph reducing

Updates: How does it overwrite the the lambda with the computation?

Züri Hack 2020?

Core language is Lambda Cube omega

Recommended papers:
- “Implementing Lazy Functional Languages on Stock Hardware: The Spineless
  Tagless G-machine” Simon Peyton Jones, long but a readable tutorial paper
- “Kinds are Calling Conventions”
- “Compiling without Continuations”
- “Why Functional Programming Matters” John Hughes, establishes why laziness
  promotes modularity
- “Comprehending Monads” Wadler

You talked about lowering to C-- and then to LLVM IR. Since lazy evaluation is
not common, I assume LLVM doesn't have strictness analysis. What interesting
strictness analysis does GHC do?

What do you think about the adoption of lazy evaluation in languages? I just
know of Haskell and Idris with it. Do you think it should be more or less
common?

Space leaks

Legacy of laziness: pureness is more valuable than laziness

## Strictness analysis

See the demand analysis directory in GHC.

Strictness analysis in the compiler is more advanced than the literature. A
paper on that would be welcome.

It tries to rewrite call-by-need to call-by-name, when the arguments are
guaranteed to be used.
