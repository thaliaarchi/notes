# Tail-call optimization

Optimizing tail recursion is trivial, because the stack is reused, but general
TCO requires additional cleanup or resizing.

In assembly, TCO can be [implemented](https://en.wikipedia.org/wiki/Tail_call#In_assembly)
by replacing a `call` followed by a `ret` with a `jmp`. There may be call frame
setup between the two instructions, which would need to be adjusted.

## Implementations

### LLVM

LLVM has the [`-tailcallelim`](https://www.llvm.org/docs/Passes.html#tailcallelim-tail-call-elimination)
pass and optimizes [tail calls](https://llvm.org/docs/CodeGenerator.html#tail-call-optimization)
and [sibling calls](https://llvm.org/docs/CodeGenerator.html#sibling-call-optimization).

It extends the basic algorithm to move trivial instructions from between the
call and return and rewrites associative expressions to use an accumulator (as
in naïve factorial or Fibonacci). It also performs it on functions that return
void, the callee's result, or a run-time constant on all exits, or if it can
prove that callees don't access the caller stack frame. TCO is only performed
for the `fastcc`, GHC, HiPE, [`tailcc`](https://reviews.llvm.org/D67855), and
`swifttailcc` [calling conventions](https://llvm.org/docs/LangRef.html#calling-conventions).

#### MLIR

The [Func dialect](https://mlir.llvm.org/docs/Dialects/Func/) has `func.call`,
`func.call_indirect`, and `func.return`, and the [LLVM dialect](https://mlir.llvm.org/docs/Dialects/LLVM/)
has `llvm.call` and `llvm.return`, but their docs make no mention of tail calls.
Presumably, MLIR leans on LLVM's TCO.

### WebAssembly

WebAssembly has the regular [call instructions](https://webassembly.github.io/function-references/core/syntax/instructions.html#control-instructions),
`call`, `call_indirect`, and `call_ref` as well as their [proposed](https://github.com/WebAssembly/tail-call/blob/main/proposals/tail-call/Overview.md)
tail-call counterparts, `return_call`, `return_call_indirect`, and
`return_call_ref`, which unwind the frame before performing the call. The callee
does not necessarily need to be the same as the caller and can have a different
type, so is more general than tail self-recursive calls.

#### V8

V8 has [implemented](https://v8.dev/blog/wasm-tail-call) this proposal.

Turbofan (V8's optimizing compiler) handles the stack and register manipulations
for reusing the stack space by generating a list of moves that are semantically
executed in parallel. The “gap resolver” then orders moves such that all sources
are read before being overwritten, using temporary registers or stack slots to
break cycles.

Liftoff (V8's baseline compiler) does not optimize tail calls. It instead
updates the stack frame as for a regular call, then shifts it downwards to
discard the caller frame.

#### Wasmtime

Wasmtime details their implementation in an [RFC](https://github.com/bytecodealliance/rfcs/blob/main/accepted/tail-calls.md).

### Rust

In [RFC 3407](https://github.com/rust-lang/rfcs/pull/3407), it is proposed that
Rust use the already-reserved `become` keyword to denote a tail call. It is used
opt-in, in place of a return, and its argument must be a call. Tail calls to and
from closures will not be supported, due to the high implementation effort.

### Zig

Zig uses separate [`@call`](https://ziglang.org/documentation/master/#call)
syntax to specify modifiers, such as to control tail calls or inlining.

### JVM

The JVM [eliminates](https://en.wikipedia.org/wiki/Tail_call#Implementation_methods)
tail-recursive calls, but not general tail calls or mutual tail recursion.

#### GraalVM

The Graal compiler has internal support for tail calls and [limited support](https://github.com/oracle/graal/issues/501)
for Truffle languages.

### Others

- [Prior art](https://github.com/phi-go/rfcs/blob/guaranteed-tco/text/0000-explicit-tail-calls.md#prior-art)
  in Rust explicit tail calls RFC
- List of [languages supporting](https://en.wikipedia.org/wiki/Tail_call#Language_support)
  tail calls on Wikipedia
