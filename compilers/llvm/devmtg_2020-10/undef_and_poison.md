# Undef and Poison: Present and Future

Juneyoung Lee (Seoul National University)

[Video](https://www.youtube.com/watch?v=ZMaZH3YYJqY),
[Video (raw)](https://www.youtube.com/watch?v=_APJ4PtF0sk),
[PDF Slides](https://llvm.org/devmtg/2020-09/slides/Lee-UndefPoison.pdf),
[PPT Slides](https://llvm.org/devmtg/2020-09/slides/Lee-UndefPoison.pptx)

## Description

Recently, there has been several updates in LLVM to make optimizations
correct with respect to the undef and poison values. This involves
updating the semantics of several instructions in LLVM Language
Reference, such as branch and shufflevector, and fixing optimizations
that are incorrect when the undef or poison value is involved. The
optimizations are fixed by either disallowing the transformation in an
unsafe condition or introducing freeze to exclude undefined inputs. Both
solutions can affect performance of the generated code, so a careful
study is needed to minimize the impact.

In this talk, the recent changes about undef and poison in LLVM as well
as the remaining issues are described in detail. First, the updates in
Language Reference about undef and poison value are revisited. Second, a
few important optimizations that are still incorrect or have been
incorrect but fixed are introduced, and their solutions are explained.
Third, recent efforts in making existing optimizations and analyses
understand freeze are described, and the remaining issues are depicted.
Finally, the experimental result of a prototype that fixes known
incorrect optimizations is shown.

## Undefined behavior (3:30)

```c
int x;
if (cond) x = 3;
f(x);
```

can optimize to

```asm
movl $3, %edi
call f
```

because `x` holds an indeterminate value when `cond` is `false` which is
UB and allows the compiler to assume `cond` is always `true`.

## Undef != indeterminate value (5:30)

```c
struct {
  int x: 2, y: 6;
} a;
a.x = 1;
```

Treating `a` as an indeterminate value is incorrect:

```
a = alloca
b = load a         ; indeterminate value
v = (b & ~3) | 1
store v, a
```

Instead, modelling it as `undef` allows elements of the bitfield to be
defined:

```
a = alloca
b = load a   ; ********  undef = {0, 1, ..., 255}
v = b & ~3   ; ******00  undef = {0, 4, ..., 252}
v2 = v | 1   ; ******01  undef = {1, 5, ..., 253}
store v, a
```

## Definition of undef (6:30)

- `undef` of type T is the set consisting of all defined values of T.
- a (partially) undefined value is a subset of `undef`.
- an operation on undefined values is defined in element-wise manner.

## Motivation for poison (8:00)

```c
int32_t i = 0;
while (i <= y) { // always true for y = INT32_MAX
  arr[i] = ...;
  i = i +nsw 1; // when i = INT32_MAX, it is UB, so + is poisoned
}
```

Signed overflow is not allowed in C, so the `nsw` flag is used on `+`.

Poison propagates from `+nsw` to `i` to `i <= y`. Poison can be refined
by any value, so it is now allowed to refine `i <= y` to false and
enables widening `i` to 64 bits.

```c
int64_t i = 0;
while (i <= y) { // can be false for y = INT32_MAX
  arr[i] = ...;
  i = i +nsw 1;
}
```

## Definition of poison (10:20)

- `poison` is a special value that represents a violation of an assumption
- Each operation either propagates `poison` or raises UB
- (Property) `poison` is refined by any (defined or undefined) value

## Fixing DivRemPairs using freeze (20:30)

```c
a = x / y
b = x % y
```

can optimize to (when values are defined)

```c
a = x / y
b = x - (a * y)
```

However, this is not correct when `x` is `undef`, so `x` must be frozen.

## How to write safe optimizations (31:10)

1. Keep in mind that input values can be `undef` or `poison`
2. Be aware that two uses of the same variable may yield different
   values
3. Be careful not to introduce new `undef` or `poison` values

## Summary (34:10)

1. LLVM has `undef` and `poison` values
2. Miscompilations can be fixed with freeze by removing corner cases
3. Cost of using freeze has been reduced over time
4. Suggest removing `undef` and using `poison` only
