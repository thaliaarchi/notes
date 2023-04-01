# Expressing higher-level control-flow constructs in Whitespace

## Lambdas and function pointers

Lambdas and function pointers are represented the same in generated Whitespace,
as statically-determined numbers. Since labels cannot be addressed, each label
is instead identified by a unique value, which used as the address. This value
is arbitrary and determined by the compiler.

In the case, that the source language is dynamically typed and the types cannot
be statically determined, it would be unclear whether a number would represent a
lambda address or another type, so all values would need to be tagged.

Since lambdas are syntactically defined, they can simply be treated as any other
function. However, if compiling from a language that somehow allows for dynamic
lambda construction, at worst, an interpreter may need to be embedded in the
generated program.

## Indirect jump

The `indirectjmp` IR instruction is an indirect branch to a label within a fixed
set of labels, each with an associated address.

`indirectjmp <addr>, [<addr1> <label1>, <addr2> <label2>, …, <addrn> <labeln>]`

At the site of an indirect jump, the compiler produces a jump table over the set
of targets. The table could be structured as a binary search of branches, to
select the given branch, or with profiling data, a weighted search.

## Indirect call

The `indirectcall` IR instruction is an indirect call of a label within a fixed
set of labels, each with an associated address.

`indirectcall <addr>, [<addr1> <label1>, <addr2> <label2>, …, <addrn> <labeln>]`

An indirect call is essentially an indirect jump, except each target is invoked
with a `call`, instead of a `jmp`, and is followed by a `jmp` to after the jump
table.

The lowered control flow can be optimized as usual: When the `call` never has a
corresponding `ret`, it can be replaced with a `jmp` and the following `jmp`
removed as dead code. When the callee has that caller as its only predecessor,
the `call` and `ret` can be both replaced with `jmp`.

## Calling conventions

The simplest calling convention is to specify certain number of stack values to
be consumed and returned. Since both amounts may be dynamic, this may be a loose
definition.

Another calling convention is to specify certain addresses that arguments are to
be placed in.

At the callsite of such a function, the caller must ensure the arguments are
properly arranged.

## Closures

A closure is a value containing an environment and a lambda, and is stored on
the heap. Captured values are referenced by an offset from the base pointer.

When the calling conventions of the potential targets of the lambda match, then
the captured environment can be stored adjacent to the address. Otherwise, it
may need to be referenced by a pointer and dynamically sized.

## Partial application

Closures can be partially applied and produce another closure.
