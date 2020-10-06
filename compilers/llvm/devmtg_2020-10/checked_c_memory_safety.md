# Checked C: Adding memory safety support to LLVM

Mandeep Singh Grang, Katherine Kjeer (Microsoft)

- https://www.youtube.com/watch?v=dgJ_43OWZbA
- https://whova.com/portal/webapp/llvm_202010/Agenda/1162346

## Description

Checked C is an open-source extension to C designed by Microsoft to
guarantee spatial safety. Checked C adds static and dynamic checking to
C to detect or prevent memory access violations. It introduces new
"checked" pointer and array pointer types and requires the programmer to
annotate these with bounds. It then uses the bounds to ensure the safety
of memory accesses.

Checked C has been implemented in LLVM and Clang. In this talk, we
describe the design of bounds annotations for checked pointers and array
pointers in the Clang AST as well as the framework for the static
checking of the soundness of bounds. We also briefly describe novel
algorithms to automatically widen bounds for null-terminated arrays and
for comparison of expressions for equivalence. We also report on some of
the challenges we faced like undefined behavior due to integer overflow
and memory overhead due to Clang's memory management. Finally, we
describe how we modified LLVM’s lit framework to support Checked C’s
runtime unit testing for X86 and ARM.

## References

1. Checked C language specification -
   https://github.com/Microsoft/checkedc/releases
2. Checked C project repo - https://github.com/microsoft/checkedc
3. Checked C Clang repo - https://github.com/microsoft/checkedc-clang
4. Checked C SecDev 2018 paper -
   https://www.microsoft.com/en-us/research/publication/checkedc-making-c-safe-by-extension

## What is Checked C (1:40)

- Extension to C - supports spatial safety
- New pointer types - adds 3 new pointer types that are bounds-checked
- Incremental porting - allows incremental porting from legacy C
- Syntax like C++ - syntax for checked pointers is borrowed from C++
  templates
- Implemented in Clang - Checked C has been implemented in our fork of
  clang

## `_Ptr<T>` (2:20)

- Points to a single object of type T
- No pointer arithmetic, used for dereference only
- Runtime check for non-nullness, if necessary

## `_Array_ptr<T>` (3:10)

- Points to an element of an array of type T
- Pointer arithmetic allowed
- Runtime check for non-nullness and bounds, if necessary

## `_Nt_array_ptr<T>` (4:00)

- Points to a sequence of elements that ends with a null terminator
- An element of the sequence can be read, provided the preceding
  elements are not the null terminator
- Bounds automatically widened based on number of elements read
