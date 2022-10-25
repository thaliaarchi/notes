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

## IR design

*Textual representation:* Fully reflects in-memory representation.
User-definable syntax.

*Operations:* Everything is modeled as ops. User-extensible. Declarative syntax
based on LLVM TableGen. Consists of an opcode, zero or more typed operands and
results in SSA form, attributes, regions, successor blocks, and location
information. Passes treat unknown ops conservatively. Verifiers in ops enforce
op invariants.

*Attributes:* Compile-time information about ops. Op instances have attribute
values.

*Location information:* Processed and propagated throughout the system. Compact.
Extensible and may refer to existing location-tracking systems; e.g., AST nodes,
file-line-column address, DWARF, etc.

*Regions and blocks:* Regions provide the nesting mechanism in MLIR: ops may
contain regions, each of which has a list of blocks in a CFG, that each contain
ops. Region semantics specified by the op. Blocks end with a terminator op,
which may have successor blocks. Uses a functional form of SSA, instead of phi
nodes, where each block has typed arguments, that terminators pass values to.
The region entry block's values are defined by the enclosing op's semantics. The
explicit graph design and op extensibility is reminiscent of sea of nodes.

*Value dominance and visibility:* Ops can only use values that are in scope
according to SSA dominance, nesting, and semantic restrictions. Region-based
visibility is by lexical region definitions. Ops may be isolated from above,
such as `func.func` (`std.func` in paper), so values defined outside may not be
referenced, allowing parallel compilation, because no use-def chains cross the
isolation barriers.

*Symbols and symbol tables:* Ops can have an attached symbol table, which
associates string names to IR objects and can be used prior to definition.

*Dialects:* Logical grouping of ops, attributes, and types. Intermixed for
progressive lowering, reuse, extensibility, and flexibility.

*Type system:* Every value is typed, by the producing op or block argument.
User-extensible and may refer to foreign type systems. Strict equality without
coercions. Supports non-dependent types, including trivial, parametric,
function, sum, and product types. Dependent types are possible, but would be
opaque to the IR.

*Functions and modules:* Usually structured into functions and modules, which
are implemented as ops. A module defines top-level constructs, including
functions, and does not transfer control flow. A function has a single region
and is compatible with `func.call` and `func.return` (`std` dialect in paper).

## Evaluation: Applications of MLIR

### TensorFlow graphs

### Polyhedral code generation

### Fortran IR

### Domain-specific compilers

## Consequences of the MLIR design

### Reusable compiler passes

### Dialect-specific passes

### Mixing dialects together

### Parallel compilation

### Interoperability

### Unopinionated design provides new challenges

### Looking forward

## Related work

## Conclusion and future work
