# Lowering Whitespace with strictness

Lowering instructions to statements:

- `push n` -> abstracted
- `dup` -> abstracted
- `copy n` -> abstracted or `stack_ref_lazy`
- `swap` -> abstracted
- `drop` -> abstracted
- `slide n` -> abstracted
- `add` -> `add_lazy`
- `sub` -> `sub_lazy`
- `mul` -> `mul_lazy`
- `div` -> `div_lazy`
- `mod` -> `mod_lazy`
- `store` -> `eval` and `store`
- `retrieve` -> `eval_lazy` and `retrieve`
- `label` -> nop
- `call` -> `call`
- `jmp` -> `jmp`
- `jz` -> `eval` and `br zero`
- `jn` -> `eval` and `br neg`
- `ret` -> `guard calls` and `ret`
- `end` -> `exit`
- `printc` -> `eval` and `print char`
- `printi` -> `eval` and `print int`
- `readc` -> `eval` and `read char`
- `readi` -> `eval` and `read int`

## Strictness analysis

For each basic block, iterate the instructions from the start and rewrite each
`eval` and `eval_lazy`. For evaluation of a lazy arithmetic operation
(`add_lazy`, `sub_lazy`, `mul_lazy`, `div_lazy`), move the operation and its
dependents to to the place of `eval`. If moving it would cause ordering
issues (e.g., when used as the value of an ordered store), then instead, place
an `eval_lazy` after the op. For evaluation of `stack_ref_lazy`, replace it with
a `guard underflow` and `stack_ref`.

This needs further thoughts. In particular, the mechanism for eager expression
evaluation with lazy exception handling needs refinement. It should probably be
a sea-of-nodes IR to more easily express this partial order.
