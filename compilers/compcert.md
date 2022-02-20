# Formal verification of a realistic compiler

https://xavierleroy.org/publi/compcert-CACM.pdf

CompCert
- verified with Coq
- front-end translates Clight subset of C to low-level structured IL
  Cminor
- lightly-optimizing back-end generates PowerPC asm from Cminor

## Intermediate languages

The compiler is composed of 14 passes with 8 intermediate languages.

### Clight

Large subset of C

Supports:
- pointers, arrays, `struct`, `union`
- `if`, loops, `break`, `continue`, structured `switch`
- functions, recursion, function pointers

Omits:
- `long long`, `long double`
- `goto`, non-structured `switch` (e.g., Duff's device)
- passing `struct` and `union` parameters and results by value
- variadic args

Supported via desugaring:
- side effects within expressions
- block-scoped variables

Semantics defined in big-step operational style

Undefined C behaviors such as null dereference or out-of-bounds array
access are consistent “gone wrong” behaviors.

Memory is modeled as disjoint blocks accessed through byte offsets.
Pointers are pairs of a block identifier and offset.

### C#minor

- Typeless
- Distinct arithmetic operators for integers, pointers, and floats
- Loops replaced by infinite loops with blocks and multi-level exits
  from enclosing blocks
- Operator overloading resolved
- Memory loads and stores made explicit

### Cminor

Omits `&` operator: never-addressed scalar local variables are assigned
to Cminor local variables and are candidates for register allocation;
other local variables are stack-allocated.

### CminorSel

- Processor-dependent
- Additional operators like combined arithmetic instructions (e.g.,
  `add-immediate`, `not-and`, `rotate-and-mask`)
- Addressing modes
- A class of condition expressions (only evaluated for truth value).

### RTL

- Register transfer language
- Control represented as a CFG, where each node carries a machine-level
  instruction operating over pseudo-registers
- Optimizations with data flow analysis: constant propagation, CSE, lazy
  code motion

§4.1:

- Instructions:
  - `nop` (unconditional jump)
  - `op` (arithmetic)
  - `load`
  - `store`
  - `call`
  - `tailcall`
  - `cond` (conditional branch)
  - `return`
- CFG
- Internal functions: name, signature, params, stack size, entrypoint
  (label), code (CFG)
- External functions: name, signature

Dynamic semantics specified in small-step operation style as a labeled
transition system.

### LTL

- Registers allocated via interference graph coloring
- Pseudo-registers replaced with hardware registers or arbitrary stack
  locations

### LTLin

- CFG linearized with explicit labels and branches

### Linear

- Spills and reloads are inserted around instructions that reference
  stack-allocated pseudo-registers
- Calling conventions: moves inserted around function calls, prologues,
  and epilogues
- Offsets assigned to arbitrary stack locations and callee-save
  registers

### Mach

- Semantically-close to PowerPC assembly
- Instruction scheduling is performed
- Mach instructions expand to canned sequences of PowerPC instructions

### PPC

- Accurately models a large subset of PowerPC assembly, while omitting
  instructions and registers that CompCert does not generate

## Register allocation

The register allocation algorithm analyzes the live and dead registers
at program points. This is an intrinsic property of static
single-assignment form though, which they are not using.

Registers are colored (either as a hardware register or stack slot)
where two nodes connected by an interference edge are
differently-colored.

Unfortunately the register allocation is not directly-proven, but rather
implemented in Coq with the results validated before compilation
continues.

Correctness criteria:
1. color(r) != color(r') if r and r' interfere
2. color(r) != l if r and l interfere
3. color(r) and r have the same register class (`int` or `float`)

This is proven by requiring that the register state of the original
program is equal to the location state of the transformed program, for
all pseudo-registers live at a point.

## Further work

Ongoing work:

- Verify CIL-based parser, assembler, and linker
- Handle a larger subset of C, including `goto`
- Deploy and prove more optimizations
- Target other processors beyond PowerPC
- Extend semantic preservation proofs to shared-memory concurrency

They are looking into the feasibility of writing a compiler from Mini-ML
(the language Coq extracts to) to Cminor. Once all remaining unverified
steps are verified, including the Coq extractor, then this would result
in a trusted execution path for programs written in Coq.

## Definitions

Looked up externally:

- **Caller-saved registers** - registers that may be clobbered by the
  callee and must be saved and restored by the caller, if the value is
  needed after the call.
- **Callee-saved registers** - registers that are guaranteed to not be
  clobbered by the callee and must be saved and restored by the callee,
  if the register is needed.
- **a posteriori** - derived by reasoning from observed facts, inductive
  (from Latin: in- + dūcō (same root as German Zug!), pull inside)
- **a priori** - derived by reasoning from self-evident propositions,
  deductive (from Latin: dē- + dūcō, pull from)
