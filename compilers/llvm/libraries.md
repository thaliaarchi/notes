# LLVM Libraries

## In-tree bindings

- C++
  - Public internal APIs
- C
  - Not object-oriented
  - Generate/parse (C++ API)
  - Stable API
- [Go](https://github.com/llvm/llvm-project/tree/main/llvm/bindings/go)
  - Safe, but not ergonomic types (same issues as C++ API)
  - Generate/parse (C API)
- [OCaml](https://github.com/llvm/llvm-project/tree/main/llvm/bindings/ocaml)
  - Generate/parse (C API)
- [Python](https://github.com/llvm/llvm-project/tree/main/llvm/bindings/python)
  - Parse (C API)
  - Incomplete

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
  - Fork of in-tree Go bindings
  - Uses system-installed LLVM
  - Backports features from C++ API

## Tools

- [llvmenv](https://github.com/llvmenv/llvmenv): LLVM installation management
- [Compiler Explorer](https://godbolt.org/): compiler output inspection
