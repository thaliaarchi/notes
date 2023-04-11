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
- Idris
  - [Learning Idris](langs/learning_idris.md)
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
- [Datalog with BDDs](topics/bdd_datalog.md)
- [E-graphs](topics/e-graphs.md)
- [Easter eggs](topics/easter_eggs.md)
- [Error handling](topics/errors.md)
- [Futamura projections](topics/futamura.md)
- [Integer division and modulo rounding](topics/div_mod_rounding.md)
- [List of ciphers](topics/ciphers.md)
- [Minimal computing models](topics/minimal_computing_models.md)
- [Nand to Tetris](topics/nand2tetris/README.md)
- [Paper notes](topics/papers.md)
- [Programming language alphabet challenge](topics/language_alphabet.md)
- [Programming language comparisons](topics/pl_comparisons.md)
- [Programming languages groups at universities](topics/universities.md)
- [Programming languages I know](topics/languages_i_know.md)
- Regular expressions
  - [Exploration of representing specialized string-searching](topics/regexp/algorithms.md)
  - [Polymorphic automata for string- and AP-matching](topics/regexp/polymorphic_automata.md)
  - [Recross ideas](topics/regexp/recross_ideas.md)
  - [Regular expression engine history](topics/regexp/history.md)
- [Tools for VCSes other than Git](topics/vcs.md)
- [Trusting Trust](topics/trusting_trust.md)
- [Unexpectedly Turing-complete](topics/unexpected_turing.md)

## Whitespace

- Compilation
  - [Compiler IRs](wspace/compile/ir.md)
  - [Implementing efficient guards](wspace/compile/guards.md)
  - [Optimizations](wspace/compile/optimizations.md)
- Design
  - [Data structures for Whitespace](wspace/design/data_structures.md)
  - [Limits for Whitespace](wspace/design/limits.md)
  - [Low-level representation for shared numbers](wspace/design/shared_numbers.md)
  - [Nebula 2 architecture plan](wspace/design/nebula2_architecture.md)
  - [Nebula 2 languages](wspace/design/nebula2_languages.md)
  - [Respace](wspace/design/respace.md)
  - [Useful lazy patterns in Whitespace](wspace/design/useful_laziness.md)
- Higher-level
  - [Expressing higher-level control-flow constructs in Whitespace](wspace/higher/higher_level_control.md)
  - [Raising Whitespace to a higher-level language](wspace/higher/raising.md)
  - [Stack substrate IL ideas from Kitten](wspace/higher/substrate_il_ideas.md)
- History
  - [20 Years of Whitespace: Past and Future](wspace/history/20th.md)
  - [Emails with Edwin and friends](wspace/history/emails.md)
  - [Haskell notes](wspace/history/haskell.md)
  - [Haskell reference interpreter](wspace/history/haskell_reference.md)
- Projects
  - [Analysis errors draft](wspace/projects/errors_draft.md)
  - [CLI draft](wspace/projects/cli_draft.txt)
  - [Haskell compiler feature detection](wspace/projects/feature_detect.md)
  - [Improving debugging for Whitespace](wspace/projects/debugging.md)
  - [Inlay hints for Whitespace](wspace/projects/inlay_hints/README.md)
  - [My Whitespace projects](wspace/projects/projects.md)
  - [Self-hosted Whitespace interpreter with lazy semantics](wspace/projects/lazy_interpreter.md)
  - [Whitespace as an Idris back-end](wspace/projects/idris_backend.md)
- Semantics
  - [GrassMudHorse](wspace/semantics/grassmudhorse.md)
  - [Implementation differences](wspace/semantics/differences.md)
  - [Laziness in Whitespace](wspace/semantics/laziness.md)
  - [Whitespace language specification](wspace/semantics/whitespace_spec.md)
  - [Whitespace resources](wspace/semantics/resources.md)
- Syntax
  - [Compact bitwise token encoding](wspace/syntax/bit_pack.md)
  - [Formal grammar for Whitespace](wspace/syntax/formal_grammar.md)
  - [Instruction prefix tree](wspace/syntax/instruction_prefix_tree.svg)
  - [Nospace grammar](wspace/syntax/nospace_grammar.bnf)
  - [Syntax error recovery](wspace/syntax/syntax_recovery.md)
  - [Whitespace assembly mnemonics](wspace/syntax/mnemonics.md)
  - [Whitespace assembly syntax](wspace/syntax/wsa_draft.md)
  - [Whitespace steganography](wspace/syntax/steganography.md)

## License

Licensed under the terms of the GNU Free Documentation License, version 1.3.
