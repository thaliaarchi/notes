# Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code

Abhinav Jangda, Bobby Powers, Emery D. Berger, and Arjun Guha
(University of Massachusetts Amherst)

Proc. of the 2019 USENIX Annual Technical Conference (USENIX ATC 19),
Renton, Washington, Jul. 2019

[[paper](https://www.usenix.org/conference/atc19/presentation/jangda)],
[[pdf](https://www.usenix.org/system/files/atc19-jangda.pdf)],
[[video](https://www.youtube.com/watch?v=dK-8O-ajQQQ)],
[[video (lightning talk)](https://www.youtube.com/watch?v=-6HoiVWiHiw)]

## Benchmarks

The PLDI'17 paper's suite of 24 benchmarks were designed to measure
polyhedral loop optimization effectivity, so are small scientific
computing programs (~100 LOC), not full applications. This paper uses
more representative benchmarks that are compiled with Browserix-Wasm.

Browserix implements a Unix-compatible kernel in JS with full support
for processes, files, pipes, blocking I/O, and other Unix features. This
paper extends Browserix as Browserix-Wasm, to compile Unix programs to
Wasm without modifications.

## Performance gaps

### More loads and stores

Code generated from WebAssembly has more loads and stores than native
code due to:
- Reduced register availability (§5.1.2)
  - Some registers are reserved by browser for JS GC root, heap, and
    scratch registers (§6.1.1)
- Sub-optimal register allocation (§5.1.2)
  - Chrome and Firefox use linear scan register allocators (like Graal),
    while Clang uses a greedy graph-coloring register allocator, which
    consistently generates better code (§6.1.2)
- Not effectively exploiting a wider range of x86 addressing modes
  - e.g., `mov ecx, [rbx+rdx*1]; add ecx, r15d; mov [rbx+rdx*1], ecx`
    instead of `add [rdi + rcx*4 + 4*NJ], ebx` (§5.1.1)
  - Chrome does not use x86-64 memory addressing modes like register
    indirect or direct offset addressing, where the operand resides in a
    memory address and the instruction can read/write to that address
    (§6.1.3)

### More branches

Code generated from WebAssembly has more branches due to:
- Extra loop jump statements (§6.2.1)
  - e.g., from not inverting loops (§5.1.3)
- Stack overflow checks per function call (§6.2.2)
  - Every function call increases the stack size global variable and
    checks that it's less than the max stack size, which adds extra
    comparison and jump instructions
- Function table indexing checks
  - Indirect call targets are dynamically-checked for type validity via
    the function table, which adds extra comparison and jump
    instructions

### Increased code size

Code generated from WebAssembly has more L1 instruction cache misses due
to the extra instructions from more register spills (poor register
allocation) and extra branches (§6.3)
