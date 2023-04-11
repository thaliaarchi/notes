# Self-hosted Whitespace interpreter with lazy semantics

Whitespace is well-suited for writing a self-hosted interpreter with lazy
semantics.

Parsing would need to be performed lazily, so that UTF-8 decoding errors are not
encountered prematurely and potentially-invalid dead code is not parsed.

Lazy stack and heap operations would need to be performed eagerly, since they're
both stored in the interpreter's heap. On an underflow error, it would clear the
interpreter's stack and perform the appropriate operation, to get the matching
error message. To get a lazy bounds error for the heap, the index would be
adjusted to be out of bounds for the interpreter's heap.

Arithmetic and input parsing is lazy for free.
