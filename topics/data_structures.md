# Data Structures

- Racket [`VList`](https://docs.racket-lang.org/functional-data-structures/VList.html):
  Described in [“Fast Functional Lists, Hash-Lists, Deques and Variable Length
  Arrays”](https://infoscience.epfl.ch/record/52465) by Phil Bagwell (2002).

- Zig [`SegmentedList`](https://github.com/ziglang/zig/blob/master/lib/std/segmented_list.zig):
  A stack data structure that allocates list segments sized in increasing powers
  of two. Elements are never moved, so pointers to indices have the same
  lifetime as the structure itself and elements do not need to be copyable. Most
  elements are contiguous, making it cache-friendly. Append, pop, and index
  operations are O(1). The container uses O(log n) storage for list segment
  pointers.

- Sparse set: Described in [“An Efficient Representation for Sparse Sets”](https://dl.acm.org/doi/10.1145/176454.176484)
  by Preston Briggs and Linda Torczon (1993) and popularized in [“Using
  Uninitialized Memory for Fun and Profit”](https://research.swtch.com/sparse)
  by Russ Cox (2008).

  Go implementations:
  - [`regexp.queue`](https://github.com/golang/go/blob/master/src/regexp/exec.go)
    and [`queueOnePass`](https://github.com/golang/go/blob/master/src/regexp/onepass.go)
  - [`github.com/google/codesearch/sparse.Set`](https://github.com/google/codesearch/blob/master/sparse/set.go)
    and [`rsc.io/rsc/regexp/regmerge.Set`](https://github.com/rsc/rsc/blob/master/regexp/regmerge/sparse.go)
  - [`cmd/compiler/internal/ssa.sparseSet`](https://github.com/golang/go/blob/master/src/cmd/compile/internal/ssa/sparseset.go)
    and [`sparseMap`](https://github.com/golang/go/blob/master/src/cmd/compile/internal/ssa/sparsemap.go)

- [`GapVec`](https://github.com/thaliaarchi/rust-sketches/blob/main/gap-vec/src/gap_vec.rs):
  A random access container (designed by me) with constant-time indexed removal
  and an in-place free list. When an element is removed, its index is set to the
  new head of the free list and its data is overwritten to be the index of the
  old head of the free list.

- [XOR linked list](https://en.wikipedia.org/wiki/XOR_linked_list): A
  doubly-linked list, where XOR of the previous and next pointers is stored and
  the pointers are recovered while iterating, giving it the space usage of a
  singly-linked list.

- [Skip list](https://en.wikipedia.org/wiki/Skip_list): An ordered list with
  O(log n) average complexity for search and for insertion. It is a tiered
  linked list, where each layer skips fewer elements.
