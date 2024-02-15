# ae-graphs (in Cranelift) vs e-graphs

Ae-graphs do not reuse much from e-graphs, such as the exploration phase, and
are more of a super-powered GVN/peephole. They don't do any opts like loop
hoisting. Cranelift uses a structured IR and makes its nodes be acyclic for its
ae-graphs. Control edges make it difficult.

It's still an open problem for using e-graphs with compilers and several people
have tried working on it.
