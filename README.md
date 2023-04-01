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
  - [MLIR: Scaling Compiler Infrastructure for Domain Specific Computation](compilers/mlir/cgo21_lattner.md)
  - [Tutorials](compilers/mlir/tutorials.md)
  - [Libraries](compilers/mlir/libraries.md)
  - [Projects](compilers/mlir/projects.md)
- GraalVM
  - [GraalVM papers](compilers/graalvm/papers.md)
  - [Graal IR: An Extensible Declarative Intermediate Representation](compilers/graalvm/graalvm_paper_notes.txt)
  - [Practical Second Futamura Projection: Partial Evaluation for High-Performance Language Interpreters](compilers/graalvm/futamura.md)
  - [21.2 release highlights](compilers/graalvm/release_highlights_21.2.md)
- WebAssembly
  - [Bringing the Web up to Speed with WebAssembly](compilers/webassembly/pldi17_haas.md)
  - [Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code](compilers/webassembly/atc19_jangda.md)
  - [Multi-Value All the Wasm!](compilers/webassembly/multi_value.md)
- [Emscripten](compilers/emscripten.md)
- [QBE](compilers/qbe.md)
- [CompCert](compilers/compcert.md)
- Mesa [NIR](compilers/mesa_nir.md)

## Programming languages

- [AsciiDots](langs/asciidots.md)
- Brainfuck
  - [Brainfuck](langs/brainfuck/brainfuck.md)
  - [Ook!](langs/brainfuck/ook.md)
  - [Spoon](langs/brainfuck/spoon.md)
- [Deadfish](langs/deadfish.md)
- Rust
  - [Converting between Rug and bitvec types](langs/rust/convert_rug_bitvec.md)
  - [Crates and tutorials](langs/rust/rust.md)
  - [Rust Enum Expressivity](langs/rust/enum_expressivity.md)
  - [Trivia about Rust Types](langs/rust/types_trivia.md)
- [Zig](langs/zig.md)

## Topics

- Adapton
  - [Adapton: Composable, Demand-Driven Incremental Computation](topics/adapton/pldi2014.md)
    (PLDI 2014)
  - [Incremental Computation with Adapton](topics/adapton/boulder2015.md)
    (University of Colorado Boulder, 2015)
  - [miniAdapton: A Minimal Implementation of Incremental Computation in Scheme](topics/adapton/miniAdapton.md)
    (2016)
  - [Presentation outline](topics/adapton/presentation_outline.md) (2022)
- Archival
  - [Archiver tool](topics/archival/archiver_tool.md)
  - [Code Golf archival](topics/archival/code_golf_archival.md)
- [Bits and arithmetic](topics/bits_and_arithmetic.md)
- Colors
  - [Color libraries and color spaces](topics/colors/color-libraries.md)
  - [Color library ideas](topics/colors/color-lib-ideas.md)
- [Compiler optimization patterns](topics/compiler_optimizations.md)
- [Data structures](topics/data_structures.md)
- [E-graphs](topics/e-graphs.md)
- [Error handling](topics/errors.md)
- [Futamura projections](topics/futamura.md)
- [List of ciphers](topics/ciphers.md)
- [Nand to Tetris ALU instructions](topics/nand2tetris/ALU.md)
- [Paper notes](topics/papers.md)
- [Programming language alphabet challenge](topics/language_alphabet.md)
- [Programming language comparisons](topics/pl_comparisons.md)
- [Programming languages I know](topics/languages_i_know.md)
- Regular expressions
  - [Exploration of representing specialized string-searching](topics/regexp/algorithms.md)
  - [Polymorphic automata for string- and AP-matching](topics/regexp/polymorphic_automata.md)
  - [Recross ideas](topics/regexp/recross_ideas.md)
  - [Regular expression engine history](topics/regexp/history.md)
- [Tools for VCSes other than Git](topics/vcs.md)
- [Trusting Trust](topics/trusting_trust.md)
- [Unexpectedly Turing-complete](topics/unexpected_turing.md)
- [Universities](topics/universities.md)

## Whitespace

- [Analysis errors draft](wspace/errors_draft.md)
- [CLI draft](wspace/cli_draft.txt)
- [Compact bitwise token encoding](wspace/bit_pack.md)
- [Compiler IRs](wspace/ir.md)
- [Division and modulo rounding](wspace/divmod.md)
- [Expressing higher-level control-flow constructs in Whitespace](wspace/higher_level_control.md)
- [GrassMudHorse](wspace/grassmudhorse.md)
- [Haskell notes](wspace/haskell.md)
- [Haskell reference interpreter](wspace/haskell_reference.md)
- [Implementation differences](wspace/differences.md)
- [Improving debugging for Whitespace](wspace/debugging.md)
- [Inlay hints for Whitespace](wspace/inlay_hints/README.md)
- [Laziness in Whitespace](wspace/laziness.md)
- [Limits for Whitespace](wspace/limits.md)
- [Low-level representation for shared numbers](wspace/shared_numbers.md)
- [My Whitespace projects](wspace/projects.md)
- [Nebula 2 architecture plan](wspace/nebula2_architecture.md)
- [Nebula 2 languages](wspace/nebula2_languages.md)
- [Nospace grammar](wspace/nospace_grammar.bnf)
- [Optimizations](wspace/optimizations.md)
- [Raising Whitespace to a higher-level language](wspace/raising.md)
- [Respace](wspace/respace.md)
- [Self-hosted Whitespace interpreter with lazy semantics](wspace/lazy_interpreter.md)
- [Stack substrate IL ideas from Kitten](wspace/substrate_il_ideas.md)
- [Syntax error recovery](wspace/syntax_recovery.md)
- [Useful lazy patterns in Whitespace](wspace/useful_laziness.md)
- [Whitespace 20th anniversary](wspace/20th.md)
- [Whitespace as an Idris back-end](wspace/idris_backend.md)
- [Whitespace assembly mnemonics](wspace/mnemonics.md)
- [Whitespace assembly syntax](wspace/wsa_draft.md)
- [Whitespace language specification](wspace/whitespace_spec.md)
- [Whitespace resources](wspace/resources.md)

## License

Licensed under the terms of the GNU Free Documentation License, version 1.3.
