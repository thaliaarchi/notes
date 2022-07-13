# Notes

A notebook on compilers, programming languages, and other topics.

## Compilers

- LLVM
  - [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation](compilers/llvm/cgo04_lattner.md)
  - [2020 LLVM Virtual Developers' Meeting](compilers/llvm/devmtg_2020-10)
    - [Undef and Poison: Present and Future](compilers/llvm/devmtg_2020-10/undef_and_poison.md)
    - [Everything I know about debugging LLVM](compilers/llvm/devmtg_2020-10/debugging_llvm.md)
    - [Checked C: Adding memory safety support to LLVM](compilers/llvm/devmtg_2020-10/checked_c_memory_safety.md)
    - [Posters](compilers/llvm/devmtg_2020-10/posters.md)
      - Quickly Finding RISC-V Code Quality Issues with Differential Analysis
      - llvm-diva: Debug Information Visual Analyzer
      - Enzyme: High-Performance Automatic Differentiation of LLVM
    - [MLIR Tutorial](compilers/llvm/devmtg_2020-10/mlir_tutorial.md)
    - [CIL: Common MLIR Dialect for C/C++ and Fortran](compilers/llvm/devmtg_2020-10/cil_mlir_dialect.md)
  - [LLVM architecture presentation](compilers/llvm/presentation_outline.md)
  - [Tutorials](compilers/llvm/tutorials.md)
  - [Resources](compilers/llvm/resources.md)
  - [Libraries](compilers/llvm/libraries.md)
  - [Language reference](compilers/llvm/langref.md)
  - [Version history](compilers/llvm/version_history.md)
- MLIR
  - [Tutorials](compilers/mlir/tutorials.md)
  - [Libraries](compilers/mlir/libraries.md)
- GraalVM
  - [Graal IR: An Extensible Declarative Intermediate Representation](compilers/graalvm/graalvm_paper_notes.txt)
  - [Practical Second Futamura Projection: Partial Evaluation for High-Performance Language Interpreters](compilers/graalvm/futamura.md)
  - [21.2 release highlights](compilers/graalvm/release_highlights_21.2.md)
- WebAssembly
  - [Bringing the Web up to Speed with WebAssembly](compilers/webassembly/pldi17_haas.md)
  - [Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code](compilers/webassembly/atc19_jangda.md)
  - [Multi-Value All the Wasm!](compilers/webassembly/multi_value.md)
- [QBE](compilers/qbe.md)
- [CompCert](compilers/compcert.md)
- Mesa [NIR](compilers/mesa_nir.md)

## Programming languages

- Rust
  - [Converting between Rug and bitvec types](langs/rust/convert_rug_bitvec.md)
  - [Crates and tutorials](langs/rust/rust.md)
  - [Rust Enum Expressivity](langs/rust/enum_expressivity.md)
  - [Trivia about Rust Types](langs/rust/types_trivia.md)
- [Zig](langs/zig.md)

## Topics

- Colors
  - [Color libraries and color spaces](topics/colors/color-libraries.md)
  - [Color library ideas](topics/colors/color-lib-ideas.md)
- [Compiler optimization patterns](topics/compiler_optimizations.md)
- [Data structures](topics/data_structures.md)
- [E-graphs](topics/e-graphs.md)
- [Futamura projections](topics/futamura.md)
- [List of ciphers](topics/ciphers.md)
- [Paper notes](topics/papers.md)
- [Programming language alphabet challenge](topics/language_alphabet.md)
- [Programming language rankings](topics/language_rankings.md)

## Whitespace

- [Analysis errors draft](wspace/errors_draft.md)
- [CLI draft](wspace/cli_draft.txt)
- [Compact bitwise token encoding](wspace/bit_pack.md)
- [Division and modulo rounding](wspace/divmod.md)
- [Haskell notes](wspace/haskell.md)
- [Haskell reference interpreter](wspace/haskell_reference.md)
- [Implementation differences](wspace/differences.md)
- [Inlay hints for Whitespace](wspace/inlay_hints/README.md)
- [Limits for Whitespace](wspace/limits.md)
- [My Whitespace projects](wspace/projects.md)
- [Nospace grammar](wspace/nospace_grammar.bnf)
- [Optimizations](wspace/optimizations.md)
- [Respace](wspace/respace.md)
- [Syntax error recovery](wspace/syntax_recovery.md)
- [Whitespace assembly mnemonics](wspace/mnemonics.md)
- [Whitespace assembly syntax](wspace/wsa_draft.md)
- [Whitespace language specification](wspace/whitespace_spec.md)

## License

Licensed under the terms of the GNU Free Documentation License, version 1.3.
