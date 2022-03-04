# LLVM Version History

## LLVM 2.0

["LLVM 2.0 and Beyond!"](https://www.llvm.org/pubs/2007-07-25-LLVM-2.0-and-Beyond.html).
Chris Lattner.
Google Tech Talk, Mountain View, CA, July 2007.

Summary:
- novel capabilities of LLVM
- LLVM 2.0 IR changes
- motivation for Clang vs continuing to use GCC

> Two major IR changes:
> - Signless types
> - Arbitrary-precision integers

> **LLVM 2.0 IR: Signless Types**
>
> The LLVM 1.9 IR uses integer type system very similar to C:
> - signed vs unsigned 8/16/32/64 bit integers
> The LLVM 2.0 IR uses integer types similar to CPUs:
> - 8/16/32/64 bits, with sign stored in operators (e.g. sdiv vs udiv)
>
> Advantages:
> - Smaller IR: don’t need “noop” conversions (e.g. uint <--> sint)
> - More explicit operations (e.g. ‘sign extend’ instead of ‘cast’)
> - Redundancy elimination: (actually happens during strength reduction)

> **LLVM 2.0 IR: Arbitrary precision integers**
>
> - LLVM 2.0 allows arbitrary fixed width integers:
>   - i2, i13, i128, i1047, i12345, etc
> - Primarily useful to EDA / hardware synthesis business:
>   - An 11-bit multiplier is significantly cheaper/smaller than a 16-bit one
>   - Can use LLVM analysis/optimization framework to shrink variable widths
>   - Patch available that adds an attribute in llvm-gcc to get this
> - Implementation impact of arbitrary width integers:
>   - Immediates, constant folding, intermediate arithmetic simplifications
>   - New “APInt” class used internally to represent/manipulate these
>   - Makes LLVM more portable, not using uint64_t everywhere for arithmetic
