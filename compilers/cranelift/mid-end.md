# Cranelift mid-end optimizers

RFCs and key developments in the evolution of optimizers in Cranelift's mid-end.

## Peepmatic

- [Introduce peepmatic: a peephole optimizations DSL and peephole optimizer compiler](https://github.com/bytecodealliance/wasmtime/pull/1647)
  (2020-05-01)
- [Remove Peepmatic!!!](https://github.com/bytecodealliance/wasmtime/pull/3543)
  (2021-11-17)

## CLIF

- [A New Backend for Cranelift, Part 1: Instruction Selection](https://cfallin.org/blog/2020/09/18/cranelift-isel-1/)
  (2020-09-18)

## ISLE

- [RFC: design of ISLE instruction-selector DSL](https://github.com/bytecodealliance/rfcs/blob/main/accepted/cranelift-isel-isle-peepmatic.md)
  [[PR](https://github.com/bytecodealliance/rfcs/pull/15)] (2021-08-18)
- ISLE tutorial from [2021-10-04 Cranelift meeting](https://github.com/bytecodealliance/meetings/blob/main/cranelift/2021/cranelift-10-04.md)
  ([slides](https://docs.google.com/presentation/d/e/2PACX-1vTL4YHdikG70GZuWvnUOqWdE31egZDBj-2-ajsNfoLkeUn8Bpvk_a5vEFOQqsolcUuR9pmYj2qPF-_J/pub),
  [text](https://github.com/cfallin/isle#tutorial))
- [Cranelift's Instruction Selector DSL, ISLE: Term-Rewriting Made Practical](https://cfallin.org/blog/2023/01/20/cranelift-isle/)
  (2023-01-20)
- [RFC: Extended Patterns in ISLE](https://github.com/bytecodealliance/rfcs/blob/main/accepted/isle-extended-patterns.md)
  [[PR](https://github.com/bytecodealliance/rfcs/pull/21)] (2022-04-24)
- [Lightweight, Modular Verification for WebAssembly-to-Native Instruction Selection](https://cfallin.org/pubs/asplos2024_veri_isle.pdf)
  by Alexa VanHattum, Monica Pardeshi, [Chris Fallin](https://cfallin.org/academics/),
  Adrian Sampson, and Fraser Brown, ASPLOS 2024

## æ-graphs

- [RFC: Cranelift: Using E-Graphs for Verified, Cooperating Middle-End Optimizations](https://github.com/bytecodealliance/rfcs/blob/main/accepted/cranelift-egraph.md)
  [[PR](https://github.com/bytecodealliance/rfcs/pull/27)] (2022-06-29)
- [egraph-based midend: draw the rest of the owl (productionized)](https://github.com/bytecodealliance/wasmtime/pull/4953)
  (2022-09-23)
- [ægraphs: Acyclic E-graphs for Efficient Optimization in a Production Compiler](https://vimeo.com/843540328)
  (2023-06-18)
- Issues:
  - [cranelift/egraphs: allow simplifying trapping arithmetic](https://github.com/bytecodealliance/wasmtime/issues/5908)
    (2023-03-01)
    - [Port divide-by-constant magic number optimizations from simple_preopt to ISLE mid-end](https://github.com/bytecodealliance/wasmtime/issues/6049)
      (2023-03-17)
  - [cranelift: Better heuristics for instruction scheduling](https://github.com/bytecodealliance/wasmtime/issues/6260)
    (2023-04-20)
