# MLIR: Scaling Compiler Infrastructure for Domain Specific Computation

[[paper](https://ieeexplore.ieee.org/abstract/document/9370308)]

## Abstract

Points:
- reusable and extensible compiler infrastructure
- addresses software fragmentation
- compilation for heterogenous hardware
- significantly reduces the cost of building domain-specific compilers
- connects existing compilers

## Introduction

Most compilers have a single abstraction level to interface with the system:
LLVM IR is roughly “C with vectors” and the JVM provides an “object-oriented
type system with a garbage collector” abstraction. Many LLVM frontends have
their own IR for domain-specific optimizations.

MLIR solves this by
- standardizing the SSA form–based data structures
- providing a declarative system for defining IR dialects
- providing a wide range of common infrastructure including documentation,
  parsing and printing logic, location tracking, multithreaded compilation
  support, pass management, etc.

### Contributions

- Parsimony: minimal builtin semantics, concepts, and programming interface
- Traceability: retain information; declarative
- Progressivity: avoid premature lowering; lower regions on demand

These principles are often at the expense of another.

### Where did MLIR come from?

Machine learning frameworks and compiler frontends similarly don't share
infrastructure or design principles.

## Design principles

*Little builtin, everything customizable (parsimony):* It should be able to
express a diverse set of abstractions with hard-coding concepts from those into
the system.

*SSA and regions (parsimony):* Nested regions are a first-class concept, which
allows direct representation of language abstractions.

*Maintain higher-level semantics (progressivity):* Only lose structure once no
longer needed, as recovering semantics once lowered is fragile. Different levels
of abstraction and concepts can be mixed and progressively lowered.

*Declaration and validation (parsimony and traceability):* Common
transformations should be implementable declaratively as machine-analyzable
rewrite rules. **A compiler infrastructure is only as good as the
transformations it supports.**

*Source location tracking (traceability):* Operation provenance, including
source provenance and transformations, should be traceable. For example,
essential for certification of cryptographic protocols.
