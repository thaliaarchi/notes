# LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation

Chris Lattner and Vikram Adve

Proc. of the 2004 International Symposium on Code Generation and Optimization
(CGO'04), Palo Alto, California, Mar. 2004.

https://www.llvm.org/pubs/2004-01-30-CGO-LLVM.html

## Abstract

Supports transparent, lifelong program analysis and transformation by providing
high-level information to compiler transformations at every stage.

IR:
- Low-level
- In SSA form
- Novel features:
  - Language-independent type system that exposes high-level language primitives
  - Mechanism to efficiently implement high-level exception handling

Paper overview
1. Size and effectiveness of IR, including type information
2. Compiler performance for interprocedural problems
3. Benefits of LLVM for challenging compiler problems

## §1 Introduction

Lifelong code analysis and transformation
- Phases
  - Link-time interprocedural optimization
    - Static debugging
    - Static leak detection
    - Memory management transformations
  - Install-time machine-dependent optimizations
  - Run-time dynamic optimization
  - Idle-time (between runs) profile-guided optimization
    - Not yet implemented in LLVM (footnote 1)
- Benefits
  - Processor and interfaces can evolve more flexibly
  - Legacy applications can run well on new systems

LLVM IR
- RISC-like
- High-level information
  - Type information
  - Explicit control-flow graphs
  - Explicit data-flow representation (via SSA form)
- Source-language independent
  - Instruction set and memory model only slightly richer than assembly
  - Types do not prevent representing untyped code
  - Does not represent machine-dependent features (must be lowered)
  - Does not guarantee type safety, memory safety, or language interoperability
    more than assembly
  - Complements, not replaces, high-level VMs (e.g., Smalltalk, Self, JVM,
    Microsoft's CLI)
    - No high-level constructs such as classes or inheritance
    - A runtime could be implemented in LLVM

Effectiveness criteria:
- Size and effectiveness of IR
  - Ability to extract useful type information for C programs
    - Extracts reliable type info for 68% of static memory access instructions
  - Size comparable to x86 machine code (CISC) and 25% smaller on average than
    RISC, despite richer type information
- Compiler performance (not of generated code)
- Capabilities for challenging compiler problems

## §2 Program representation

### §2.1 Instruction set

- Avoids machine-specific constraints such as
  - Pipelines
  - Low-level calling conventions (is this still true?)
- Infinite virtual registers
  - Not physical hardware registers
  - Hold primitive types: boolean, integer, floating point, pointer
  - Cannot have aliases, which simplifies non-memory transformations
- Load/store memory model (for transferring values between registers and memory)
- Opcodes
  - 31 RISC-like opcodes (now 65)
  - Unary operators `not` and `neg` are implemented in terms of `xor` and `sub`,
    respectively (`fneg` has since been added)
  - Most opcodes are overloaded (integer and floating-point ops have since been
    split, e.g., `add` and `fadd`)
- SSA form
  - Each virtual register is written by exactly one instruction
  - Each register use is dominated by its definition
  - Memory locations are not in SSA form
  - Phi instruction
    - Corresponds directly to the standard (non-gated) φ function
  - Explicit data-flow representation via a compact def-use graph
    - Simplifies many data-flow optimizations
    - Enables fast, flow-insensitive algorithms to achieve many of the benefits
      of flow-sensitive algorithms, without expensive dataflow analysis
  - Simplifies non-loop transformations because registers do not have anti- or
    output dependencies
- Explicit control-flow graph
  - A function is a set of basic blocks
  - A basic block is a sequence of instructions, ending in exactly one
    terminator instruction (branches, return, `unwind`, or `invoke`) that
    specifies its successor basic blocks
  - Models exception-handling

### §2.2 Language-independent type information

- Every SSA register and memory object is typed
  - Primitives fixed-size types:
    - Then: void, bool, 8- to 64-bit signed/unsigned integers (e.g., `int`,
      `long`, `ubyte`, etc.), single- and double-precision floating point
    - Now:
      - Void
      - Integer: `iN`, where n is in 1..=2**23
      - Floating point: `half`, `bfloat`, `float`, `double`, `fp128`,
        `x86_fp80`, `ppc_fp128`
  - Derived types:
    - Then: pointers, arrays, structures, functions
- Enables high-level transformations on low-level code
  - Safely enables aggressive optimizations that would traditionally be
    performed by source-level compilers for type-safe languages
  - Using pointers, structures, functions, and primitives:
    - Field-sensitive points-to analyses
    - Call graph construction (including for object-oriented languages like C++)
    - Scalar promotion of aggregates
    - Structure field reordering
  - Also using arrays:
    - Array-dependence analysis
    - Loop transformations
- Type mismatches are useful for detecting optimizer bugs
- Declared types may not be reliable, so a pointer analysis must be used to
  distinguish memory accesses with reliably-known pointer target types and those
  without (see §4.1.1)
- Type conversions
  - Values can be arbitrarily cast to other types with explicit instructions
  - A program without casts is type-safe, in the absence of memory access errors
  - Then: `cast`
  - Now:
    - `trunc`
    - `zext`, `sext`
    - `fptrunc`
    - `fpext`
    - `fptoui`, `fptosi`
    - `uitofp`, `sitofp`
    - `ptrtoint`
    - `inttoptr`
    - `bitcast`
    - `addrspacecast`
- `getelementptr` address arithmetic
  - Preserves types
  - Machine-independent semantics
  - Calculates the address of a sub-element in an aggregate type
  - Effectively a combined `.` and `[]` operator
  - For example, `x[i].a = 1;` could be translated into:
    ```llvmir
    %p = getelementptr %xty* %x, %long %i, ubyte 3;
    store int 1, int* %p;
    ```

### §2.3 Explicit memory allocation and unified memory model

- Instructions
  - `malloc` allocates memory on heap
  - `free` releases `malloc`-allocated memory
  - `alloca` allocates memory on function's stack frame, which is automatically
    deallocated on return
- Typed
- All addressable values (lvalues) are explicitly allocated
- All memory operations, including calls, occur through typed pointers
- No address-of operator needed

### §2.4 Function calls and exception handling

- `call` takes a typed function pointer and typed arguments
  - Abstracts away machine calling conventions
  - Simplifies program analysis

- Exception handling
  - Abstract exception-handling model based on stack unwinding (though codegen
    can lower it to zero-cost, table-driven methods or `setjmp`/`longjmp`)
  - Supports coexisting exception models
    - C `setjmp`/`longjmp`
      - `setjmp` saves the current execution context and `longjmp` resumes it at
        an arbitrary point in the future
    - C++ exception model
  - Then:
    - `invoke` works like a `call`, but specifies an extra basic block that
      indicates the starting block for an unwind handler. When the program
      executes an `unwind` instruction, it logically unwinds the stack until it
      removes an activation record created by an `invoke`. It then transfers
      control to the basic block specified by the `invoke`.
  - Now:
    - `invoke` transfers control to a specified function. If the callee returns
      with `ret`, then control returns to the given “normal” label. If the
      callee (or any indirect callees) returns with `resume` or another
      exception-handling mechanism (which?) control is interrupted and continues
      at the dynamically-nearest “exception” label. The exception label has a
      `landingpad` instruction, which contains program information for after
      unwinding and prevents it from being lost through code motion.
      - https://llvm.org/docs/LangRef.html#invoke-instruction
      - https://llvm.org/docs/ExceptionHandling.html#overview
    - `unwind` removed in 3.0:
      https://releases.llvm.org/3.0/docs/ReleaseNotes.html#api_changes
  - Exposes exceptional control flow in the CFG
  - Destructors are implemented with `invoke` to ensure they're executed on
    exception

### §2.5 Representations

- Equivalent textual, binary, and in-memory representations with no semantic
  conversions

## §3 Compiler architecture

### §3.1 High-level design

LLVM capabilities (§1)
- LLVM inherently supports all of these:
  1. Persistent program information
  2. Offline code generation
  3. User-based profiling and optimization
     - Gathered in the field by actual users
  4. Transparent runtime model
     - No specific object model, exception semantics, or runtime environment
     - Allows any language or combination
  5. Uniform, whole-program compilation
- Previous systems:
  - Source-level compilers: #2 and #4
  - Link-time interprocedural optimizers: #1 and #5, but only up to link-time
  - Profile-guided optimizers for static languages: #2
  - High-level VMs (JVM, CLI): #3 and partially #1 and #5
  - Binary runtime optimization systems: #2, #4, and #5, but only at runtime

### §3.2 Compile-time

- Front-ends are static compilers that translate source-language programs into
  LLVM IR
  - Perform:
    1. Language-specific optimizations (optional)
    2. Translate source programs to LLVM IR
    3. Invoke LLVM optimization passes via library (optional)
       - Optimizations can be shared, such as virtual function resolution for
         object-oriented languages and tail-recursion elimination
  - Do not need to construct SSA form, but rather can allocate variables on the
    stack
    - Stack-allocated scalars are converted to SSA registers if their address
      doesn't escape the current function, inserting phi functions as necessary

### §3.3 Linker and interprocedural optimizer

- Linker
  - Performs aggressive interprocedural optimizations
  - Analyses:
    - Context-sensitive points-to analysis
    - Call graph construction
    - Mod/ref analysis
  - Transformations:
    - Inlining
    - Dead global elimination
    - Dead argument elimination
    - Dead type elimination
    - Constant propagation
    - Array bounds check elimination
    - Structure field reordering
    - Automatic pool allocation

### §3.4 Offline or JIT native code generation

### §3.5 Runtime path profiling and reoptimization

### §3.6 Offline reoptimization with end-user profile information

## Changes since paper

- LLVM is no longer an initialism for “Low Level Virtual Machine” and is just
  “The LLVM Project”
  [(2011)](https://lists.llvm.org/pipermail/llvm-dev/2011-December/046445.html)
- Grown to more languages than C/C++
  - Rust
    - Aliasing bugs discovered in LLVM

## Questions

What is the difference between gated and non-gated phi functions?

Clarify terminology for:
> Non-loop transformations are simplified because they do not encounter anti- or
> output dependencies on registers

## Expand upon

Infinite virtual registers vs x86 registers (get list).

There are now separate insts for int/float ops. Pull up RFCs to see why that was
changed.

I need to separately cover SSA form because it seems to be assumed.

Update GEP example syntax.
