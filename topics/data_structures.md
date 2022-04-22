# Data Structures

- Racket [`VList`](https://docs.racket-lang.org/functional-data-structures/VList.html) -
  Described in [*Fast Functional Lists, Hash-Lists, Deques and Variable Length Arrays* by Phil Bagwell (2002)](https://infoscience.epfl.ch/record/52465).

- Zig [`SegmentedList`](https://github.com/ziglang/zig/blob/master/lib/std/segmented_list.zig) -
  Stack data structure that allocates list segments sized in increasing powers
  of two. Elements are never moved, so pointers to indices have the same
  lifetime as the structure itself and elements do not need to be copyable. Most
  elements are contiguous, making it cache-friendly. Append, pop, and index
  operations are O(1). The container uses O(log n) storage for list segment
  pointers.

- Sparse set -
  Described in [*An Efficient Representation for Sparse Sets* by Preston Briggs and Linda Torczon (1993)](https://dl.acm.org/doi/10.1145/176454.176484)
  and summarized in [“Using Uninitialized Memory for Fun and Profit” by Russ Cox (2008)](https://research.swtch.com/sparse).
