# Post-presentation Resources

## Built-in bindings

- C++
  - Public internal APIs
- C
  - Not object-oriented
  - Stable wrapper of C++ API (read/write)
- Go
  - Safe, but not ergonomic types (same issues as C++ API)
  - FFI with C API (read/write)
  - https://github.com/llvm/llvm-project/tree/main/llvm/bindings/go
- OCaml
  - FFI with C API (read/write)
  - https://github.com/llvm/llvm-project/tree/main/llvm/bindings/ocaml
- Python
  - FFI with C API (read)
  - Incomplete
  - https://github.com/llvm/llvm-project/tree/main/llvm/bindings/python

## 3rd-party bindings

- Inkwell (Rust)
  - Safe types
  - FFI with C API (read/write)
  - https://github.com/TheDan64/inkwell
- `llvm-ir` (Rust)
  - Safe types; `Instruction` is an enum (i.e., safer than Inkwell)
  - FFI with C API (read), no writing
  - Inspired by llvm-hs-pure and llvm-hs
  - https://github.com/cdisselkoen/llvm-ir
- `llvm-hs-pure`/`llvm-hs` (Haskell)
  - Safe types
  - `llvm-hs`: FFI with C++ API (read/write)
  - `llvm-hs-pure`: pure-Haskell structures (read/write)
  - https://github.com/llvm-hs/llvm-hs
  - https://hackage.haskell.org/package/llvm-hs/docs/LLVM.html
- LLIR (Go)
  - Safe types
  - Pure-Go handling of LLVM IR textual format (read/write)
  - https://github.com/llir/llvm
  - https://blog.gopheracademy.com/advent-2018/llvm-ir-and-go/

## Tools

- llvmenv (LLVM installation management): https://github.com/llvmenv/llvmenv
- Compiler Explorer (compiler output inspection): https://godbolt.org/

## Tutorials

- Kaleidoscope language tutorial:
  - C++: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html
  - OCaml: https://releases.llvm.org/12.0.1/docs/tutorial/OCamlLangImpl1.html
  - Haskell: https://www.stephendiehl.com/llvm/
  - Inkwell code:
    https://github.com/TheDan64/inkwell/tree/master/examples/kaleidoscope
  - `llvm-hs` code: https://github.com/llvm-hs/llvm-hs-kaleidoscope
- More tutorials:
  - https://llvm.org/docs/tutorial/index.html
  - https://llvm.org/docs/GettingStartedTutorials.html
  - https://discourse.llvm.org/t/beginner-resources-documentation/5872

## Readings

- Resources for Amateur Compiler Writers: https://c9x.me/compile/bib/
  (Discussion: https://news.ycombinator.com/item?id=26925314)
- MLIR keynote EuroLLVM 2019:
  https://llvm.org/devmtg/2019-04/talks.html#Keynote_1

## Alternatives to LLVM

- QBE (lightweight backend): https://c9x.me/compile/
- GCC
- GraalVM Truffle language API:
  https://www.graalvm.org/22.0/graalvm-as-a-platform/

## LLVM resources

- Language reference: https://llvm.org/docs/LangRef.html
- The Architecture of Open Source Applications: LLVM, by Chris Lattner:
  https://www.aosabook.org/en/llvm.html
- Mapping High Level Constructs to LLVM IR:
  https://mapping-high-level-constructs-to-llvm-ir.readthedocs.io/en/latest/README.html
- LLVM Weekly (newsletter): https://llvmweekly.org/

## Other

- nom parser combinators: https://github.com/Geal/nom
