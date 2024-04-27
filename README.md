# Notes

A notebook on compilers, programming languages, and other topics.

## Compilers

- LLVM
  - [LLVM M.S. Thesis](compilers/llvm/thesis.md)
  - [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation](compilers/llvm/cgo04_lattner.md)
  - [2020 LLVM Virtual Developers' Meeting](compilers/llvm/index.md)
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
  - [Graal IR: An Extensible Declarative Intermediate Representation](compilers/graalvm/graal_ir.md)
  - [Practical Second Futamura Projection: Partial Evaluation for High-Performance Language Interpreters](compilers/graalvm/futamura.md)
  - [Release highlights](compilers/graalvm/release_highlights.md)
- HotSpot
  - [The Sea of Nodes and the HotSpot JIT](compilers/hotspot/sea_of_nodes.md)
- WebAssembly
  - [Bringing the Web up to Speed with WebAssembly](compilers/webassembly/pldi17_haas.md)
  - [Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code](compilers/webassembly/atc19_jangda.md)
  - [Multi-Value All the Wasm!](compilers/webassembly/multi_value.md)
- Cranelift
  - [ægraphs: Acyclic E-graphs for Efficient Optimization in a Production Compiler](compilers/cranelift/ae-graphs.md)
  - [Contributing to Cranelift](compilers/cranelift/contributing.md)
  - [Cranelift mid-end optimizers](compilers/cranelift/mid-end.md)
- [Emscripten](compilers/emscripten.md)
- [QBE](compilers/qbe.md)
- [CompCert](compilers/compcert.md)
- Mesa [NIR](compilers/mesa_nir.md)
- [Coffee Compiler Club 2023-09-08](compilers/coffee_compiler_club_20230908.md)
- [Coffee Compiler Club 2023-10-06 with Simon Peyton Jones](compilers/coffee_compiler_club_20231006.md)

## Programming languages

- Programming languages
  - Go
    - [Go history](pl/langs/go/history.md)
  - Idris
    - [Learning Idris](pl/langs/idris/learning_idris.md)
  - jq
    - [Initial implementations of jq](pl/langs/jq/proto_jq.md)
  - Rust
    - [Converting between Rug and bitvec types](pl/langs/rust/convert_rug_bitvec.md)
    - [Crates and tutorials](pl/langs/rust/rust.md)
    - [Rust enum expressivity](pl/langs/rust/enum_expressivity.md)
    - [Rust history](pl/langs/rust/history.md)
    - [Trivia about Rust Types](pl/langs/rust/types_trivia.md)
  - [Zig](pl/langs/zig.md)
- Esoteric programming languages
  - [AsciiDots](pl/esolangs/asciidots.md)
  - Brainfuck
    - [Brainfuck](pl/esolangs/brainfuck/brainfuck.md)
    - [Ook!](pl/esolangs/brainfuck/ook.md)
    - [Spoon](pl/esolangs/brainfuck/spoon.md)
  - [Deadfish](pl/esolangs/deadfish.md)
  - [Featured languages on the Esolang wiki](pl/esolangs/esolang_wiki_featured.md) (category)
  - [Leaf](pl/esolangs/leaf.md)
  - [PLT Games](pl/esolangs/plt-games/index.md) (category)
  - [Whitespace](#whitespace)
- Comparisons
  - [Programming language comparisons](pl/compare/comparisons.md)
  - [Programming language specifications](pl/compare/specs.md)
  - [Comparison of integer literal syntax](pl/compare/integer_literals.md)
- Lists
  - [Programming language alphabet challenge](pl/lists/alphabet_challenge.md)
  - [PL groups at universities](pl/lists/research_groups.md)
  - [Programming languages I know](pl/lists/languages_i_know.md)
- [Paper notes](pl/papers.md)

## Logic

- Adapton
  - [Adapton: Composable, Demand-Driven Incremental Computation](logic/adapton/pldi2014.md)
    (PLDI 2014)
  - [Incremental Computation with Adapton](logic/adapton/boulder2015.md)
    (University of Colorado Boulder, 2015)
  - [miniAdapton: A Minimal Implementation of Incremental Computation in Scheme](logic/adapton/miniAdapton.md)
    (2016)
  - [Presentation outline](logic/adapton/presentation_outline.md) (2022)
- [BDDs and other decision diagrams](logic/bdds.md)
- E-graphs
  - [ægraphs: Acyclic E-graphs for Efficient Optimization in a Production Compiler](logic/e-graphs/ae-graphs.md)
  - [ae-graphs (in Cranelift) vs e-graphs](logic/e-graphs/ae-graphs_vs_e-graphs.md)
  - [E-graph literature survey](logic/e-graphs/survey.md)
  - [Guided equality saturation](logic/e-graphs/guided_eqsat.md)
- [Rete Algorithm](logic/rete.md)

## Projects

- [Buffered I/O library ideas](projects/bufio_library.md)
- [Detecting esolang polyglots](projects/esolang_detect.md)
- [GHC decompilation](projects/ghc_decompile.md)
- [Loose threads](projects/loose_threads.md)
- [Personal git forge](projects/personal_git_forge.md)
- [Post-undergrad projects](projects/post_undergrad.md)
- [Project genesis](projects/project_genesis.md)
- [Requesting a list of all Git commits from a forge](projects/git_ls_remote_orphans.md)
- [tar library](projects/tar_library.md)

## Topics

- Archival
  - [Archiver tool](topics/archival/archiver_tool.md)
  - [Code Golf archival](topics/archival/code_golf_archival.md)
  - [Developing with the Internet Archive](topics/archival/internet_archive.md)
- [Bits and arithmetic](topics/bits_and_arithmetic.md)
- Colors
  - [Color in browser engines](topics/colors/browser_color.md)
  - [Color libraries and color spaces](topics/colors/color_libraries.md)
- Compiler optimizations
  - [Compiler optimization patterns](topics/optimizations/patterns.md)
  - [Tail-call optimization](topics/optimizations/tail_calls.md)
- [Computability](topics/computability.md)
- [Data structures](topics/data_structures.md)
- [Easter eggs](topics/easter_eggs.md)
- [Error handling](topics/errors.md)
- Floating-point arithmetic
  - [Boolean algebra with floating-point numbers](topics/floating-point/boolean_algebra.md)
  - [Software floating point libraries](topics/floating-point/softfloat.md)
- [Futamura projections](topics/futamura.md)
- [History of Plan 9](topics/plan9.md)
- [Integer division and modulo rounding](topics/div_mod_rounding.md)
- [Language server design](topics/language_server.md)
- [List of ciphers](topics/ciphers.md)
- [Minecraft decompilation](topics/minecraft_decompilation.md)
- [Nand to Tetris](topics/nand2tetris/README.md)
- [QR code art](topics/qr.md)
- Regular expressions
  - [ActionScript 3 `RegExp`](topics/regexp/actionscript.md)
  - [Exploration of representing specialized string-searching](topics/regexp/algorithms.md)
  - [Grammar for Rust `regex`](topics/regexp/rust_regex.bnf)
  - [Pike–Levenshtein: Regular expressions with an edit distance](topics/regexp/pike-levenshtein.md)
  - [Polymorphic automata for string- and AP-matching](topics/regexp/polymorphic_automata.md)
  - [Recross ideas](topics/regexp/recross_ideas.md)
  - [Regular expression engine history](topics/regexp/history.md)
  - [Regular expression implementations](topics/regexp/engines.md)
  - [S-Lang SLregexp and SLsearch](topics/regexp/slang.md)
  - [Text editors](topics/regexp/text_editors.md)
  - [Thompson regular expressions](topics/regexp/thompson.md)
- [Short notes on papers](topics/short_paper_notes.md)
- [Tree-sitter](topics/tree-sitter.md)
- [Trusting Trust](topics/trusting_trust.md)
- [Unexpectedly Turing-complete](topics/unexpected_turing.md)
- Version control systems
  - [List of version control systems](topics/vcs/history.md)
  - [VCS import and export](topics/vcs/import_export.md)

## Whitespace

- [Assembly](wspace/assembly/index.md)
- Compilation
  - [Front-end](wspace/front/index.md)
  - [Back-end](wspace/back/index.md)
- [Design](wspace/design/index.md)
- [History](wspace/history/index.md)
- [Programs](wspace/programs/index.md)
- [Semantics](wspace/semantics/index.md)
- [Syntax](wspace/syntax/index.md)
- [Tools](wspace/tools/index.md)
- [VM](wspace/vm/index.md)

## License

Licensed under the terms of the GNU Free Documentation License, version 1.3.
