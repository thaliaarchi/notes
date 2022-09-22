# Emscripten: An LLVM-to-JavaScript Compiler

Alon Zakai (Mozilla)

Proc. of the 2011 ACM Object-oriented Programming, Systems, Languages, and
Applications conference (OOPSLA '11)
Portland, Oregon, Oct. 2011

[[paper](https://dl.acm.org/doi/10.1145/2048147.2048224)]

> In Section 3.2 we present the ‘Relooper’ algorithm, which generates high-level
> loop structures from the low-level branching data present in LLVM assembly. It
> is similar to loop recovery algorithms used in decompilation (see, for
> example, \[2], \[9]). The main difference between the Relooper and standard
> loop recovery algorithms is that the Relooper generates loops in a different
> language than that which was compiled originally, whereas decompilers
> generally assume they are returning to the original language. The Relooper’s
> goal is not to accurately recreate the original source code, but rather to
> generate native JavaScript control flow structures, which can then be
> implemented efficiently in modern JavaScript engines
