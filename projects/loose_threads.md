# Loose threads

## Projects

- Blog
  - Engine
    - [Zola](https://www.getzola.org/)
    - [Eleventy](https://www.11ty.dev/)
    - [Jekyll vs Hugo vs Gatsby vs Next vs Zola vs Eleventy](https://mtm.dev/static)
    - [Simplified Saaze](https://jamstack.org/generators/simplified-saaze/)
  - Hosting
    - GitHub Pages: [custom domains](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages)
    - [Codeberg Pages](https://docs.codeberg.org/codeberg-pages/)
    - [pages.gay](https://pages.gay/)
  - Inspiration
    - Philip Zucker: [notes](https://www.philipzucker.com/notes/) [[git](https://github.com/philzook58/philzook58.github.io)]
    - Andy Matuschak: [notes](https://notes.andymatuschak.org/About_these_notes)
    - Nikita Voloboev: [notes](https://wiki.nikiv.dev/) [[git](https://github.com/nikitavoloboev/knowledge)]
    - June McEnroe: [Git forge](https://git.causal.agency/), `man`-style
      [project list](https://causal.agency/)
    - Robin Schroer: [blog](https://blog.sulami.xyz/) [[generator](https://github.com/sulami/blog)]
    - Chris Wellons: [blog](https://nullprogram.com/) [[git](https://github.com/skeeto/skeeto.github.com)]
- Forge
  - [Software Forge Performance Index](https://forgeperf.org/)
- Contributing to jq
  - [gojq#86 ER: basic TCO](https://github.com/itchyny/gojq/issues/86)
  - [jq#2707 `reduce` performance is poor](https://github.com/jqlang/jq/issues/2707)
- Contributing to egglog
  - Interesting issues: [Egglog interface from rust](https://github.com/egraphs-good/egglog/issues/232)
- Finish Bitwuzla bindings

## Topics

Resources I want to explore further, grouped by topic. This functions
additionally as a reading list.

- Compiler and language design
  - Language server
    - [Embedded languages](https://code.visualstudio.com/api/language-extensions/embedded-languages)
      and [injection grammars](https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide#injection-grammars)
      in VS Code
  - Front-end
    - [Algorithms in Rust for implementing pattern matching](https://github.com/yorickpeterse/pattern-matching-in-rust)
      by Yorick Peterse (2022-2024)
  - IR
    - RVSDG (Regionalized Value State Dependence Graph)
      - [optir](https://github.com/jameysharp/optir): Proof-of-concept RVSDG IR
      - [numba-rvsdg](https://github.com/numba/numba-rvsdg): Numba-compatible
        RVSDG utilities
    - History of CPS, SSA, and ANF in the context of the [T programming language](https://paulgraham.com/thist.html)
      [[HN](https://news.ycombinator.com/item?id=36732335)] and a related [thread](https://langdev.stackexchange.com/questions/2079/what-are-the-disadvantages-of-using-cps-form)
    - [*Modern Compiler Implementation in Java, ML, or C*](https://www.cs.princeton.edu/~appel/modern/)
      by Andrew W. Appel (1998): [covers](../topics/short_paper_notes.md) SSA
      form and its rationale, structural properties, and calculation, efficient
      calculation of dominance frontiers, various optimizations with SSA, and
      CPS and ANF relative to SSA
  - Runtime
    - [Writing a JVM in Rust](https://andreabergia.com/blog/2023/07/i-have-written-a-jvm-in-rust/)
      series by Andrea Bergia (2023)
    - [Boehm–Demers–Weiser GC](https://www.hboehm.info/gc/)
      - Wasmtime considered it for use as a general-purpose GC for WebAssembly,
        until that goal was [removed](https://github.com/bytecodealliance/rfcs/commit/b678bf4796851e19ebc41c88c90f76cd0ecd9fb1)
        from the roadmap
  - Hardware
    - From Nand to Tetris
    - [Nandgame](https://nandgame.com/) (and [r/nandgame_u](https://www.reddit.com/r/nandgame_u))
    - [MHRD](https://steamcommunity.com/app/576030): game to design CPU in
      hardware description language
    - [Bitwise](https://github.com/pervognsen/bitwise): series to build a hardware
      and software stack from scratch
- Languages
  - WebAssembly
    - [GC Extension](https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md)
    - [RFC: Add support for the WebAssembly tail calls proposal in Wasmtime](https://github.com/bytecodealliance/rfcs/blob/main/accepted/tail-calls.md)
      [[PR](https://github.com/bytecodealliance/rfcs/pull/29)] (2023-01-20)
    - [RFC: Implement Wasm GC in Wasmtime](https://github.com/bytecodealliance/rfcs/blob/main/accepted/wasm-gc.md)
      [[PR](https://github.com/bytecodealliance/rfcs/pull/31)] (2023-04-14)
    - [“Extended Numeric Representations in WebAssembly”](https://www-old.cs.utah.edu/docs/techreports/2019/pdf/UUCS-19-009.pdf),
      Bachelor's thesis by Scott Butler, supervised by Matthew Flatt
      (December 2019) [[code](https://github.com/ScottButler87/ExtendedNumerics)]
  - Rust
    - [Tree Borrows](https://perso.crans.org/vanille/treebor/)
      by Neven Villani (2023)
    - [Prusti](https://www.pm.inf.ethz.ch/research/prusti.html) [[src](https://github.com/viperproject/prusti-dev)]:
      automated static program verifier for Rust, built at ETHZ
  - Haskell
    - Resources for [reading GHC Core](https://stackoverflow.com/questions/6121146/reading-ghc-core)
  - Idris
    - Read the papers by [Edwin Brady](../pl/lists/research_groups.md#st-andrews)
- [Structured concurrency](https://en.wikipedia.org/wiki/Structured_concurrency)
  - In [“References are like jumps”](https://without.boats/blog/references-are-like-jumps/)
    (2024), without.boats briefly discusses how Rust formerly had structured
    concurrency and its benefits, namely that it eliminates dynamic locking.
    This article (but not structured concurrency) was followed up on
    [by Grayden Hoare](https://graydon2.dreamwidth.org/312681.html).
  - Is structured concurrency as powerful as structured control flow? What
    patterns are not possible with it (cf. generators with structured control
    flow).
- Formal methods
  - [*Programming Z3*](https://theory.stanford.edu/~nikolaj/programmingz3.html)
    (Nikolaj Bjørner, Leonardo de Moura, Lev Nachmanson, and Christoph
    Wintersteiger, 2018) [[git](https://github.com/Z3Prover/doc/tree/master/programmingz3)]
  - [“Bitwuzla”](https://link.springer.com/chapter/10.1007/978-3-031-37703-7_1)
    (Aina Niemetz and Mathias Preiner, 2023)
  - [What I've Learned About Formal Methods In Half a Year](https://jakob.space/blog/what-ive-learned-about-formal-methods.html)
    by Jakob Kreuze (2023) [[HN](https://news.ycombinator.com/item?id=35511152)
    describes what the author learned from [CSCI 1710: Logic for Systems](https://csci1710.github.io/)
    (model checking with Alloy) and [CSCI 1951x Formal Proof and Verification](https://browncs1951x.github.io/)
    (formal verification with Lean) at Brown. In the latter, they implemented
    Scheme in Lean. Resources mentioned:
    - [*The Hitchhiker’s Guide to Logical Verification*](https://lean-forward.github.io/hitchhikers-guide/2024/)
      teaches Lean and is used in Brown CS 1951x. Seems similar to Software
      Foundations.
    - [Lean Game Server](https://adam.math.hhu.de/): games to learn Lean 4
  - [General purpose programming in Lean](https://proofassistants.stackexchange.com/questions/1093/can-the-language-of-proof-assistants-be-used-for-general-purpose-programming/1102#1102)
    (and briefly other proof assistants)
  - [“Pancake: Verified Systems Programming Made Sweeter”](https://trustworthy.systems/publications/papers/Pohjola_STWSNUMSMNH_23.abstract)
    (Johannes Åman Pohjola, Hira Taqdees Syeda, Miki Tanaka, Krishnan Winter,
    Gordon Sau, Ben Nott, Tiana Tsang Ung, Craig McLaughlin, Remy Seassau,
    Magnus Myreen, Michael Norrish, and Gernot Heiser, PLOS 2023)
- Computing history
  - [The Apollo Guidance Computer: Architecture and Operation](http://www.apolloguidancecomputer.com/)
    [[HN](https://news.ycombinator.com/item?id=38245884)]
    - [related videos and talks linked by HN](https://news.ycombinator.com/item?id=38244927)
  - [A Personal History of APL](https://ed-thelen.org/comp-hist/APL-hist.html)
    by Michael S. Montalbano (1982)
  - Proceedings of the History of Programming Languages conference
  - Chris Lattner
    - [Lessons from LLVM: An SC21 Fireside Chat with Chris Lattner](https://www.hpcwire.com/2021/12/27/lessons-from-llvm-an-sc21-fireside-chat-with-chris-lattner/)
      (2021)
    - [Chris Lattner on the origins of Swift](https://oleb.net/2019/chris-lattner-swift-origins/)
      (2019)
- Bootstrapping
  - Rust
    - [mrustc](https://github.com/thepowersgang/mrustc)
      - [Bootstrapping Rust](https://guix.gnu.org/blog/2018/bootstrapping-rust/)
        by Danny Milosavljevic (2018)
    - [Bootstrapping](https://rustc-dev-guide.rust-lang.org/building/bootstrapping/what-bootstrapping-does.html)
      in the Rust Compiler Development Guide
  - [GNU Mes](https://www.gnu.org/software/mes/manual/mes.html)
    - [Milestone — MesCC builds TinyCC and fun C errors for everyone](https://ekaitz.elenq.tech/bootstrapGcc8.html)
      [[HN](https://news.ycombinator.com/item?id=38079381)]
- Performance
  - [The Rust Performance Book](https://nnethercote.github.io/perf-book/)
    by Nicholas Nethercote (2020)
  - [One Hundred Thousand Lines of Rust](https://matklad.github.io/2021/09/05/Rust100k.html)
    blog series by Alex Kladov (2021) [[discussion](https://old.reddit.com/r/rust/comments/lto0qa/blog_post_delete_cargo_integration_tests/)]
- Systems
  - [Shadow](https://goose.icu/introducing-shadow/): novel browser engine in JS
    [[HN](https://news.ycombinator.com/item?id=38043033)]

## Tools and libraries to try

- Rust
  - [cross](https://github.com/cross-rs/cross): cross-compilation and
    cross-testing of crates
  - [cxx](https://github.com/dtolnay/cxx): safe interop between Rust and C++
  - [Gxhash](https://github.com/ogxd/gxhash): fast non-cryptograph hashing
    algorithm
  - [insta](https://github.com/mitsuhiko/insta): snapshot testing
  - [self_cell](https://github.com/Voultapher/self_cell): self-referential
    structs
- [Ryu](https://github.com/ulfjack/ryu): IEEE-754 fast and accurate string
  formatting
  - [dtolnay/ryu](https://github.com/dtolnay/ryu): Rust port
    - Boa [Ryū-js](https://github.com/boa-dev/ryu-js): adaptation for
      JavaScript engine
- [Dash](https://kapeli.com/dash): offline API documentation browser for macOS
- [VSCode LLVM Compiler Explorer](https://github.com/sunxfancy/vscode-llvm):
  exploring LLVM IR and machine IR after each pass

### Developments to follow

- [ipnsort](https://github.com/Voultapher/sort-research-rs/tree/main/ipnsort)
  is a sorting algorithm by Lukas Bergdoll, which performs at the top of
  benchmarks for unstable sorts, passes all [safety and correctness criteria](https://github.com/Voultapher/sort-research-rs/blob/main/writeup/sort_safety/text.md),
  and is designed as the new Rust `slice::sort_unstable` (as mentioned on [HN](https://news.ycombinator.com/item?id=37783270))

## Other

- [Saudade](https://www.joeyengmusic.com/shop/p/saudade-for-solo-marimba-5-oct)
  5-octave marimba solo
  [[video](https://www.youtube.com/watch?v=1AJPM_rIvMQ)]
