# Implementing generators

- Convert into SSA
- Split control flow
  - Split into regions terminated by yield or return, each a separate function
  - Replace `return x` with `return (x, false)`
    and `yield x` with `return (x, true)`
- Reify locals
  - Define a structure in each region for the locals used
  - Define a union of all structures
  - Replace uses with fields
- Perform inlining, constant propagation, and dead code elimination
- Eliminate dead fields and unreachable regions
