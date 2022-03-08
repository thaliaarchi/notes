# LangRef

https://llvm.org/docs/LangRef.html

## Type system

- Void
- Function
- First-class types
  - Single-value types
    - Integer: `iN`, where n is in 1..=2**23
    - Floating point: `half`, `bfloat`, `float`, `double`, `fp128`,
      `x86_fp80`, `ppc_fp128`
    - `x86_amx`, `x86_mmx`
    - Pointer
    - Vector
  - Label
  - Token
  - Metadata
  - Aggregate
    - Array
    - Structure
    - Opaque structure

Undef, poison

## Instruction reference

Terminator instructions
- `ret`
- `br`
- `switch`
- `indirectbr`
- `invoke`
- `callbr`
- `resume`
- `catchswitch`
- `catchret`
- `cleanupret`
- `unreachable`

Unary operations
- `fneg`

Binary operations
- `add`, `fadd`
- `sub`, `fsub`
- `mul`, `fmul`
- `udiv`, `sdiv`, `fdiv`
- `urem`, `srem`, `frem`

Bitwise binary operations
- `shl`
- `lshr`, `ashr`
- `and`
- `or`
- `xor`

Vector operations
- `extractelement`
- `insertelement`
- `shufflevector`

Aggregate operations
- `extractvalue`
- `insertvalue`

Memory-access and -addressing operations
- `alloca`
- `load`
- `store`
- `fence`
- `cmpxchg`
- `atomicrmw`
- `getelementptr`

Conversion operations
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

Other operations
- `icmp`
- `fcmp`
- `phi`
- `select`
- `freeze`
- `call`
- `va_arg`
- `landingpad`
- `catchpad`
- `cleanuppad`

## Intrinsic functions

- Variable argument handling
- Accurate garbage collection
- Code generator
- Standard C/C++ library
- Bit manipulation
- Arithmetic with overflow
- Saturation arithmetic
- Fixed-point arithmetic
- Specialized arithmetic
- Hardware-loop
- Vector reduction
- Matrix
- Half-precision floating point
- Saturating floating point to integer conversions
- Debugger
- Exception handling
- Pointer authentication
- Trampoline
- Vector predication
- Masked vector load and store
- Masked vector gather and scatter
- Masked vector expanding load and compressing store
- Memory use markers
- Constrained floating point
- Constrained libm equivalents
- Floating-point environment manipulation
- General
- Stack map
- Element wise atomic memory
- Objective-C ARC runtime
- Preserving debug information

## Extended SSA

What is “Extended SSA”?

> **`llvm.ssa.copy` Intrinsic**
>
> ```llvmir
> declare type @llvm.ssa.copy(type %operand) returned(1) readnone
> ```
>
> The first argument is an operand which is used as the returned value.
>
> The `llvm.ssa.copy` intrinsic can be used to attach information to
> operations by copying them and giving them new names. For example, the
> PredicateInfo utility uses it to build Extended SSA form, and attach
> various forms of information to operands that dominate specific uses.
> It is not meant for general use, only for building temporary renaming
> forms that require value splits at certain points.

https://llvm.org/docs/LangRef.html#id3353
