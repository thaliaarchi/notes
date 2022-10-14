# IR Comparison

## Integer types

| IR          | Bit widths | Signedness |
| ----------- | ---------- | ---------- |
| LLVM        | 1..=2^23   | signless   |
| WebAssembly | 32, 64     | signless   |

### LLVM

inttype ::= iN for N in 1..=2^23

(Clusivity clarified in source)

- https://llvm.org/docs/LangRef.html#integer-type
- https://github.com/llvm/llvm-project/blob/aaecabe68b6add7874d481e67cd430cb6f06cb82/llvm/lib/IR/Type.cpp#L312-L313
- https://github.com/llvm/llvm-project/blob/aaecabe68b6add7874d481e67cd430cb6f06cb82/llvm/include/llvm/IR/DerivedTypes.h#L51-L56

### WebAssembly

inttype ::= i32 | i64

https://webassembly.github.io/spec/core/syntax/types.html#number-types

## Floating-point types

| IR          | IEEE 754<br>binary16 | IEEE 754<br>binary32 | IEEE 754<br>binary64 | IEEE 754<br>binary128 | IEEE 754<br>decimal32 | IEEE 754<br>decimal64 | IEEE 754<br>decimal128 | Other                             |
| ----------- | -------------------- | -------------------- | -------------------- | --------------------- | --------------------- | --------------------- | ---------------------- | --------------------------------- |
| LLVM        | `half` (2008)        | `float` (2008)       | `double` (2008)      | `fp128` (2008)        |                       |                       |                        | `bfloat`, `x86_fp80`, `ppc_fp128` |
| WebAssembly |                      | `f32` (2019)         | `f64` (2019)         |                       |                       |                       |                        |                                   |

### LLVM

Conforms to IEEE 754-2008

https://llvm.org/docs/LangRef.html#floating-point-types

### WebAssembly

Conforms to IEEE 754-2019 (https://ieeexplore.ieee.org/document/8766229)

https://webassembly.github.io/spec/core/syntax/types.html#number-types

## Switch

| IR          | Kind          |
| ----------- | ------------- |
| LLVM        | branch table  |
| WebAssembly | nested blocks |

### LLVM

```
switch <inttype> <value>, label <defaultdest> [ <inttype> <val>, label <dest> ... ]
```

Parameters:
- integer comparison value `value`
- default label destination
- array of pairs of comparison value constants (no duplicates) and labels

https://llvm.org/docs/LangRef.html#switch-instruction
