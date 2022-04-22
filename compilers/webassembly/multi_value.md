# Multi-Value All the Wasm!

https://hacks.mozilla.org/2019/11/multi-value-all-the-wasm/

Multi-value proposal merged into WebAssembly spec
[on 2020-04-09](https://github.com/WebAssembly/spec/pull/1145).

Before multi-value:
- Functions could only return zero or one value
- Instruction sequences like `block`, `if`, and `loop` couldn't consume
  any stack values and could only produce zero or one stack value

After multi-value:
- Functions can return an arbitrary number of values
- Instruction sequences can consume and produce an arbitrary number of
  stack values

```wasm
;; A function that takes an `i64` and returns three `i32`s.
(func (param i64) (result i32 i32 i32)
  ...)

;; A loop that consumes an `i32` stack value at the start of each
;; iteration.
loop (param i32)
  ...
end

;; A block that produces two `i32` stack values.
block (result i32 i32)
  ...
end
```

Possible new instructions
- `i32.divmod` of type `[i32 i32] -> [i32 i32]`
- Arithmetic ops with carry result

Multi-value validation is similar to the
[validation algorithm](https://webassembly.github.io/spec/core/appendix/algorithm.html)
in the Wasm spec and abstractly abstractly interprets with a stack of
types, instead of values.

## Blocks with formal parameters

Cranelift IR doesn't use SSA form, but rather blocks with formal
parameters.

```rust
let x;
if some_condition() {
    x = foo(); // x0
} else {
    x = bar(); // x1
}
do_stuff(x); // Φ(x0, x1)
```

```cranelift-ir
;; Head of the `if`/`else`.
ebb0:
    v0 = call some_condition()
    brnz v0, ebb1
    jump ebb2

;; Consequent.
ebb1:
    v1 = call foo()
    jump ebb3(v1)

;; Alternative.
ebb2:
    v2 = call bar()
    jump ebb3(v2)

;; Code following the `if`/`else`.
ebb3(v3: i32):
    call do_stuff(v3)
```

I like this much better than the equivalent SSA form with phi nodes. For
the callee to construct the phi input list, it would examine the
predecessors' terminator arguments. This simplifies the structure: the
callee doesn't maintain a phi input list in correspondence to the
predecessor list. This sounds like the same approach as blocks in MLIR,
but I understand the implications better this time around.

I think this would require any locals to be passed as block parameters,
which could bloat parameter lists. However, Wasm validation performs a
type weakening for the composition of instructions, which extends
instruction types to include untouched stack values that are needed by
later instructions, so I don't think this would be a problem (see §4.1
“Typing Rules - Instructions” of *Bringing the Web up to Speed with
WebAssembly*).

The syntax for parameter lists is nice. I may need to steal it. Is this
formal syntax though or an ad hoc example?

I think a loop would translate as so:

```c
int64_t sum = 0;
for (int64_t i = 0; i < 10; i++) {
  sum += i;
}
print(sum);
```

to SSA with phi functions:

```phi-pseudo-ir
entry:
    sum = 0
    i = 0
    jump loop
loop:
    sum1 = phi [sum0 entry, sum2 loop]
    i1 = phi [i0 entry, i2 loop]
    cond = cmplt i1, 10
    brnz cond, break
    sum2 = add sum1, i1
    i2 = add i1, 1
    jump loop
break:
    sum3 = phi [sum1 loop]
    call print(sum3)
```

or with IVs as block parameters:

```param-pseudo-ir
    jump loop(0, 0)
loop(sum: int64, i: int64):
    cond = cmplt i, 10
    brnz cond, break(sum)
    sum1 = add sum, i
    i1 = add i, 1
    jump loop(sum1, i1)
break(sum: int64):
    call print(sum)
```

This is clean :)
