# C in GraalVM

## ManagedC

[“An Efficient Approach for Accessing C Data Structures from JavaScript”](https://sci-hub.st/10.1145/2633301.2633302)
(Matthias Grimmer, Thomas Würthinger, Andreas Wöß, Hanspeter Mossenböck, 2014)

This introduces ManagedC, a managed runtime for C in GraalVM.

ManagedC implements pointers to work in a JVM and safely interoperate with Java
and Truffle languages. The gist, is that it store pointers as a data-offset fat
pointer. Two pointers can be subtracted, if they have the same data. `NULL` is
represented as a pointer with null data and 0 offset. A pointer can be converted
to an integer, but not back to a pointer (the data is set to null and the offset
is set to the computed address).

Allocations are tagged with types. If an allocation has not been initialized and
has no specified type, the type is uninitialized, and writes to it add slots
with the type of the written data to its structured layout table.

Memory is managed by the JVM and not freed until it is no longer referenced.
This makes manual frees superfluous. Stack allocations are also similarly
heap-allocated. Graal performs partial escape analysis, which makes fewer
objects be allocated on the heap.

Surprisingly, it has relatively little overhead compared to unsafe C as compiled
by GCC.

## TruffleC

[“Memory-safe Execution of C on a Java VM”](https://sci-hub.st/10.1145/2786558.2786565)
(Matthias Grimmer, Roland Schatz, Chris Seaton, Thomas Würthinger, and Hanspeter
Mossenböck, 2014)

This describes how type-tagged C pointers allow for interoperability between
JavaScript (TruffleJS) and C values (TruffleC). Property access dispatches
between JS-style and C-style access. TruffleC is an earlier implementation of C
in Graal, but this design seems to largely carry over to ManagedC.
