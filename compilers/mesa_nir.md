# NIR

https://www.jlekstrand.net/jason/blog/2022/01/in-defense-of-nir/

## Structured control-flow

## Algebraic optimizations

https://www.jlekstrand.net/jason/projects/mesa/nir-notes/

> All of the basic data structures in NIR are typedef’d C structs

How would structs be represented in SSA form?

## Data types

- Variable
- Dereference: a dereference in a singly-linked chain of variable,
  structure, and array dereferences.
- Register: non-SSA temporary storage that can be written to multiple
  times and with write-masks.
- SSA definition: contains a pointer to the instruction defining the
  value for easy expression tree crawling.
- Source: a register
- ...

> - `nir_variable`: Represents a GLSL variable. Mostly a copy-and-paste
>   of `ir_variable`
>
> - `nir_deref`: Represents a dereference chain for a variable. The
>   `nir_deref` objects form a singly linked list starting at the
>   variable itself and working its way down the chain of structure and
>   array dereferences.
>
>   - `nir_deref_var`: A variable dereference
>
>   - `nir_deref_array`: A dereference of an array. An array dereference
>     can be one of: “direct”, “indirect”, or “wildcard”. A “wildcard”
>     dereference refers to the every element of the array at the same
>     time and is only allowed in `nir_intrinsic_copy_var` instructions.
>
>   - `nir_deref_struct`: A dereference of an element of a structure.
>     The element to be dereferenced is denoted by its index in the
>     structure.
>
> - `nir_register`: Non-SSA temporary storage. Registers can be written
>   to multiple times and with write-masks.
>
> - `nir_ssa_def`: An SSA definition. This contains a pointer to the
>   `nir_instr` that defines the value for easy crawling of expression
>   trees.
>
> - `nir_src`: A source value for an instruction. Can be a register
>   (with a potentially indirect offset) or an SSA definition.
>
>   - `nir_alu_src`: A source for an ALU instruction. ALU sources have
>     source modifiers and swizzles in addition to the regular
>     `nir_src`.
>
> - `nir_dest`: An instruction destination. Can be a register (with a
>   potentially indirect offset) or an SSA definition. In the case of an
>   SSA definition, the `nir_ssa_def` is actually embedded in the
>   `nir_dest`.
>
>   - `nir_alu_dest`: The destination of an ALU instruction. ALU
>     destinations can have the “saturate” destination modifier as well
>     as a write-mask if the destination is a register.
>
> - `nir_instr`: An instruction
>
>   - `nir_alu_instr`: An ALU operation such as `fmul`, `iadd`, or
>     `fsin`.
>
>   - `nir_call_instr`: A function call. Not currently used.
>
>   - `nir_jump_instr`: A jump instruction such as return, break, or
>     continue.
>
>   - `nir_tex_instr`: A texturing operation. This structure contains
>     all of the various bits of data required to figure out sampling,
>     types (int or float), etc.
>
>   - `nir_intrinsic_instr`: An intrinsic. This is anything that isn’t
>     really “special” but isn’t just an ALU operation. Intrinsics
>     can’t, in general, be reordered or eliminated (there are flags to
>     let you know when they can). Also, anything that has anything to
>     do with a `nir_variable` must be an intrinsic.
>
>   - `nir_load_const_instr`: An instruction that just assigns some
>     piece of constant data to its destination
>
>   - `nir_ssa_undef_instr`: An instruction for creating “fake”
>     definitions of SSA values that aren’t actually defined in the
>     code.
>
>   - `nir_phi_instr`: A phi node.
>
>   - `nir_parallel_copy_instr`: A parallel copy instruction. This
>     crucial for going out of SSA form but you should never see one of
>     these in the wild.
>
> - `nir_cf_node`: A node in the control flow graph. The CFG is
>   explicitly maintained in NIR and each node has an exec_node embedded
>   in it so that it can be placed in a list of control flow nodes.
>
>   - `nir_block`: A basic block. Contains a list of instructions none
>     of which are allowed to be a jump instruction except possibly the
>     last one.
>
>   - `nir_if`: An if statement. Each `nir_if` must be immediately
>     preceded and succeded by a `nir_block`. (This ensures that there
>     are no critical edges in the CFG.) Anir_ifcontains two lists of CF
>     nodes: One for the then case and one for the else case.
>     Thenir_ifalso contains anir_src` that is the condition for the if
>     statement. Currently, there is no if instruction; it is built into
>     the CFG.
>
>   - `nir_loop`: An endless loop. Each `nir_loop` must be immediately
>     preceded and succeded by a `nir_block`. (This ensures that there
>     are no critical edges in the CFG.) Anir_loop` contains a list of
>     CF nodes that is repeated until you hit a break instruction.
>
>   - `nir_function_impl`: A function implementation. Not to be confused
>     with a `nir_function` which may have multiple overloads not all of
>     which are implemented. The reason for all of the indirection is to
>     support shader subroutine and linking when the time comes.
>     Fortunately, there are helpers in place that make it not too bad
>     to work with. A `nir_function_impl` also contains function-local
>     stuff such as local variables and registers and other metadata.
>
> - `nir_shader`: A shader. This may contain one or more functions as
>   well as global registers and variables and other whole-shader type
>   information. Right now, a `nir_shader` usually only contains one
>   function called “main”, but that may change.
