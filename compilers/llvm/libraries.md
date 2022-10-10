# LLVM Libraries

## In-tree bindings

- C++
  - Public internal APIs
- C
  - Not object-oriented
  - Generate/parse (C++ API)
  - Stable API
- [OCaml](https://github.com/llvm/llvm-project/tree/main/llvm/bindings/ocaml)
  - Generate/parse (C API)
- [Python](https://github.com/llvm/llvm-project/tree/main/llvm/bindings/python)
  - Parse (C API)
  - Incomplete
- [Go](https://github.com/llvm/llvm-project/tree/36b13eb8bb9dafb6a190189ada89eba15e85d39b/llvm/bindings/go)
  ([removed](https://discourse.llvm.org/t/rfc-remove-the-go-bindings/65725))
  - Development has moved out of tree to TinyGo

## 3rd-party bindings

- [Inkwell](https://github.com/TheDan64/inkwell) (Rust)
  - Safe types
  - Generate/parse (C API)
- [llvm-ir](https://github.com/cdisselkoen/llvm-ir) (Rust)
  - Safe types; `Instruction` is an enum (i.e., safer than Inkwell)
  - Parse (C API)
  - Inspired by llvm-hs-pure and llvm-hs
- [llvm-hs](https://github.com/llvm-hs/llvm-hs) (Haskell)
  - Safe types
  - Generate/parse (C and C++ API) and pure-Haskell structures with
    bidirectional conversions to/from LLVM types
  - [Docs](https://hackage.haskell.org/package/llvm-hs/docs/LLVM.html)
- [LLIR](https://github.com/llir/llvm) (Go)
  - Safe types
  - Generate/parse (textual LLVM IR)
  - [Blog post](https://blog.gopheracademy.com/advent-2018/llvm-ir-and-go/)
- TinyGo [go-llvm](https://github.com/tinygo-org/go-llvm) (Go)
  - Safe, but not ergonomic types (same issues as C++ API)
  - Generate/parse (C API)
  - Uses system-installed LLVM
  - Backports features from C++ API

## Tools

- [llvmenv](https://github.com/llvmenv/llvmenv): LLVM installation management
- [Compiler Explorer](https://godbolt.org/): compiler output inspection
