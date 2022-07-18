# Incremental Computation with Adapton

[Talk by Matthew A Hammer, March 2015](https://vimeo.com/122066659)

## Goals of incremental computation

- Simple: think about from-scratch algorithm
- Correct: derived from from-scratch algorithm
- Efficient: compare to from-scratch algorithm

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
  - Self-adjusting computation: dynamic dependency graphs
- Demand-driven, concurrent (PLDI 2014)
  - Adapton: demanded computation graphs

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

Runtime internals
- Demanded computation graph (DCG) represents a dynamic partial order of
  dependencies
