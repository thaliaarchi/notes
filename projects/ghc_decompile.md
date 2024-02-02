# GHC decompilation

GHC compiles Haskell to Cmm (C--) to G-machine. Is G-machine code stored into
the binary like Java bytecode and C# IL? If so, it could be viewed and
potentially decompiled. I suspect not, because in reading compiled GHC code in
Ghidra, it looks like it's compiled to small functions in machine code for each
thunk.
