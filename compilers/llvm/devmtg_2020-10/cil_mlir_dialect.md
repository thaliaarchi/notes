# CIL: Common MLIR Dialect for C/C++ and Fortran

Prashantha NR, Vinay Madhusudan, and Ranjith Kumar
(Compiler Tree Technologies)

- https://www.youtube.com/watch?v=mNA5bwsKepQ
- https://whova.com/portal/webapp/llvm_202010/Agenda/1162333

CIL, pronounced "seal".

Types have a very close correspondence with C types and are target
independent.

Unstructured control flow like `break`, `continue`, and `goto` needs
another pass to convert to `affine.for`.

`cil.class` is an operation with a region and methods can be lowered to
regular functions.

With CIL, LLVM is finally able to eliminate `v.push(); v.pop();` after
so many years.

## Questions

Q: Are STL types like std::vector or std::map represented with dedicated operations in the CIL dialect? (me)

A: Currently those are still represented as classes in CIL, but it is
planned. (Vinay)
