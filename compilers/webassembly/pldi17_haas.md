# Bringing the Web up to Speed with WebAssembly

Andreas Haas, Andreas Rossberg, Derek L. Schuff, Ben L. Titzer (Google);
Michael Holman (Microsoft); Dan Gohman, Luke Wagner, Alon Zakai
(Mozilla); JF Bastien (Apple)

Proc. of the 38th Conference on Programming Language Design and
Implementation (PLDI), Barcelona, Spain, Jun. 2017.

[[paper](https://dl.acm.org/doi/10.1145/3062341.3062363)],
[[PDF](https://dl.acm.org/doi/pdf/10.1145/3062341.3062363)],
[[video](https://www.youtube.com/watch?v=AFy5TdrFG9Y)]

## Semantics

To their knowledge, Wasm is the first industrial-strength language or VM
designed with a formal semantics from the start.

### §2.1 Basics

- Functions are not first class and cannot be nested
- Call stack is not exposed
- Operand stack never materialized; just used as it's smaller than a
  register machine
- Wasm traps cannot be handled in Wasm, but by JS
- Integer signedness distinguished by operators, not types
- Locals are zero-initialized and read/written by index; `tee_local`
  writes to a local while keeping the input on the stack (like
  `set_local` preceded by `dup`)
- Globals are constexpr-initialized and mutable or immutable
- Function parameters are mutable on the stack

### §2.2 Linear memory

- Each module may define at most one memory, which may be grown
- Fixed page size, not architecture-specific
- `load`/`store` access by 32-bit address; may be unaligned, albeit
  slower
- Little endian
- Linear memory disjoint from code, stack, and engine

### §2.3 Structured control flow

- Structured control flow
  - Cannot form irreducible loops, branch to blocks with misaligned
    stack heights, or branch into the middle of a multi-byte instruction
  - JavaScript is also restricted to structured control flow
  - The relooper algorithm (A. Zakai. Emscripten: An LLVM-to-JavaScript
    compiler. OOPSLA 2011.) transforms unstructured and irreducible
    control flow into structured form
- `block`, `loop`, and `if`/`else` terminated with `end` and inner
  instructions are a block
- `if` pops operand; `else` may be omitted
- `loop` does not automatically iterate its block and needs explicit
  branches
- Branches break from the block and jump forward, if `block` or `if`,
  and backward, if `loop`, to a nesting depth
- `br_if` conditional jump
- `br_table` selects target from label/index list, with last label for
  out-of-bounds index case
- Blocks are annotated with the stack effect, which must be compatible
  at branches (the beginning and end of blocks; control join points)
- Branching unwinds the operand stack by all respective stacks (for each
  nested block)

For example, a `switch` with fallthrough:

```c
switch (x) {
case 0: ...A...
case 1: ...B... break;
default: ...C...
}
```

is translated to:

```wasm
block block block block
  br_table 0 1 2
  end ...A...
  end ...B... br 1
  end ...C...
end
```

### §2.4 Function calls and tables

- Function body is a block whose signature maps the empty stack to the
  function's result
- Arguments are the first local variables
- Function execution completes
  - when the end of the block is reached, (the operand stack must match
    the function's result types)
  - by a branch targeting the function block with the result values as
    operands. `return` is a shorthand for this
- `call` pops function args and pushes result upon return
- `call_indirect` executes the dynamically-indexed function in a table
  of functions, whose signatures needn't necessarily match
  - Signature checked at dynamically and traps on type mismatch or
    out-of-bounds table access
  - Exported tables can be grown and mutated dynamically via external
    APIs (useful for dynamic linking)
- FFI with host language is possible via importing/exporting functions
  by name and signature

### §2.5 Determinism

- Instructions only output canonical NaNs with non-deterministic sign
  bit unless the input is a non-canonical NaN
- `grow_memory` returns -1 on engine out-of-memory failure
- `call` and `call_indirect` may have stack overflow, but that's not
  semantically-observable from within Wasm
- Host functions may be non-deterministic or change Wasm state
- Wasm has no threads and thus no concurrent non-determinism

### §2.6 Omissions and restrictions

These restrictions have since been lifted (see “Multi-Value All the
Wasm!”):
- Blocks and functions may produce at most one value
- Blocks may not consume outer operands (the outer operands would just
  be passed as multi-value parameters to the block)

## §4.1 Validation - typing rules

- Labels are indexed relatively from the end of the list, which is a
  form of de Bruijn indexing (N. G. de Bruijn. Lambda calculus notation
  with nameless dummies: a tool for automatic formal manipulation with
  application to the Church-Rosser theorem).
- Instruction types are weakened to allow composition, e.g., when typing
  the sequence `(i32.const 1) (i32.const 2) i32.add`, the type of the
  middle instruction is weakened from `ε -> i32` to `i32 -> i32 i32` to
  compose with the other two.
- No requirements are enforced on the stack after a unconditional
  branches (`unreachable`, `br`, `br_table`, `return`), so expressions
  such as `a + b` can be simply compositionally compiled as
  `compile(a) compile(b) i32.add`, without worrying about whether `a` or
  `b` contain branches or traps.
- Modules are closed definitions, with no needed context for validation.
- Globals may only refer to preceding globals in initializer.

## §5 Binary format

- Function signatures appear before bodies so that the bodies, which are
  preceded by the byte size, can be decoded and compiled in parallel
- Numbers are encoded in LEB128 format

## §6 Interoperability

Wasm is an abstraction over hardware, not over a programming language,
so it doesn't provide a built-in object model. Producers map their data
types to numbers or the memory and can define an ABI so that modules can
interoperate in heterogeneous applications.

## §7 Implementation

V8 (Chrome), SpiderMonkey (Firefox), and JavaScriptCode (WebKit) compile
modules AOT before instantiation. Chakra (Edge) interprets modules on
first execution and later JIT compiles the hottest functions.

The SpiderMonkey fast baseline JIT emits machine code and validates in a
single pass with greedy register allocation. The IonMonkey optimizing
JIT compiles it in parallel. V8 and SpiderMonkey achieve 5-6x
compilation speed improvement with 8 compilation threads.

- Chrome: One-tier AOT compilation
- Firefox: Two-tier AOT and JIT compilation
- WebKit: Two-tier JIT compilation
- Edge: Two-tier interpretation and JIT compilation

Wasm can be decoded to SSA form in a single linear pass. This is done by
V8 and SpiderMonkey. V8's TurboFan compiler uses a sea of nodes
graph-based IR (like Graal!).

Reference interpreter is written in OCaml.

### §7.1 Bounds checks

The memory size changes so infrequently that the JIT can constant fold
it and embed it into the machine code, then patch it later if it
changes. Deoptimization of the code is not necessary for that.

### §7.2 Caching

JavaScript API can store compiled Wasm modules as blob in IndexedDB to
later query for cached module. This seems like it should be a built-in,
automatic capability in the browser, including expanding this to include
the compiled machine code for JavaScript files, since I think that most
sites would benefit from this caching. I think this could only be
reliably-implemented for resources that include a cache key, such as the
`ETag` HTTP header.

### §7.3 Measurements

- Execution between 10% of native and 2x of native
- Executes 33.7% faster than asm.js and validation takes 3% of the
  asm.js validation time
- Code size 62.5% of asm.js
- Code size 85.3% of native x86-64

## §8 Related work

Other memory safety models:
- Safety at C language level, which requires program changes (CCured and
  Cyclone)
- Safety at C abstract machine level with static and runtime checks
  (Secure Virtual Hardware)
- Typed ILs, which give higher confidence in compiler correctness and
  more type-based opts, but types need to be preserved throughout
  compilation (TIL and FLINT)

Wasm, on the other hand, enforces memory safety with simple bounds
checks or virtual memory techniques.

Wasm bytecode speed and simplicity of validation informed by JVM and CIL
stack machine experience. The description of Wasm verification takes one
page of spec, but 150 pages for the JVM.

JVM has a potentially O(n^3) worst-case for the iterative dataflow
approach that is a consequence of unrestricted `goto`s and other
idiosyncrasies that had to be fixed by adding stack maps.

JVM, CIL, and Android Dalvik allow irreducible loops and unbalanced
locking structures in bytecode and just relegate those constructs to an
interpreter.

## §9 Future directions

- For low-level code: zero-cost exceptions, threads, SIMD instructions
- For high-level code: tail calls, stack switching, coroutines, garbage
  collectors
- Non-web usage
