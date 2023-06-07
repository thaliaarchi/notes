# Implementing efficient guards

When accessing a value from the stack, the implementation needs to check for
underflow. In an interpreter, this is done while executing the stack-accessing
instruction. A compiler can do better, though.

For example, this program has three instructions that may underflow, without
knowing anything about the size of the stack before `l1`:

```wsa
l1:
    div         # access 2
    mul         # access 3
    printi
    dup         # access 4
    printi
    jmp l2
```

It consists of a single basic block, that would be lowered via the Nebula
strategy of registerizing stack operations in a basic block to something like
this:

```ir
l1:
    guard underflow(2), source(div, line 2)
    %0 = load_stack 0
    %1 = load_stack 1
    %2 = div_lazy %0, %1
    guard underflow(3), source(mul, line 3)
    %3 = load_stack 2
    %4 = mul_lazy %3, %2
    eval %4
    printi %4
    guard underflow(4), source(dup, line 5)
    %5 = load_stack 3
    eval %5
    printi %5
    drop 3
    jmp l2
```

When the stack has a size less than `2`, then the predicate `underflow(2)` is
true and `guard underflow(2), source(div, line 2)` produces an error,
identifying the `div` on line 2 as the originating instruction. `guard` can also
take a label as the second parameter, in which case it jumps there when the
predicate is true.

This program currently checks the stack size for each operation that accesses
lower on the stack. For this small program, it's only three guards, but it would
be many more for larger programs. None of the `guard` operations can be simply
combined, though, or the effects would be out of order.

If we assume that nearly all executions never underflow and that an underflow
would occur later in execution, we can optimize for the branch that won't
underflow. First, duplicate the basic block and replace the largest underflow
guard with an `error`, making it the terminator. Then, in the original basic
block, move that corresponding guard to the top and eliminate the other
underflow guards.

```ir
l1:
    guard underflow(4), .l1__underflow
    %0 = load_stack 0
    %1 = load_stack 1
    %2 = div_lazy %0, %1
    %3 = load_stack 2
    %4 = mul_lazy %3, %2
    eval %4
    printi %4
    %5 = load_stack 3
    eval %5
    printi %5
    drop 3
    jmp l2

.l1__underflow:
    guard underflow(2), source(div, line 2)
    %0 = load_stack 0
    %1 = load_stack 1
    %2 = div_lazy %0, %1
    guard underflow(3), source(mul, line 3)
    %3 = load_stack 2
    %4 = mul_lazy %3, %2
    eval %4
    printi %4
    error underflow(4), source(dup, line 5)
```

In the worst case, when few underflow guards can be removed by analysis, this
doubles the program size, but it reduces the number of underflow checks from one
per stack-accessing instructions to one per basic block. When an execution
underflows, it will still check for underflow on any lower access, but only for
that final basic block. As it is not possible for it to loop at this point, it
is generally a small overhead.

After a strictness analysis, the order of evaluation is made explicit and guards
are inserted for zero divisors:

```ir
l1:
    guard underflow(4), .l1__underflow
    %0 = load_stack 2
    eval %0
    %1 = load_stack 1
    eval %1
    guard zero(%1), source(div, line 2)
    %2 = load_stack 0
    eval %2
    %3 = div %2, %1
    %4 = mul %0, %3
    printi %4
    %5 = load_stack 3
    eval %5
    printi %5
    drop 3
    jmp l2

.l1__underflow:
    guard underflow(2), source(div, line 2)
    guard underflow(3), source(mul, line 3)
    %0 = load_stack 2
    eval %0
    %1 = load_stack 1
    eval %1
    guard zero(%1), source(div, line 2)
    %2 = load_stack 0
    eval %2
    %3 = div %2, %1
    %4 = mul %0, %3
    printi %4
    error underflow(4), source(dup, line 5)
```

Since the analyzer has the full program available, in most cases, the stack can
be statically determined to not underflow, so most stack guards will be
eliminated.
