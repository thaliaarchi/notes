# Incremental Computation with Adapton

Talk by Matthew A. Hammer, March 2015 [[video](https://vimeo.com/122066659)]

PLDI, June 2014 [[slides](http://matthewhammer.org/adapton/adapton-slides.pdf)]

## Goals of incremental computation

- Simple:
  - Think about from-scratch algorithm
  - Programs are simple to read and write
  - Programmer focuses on the domain
- Correct:
  - Derived from from-scratch algorithm
  - Abstractions enforce correct usage of primitives
  - Model formally and prove correct once
- Efficient:
  - Compared to from-scratch algorithm
  - Optimized implementations for abstractions
  - Engineering burdens shared across many programs

## Convex Hull example

Convex Hull is very complex to manually implement incrementally (takes a
100-page dissertation of proofs)

- Incremental computation is logarithmic with an initial constant investment
- From-scratch computation is linear

## Programmers deserve a systematic approach

- Claim 1: incremental computation is everywhere
- Claim 2: one-off solutions are complex
- Analogies: garbage collection and parallelism free the programmer from
  manually reasoning about those, because they're handled at the language level

## Is there a unified, systematic approach?

| Application domain | Input         | Compute          | Output                 |
| ------------------ | ------------- | ---------------- | ---------------------- |
| spreadsheets       | data, formula | evaluate formula | plots, chart           |
| build systems      | source files  | compile          | binaries, test results |
| databases          | tables        | evaluate query   | tables                 |
| web browsers       | HTML, CSS     | render           | rendering              |
| games, simulations | system state  | advance state    | system state           |
| proof assistants   | proof script  | proof search     | proof object           |

## Brief history of incremental computation

- Special domains (1960s-1990s)
  - Dynamic programming / memo tables
  - Attribute grammars / dependency graphs
  - Special languages
- General, batch model (2000s)
  - Self-adjusting computation: dynamic dependency graphs (total order)
- Demand-driven, concurrent (PLDI 2014)
  - Adapton: demanded computation graphs (partial order)

## What we want as users

- Demand-driven: multiple entry points; state can be inconsistent, until used
- Reuse patterns (supported by partial-, not by total orders)
  - Sharing: sharing computations
  - Swapping: swapping input or evaluation order
  - Switching: changing demand or control flow

## Adapton: interactive incremental computation

Programming abstractions
- Reference cells:
  - Outer role: `ref` (create) and `set`
  - Inner role: `get`
- Suspended computations:
  - Outer and inner: `thunk` (create) and `force` (force evaluation)

Uses a demanded computation graph (DCG) as its base

## Demanded computation graph (DCG)

Represents a dynamic partial order of dependencies to propagate changes on
demand.

Phases:
- Dirtying phase: `set` operation
  - Walk downwards (inputs to outputs)
  - Walk stops early at dirty nodes
- Propagation phase: `force` operation
  - Walk upwards (outputs to inputs)
  - Reuse clean DCG via memoization

## Compared to self-adjusting computation

In benchmarks of list and tree applications (filter, map, reduce min/sum,
quicksort, and mergesort) and a simple interpreter, Adapton performs better than
SAC, because the partial order allows for more reuse.

Adapton has a exponential speedup, because it gives you dynamic programming for
free, while SAP has a 100x slowdown because it has no sharing.

## Nominal Adapton

Adapton Classic:
- Strengths
  - Demand-driven
  - Reuse patterns: sharing, swapping, switching
- Limitations
  - Inner computations cannot overwrite / mutate
  - Reuse patterns: batch demand, replace

Nominal Adapton:
- Names:
  - Identify data and code: reference cells, thunks
  - Indirections: identity vs content
  - First-class values
- Reuse patterns: batch demand, replace

For example, when inserting a value in incrementally-computed mergesort, by
naming values, only new values receive fresh thunks and the propagated changes
maintain the same names, so freshness is limited to the inserted element and
there are less memo misses.

## Adapton in Rust

- GC is an adversary to IC: the IC caching leads to unsoundness when using weak
  refs, so they essentially write a ref-counted GC with finalizers in a GCed
  language
- Rust's concurrency would be a good fit for Adapton
- The Servo layout engine uses incremental layout, so they want to see if
  Adapton can be as efficient as its custom change propagation

## Adapton for program analysis and verification

Applying IC with Adapton to systematic program analysis techniques for new IDE
frameworks.

## Complexity

The simple, correct, and efficient properties hinge on the from-scratch
implementation. This is closely related to parallelism metrics: parallel
algorithms can be measured by work and depth, while Adapton algorithms can be
measured by work, depth, and “fan out” (i.e., how many values are affected on a
change).

## Implicit, universal IC

Information flow analysis from security analysis can be used to make a regular
program incremental.
