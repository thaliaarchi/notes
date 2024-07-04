# Graph IRs

## Control flow and optimizations

Souper is a superoptimizer for various compilers with its own IR. Since it does
not have control flow, its optimizations are simpler. Could some of this design
be used when combined with control flow and e-graphs, to remove the acyclicity
constraint of ae-graphs?

> Souper does not have control flow, though it does provide two constructs for
> representing dataflow facts learned from control flow in the program being
> optimized[:] the `infer` keyword [which] indicates the root node that Souper
> is being asked to optimize the computation of [and] a path condition—an
> assertion that a variable holds a particular value, that typically comes from
> executing through a conditional branch in a program.

Souper also has phis:

> Lacking control flow, Souper preserves information about correlated phi nodes
> using values of *block type*.
