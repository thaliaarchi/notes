# Loose threads

## Projects

- Computing history
  - Plan 9
    - Plan 9 [kernel sources](https://9p.io/sources/extra/9hist/) have a version
      history using per-file deltas with ed scripts
    - The source tree was snapshotted daily and archived with the [Venti](https://9p.io/sys/doc/venti/venti.html)
      network storage system
  - Pre-Git Linux kernel
    - [Initial Git commit](https://github.com/torvalds/linux/commit/1da177e4c3f41524e886b7f1b8a0c1fc7321cac2):
      Linux 2.6.12-rc2.
    - [git-history-of-linux](https://archive.org/details/git-history-of-linux):
      grafted history of Linux 0.01 to 2.6, which combines repos from Dave Jones
      (0.01 to 2.4.0), tglx (2.4.0 to 2.6.12), and Linus Torvalds (2.6.12 to
      2.6), prepared by Yoann Padioleau, and uploaded to IA by Jason Scott.
      [[discussion](https://news.ycombinator.com/item?id=39951375)]
    - [linux-bitkeeper](https://github.com/dmgerman/linux-bitkeeper):
      Linux 2.4.0 through 2.6.12-rc2.
      It starts with an import of 2.4.0 through 2.5.3 on 2002-02-04 and
      development afterwards uses BitKeeper.
    - [linux-pre-history](https://github.com/dmgerman/linux-pre-history):
      Linux 0.01 through 2.4.0.
      Commits authored by linus1 \<torvalds@linuxfoundation.org> from 1991-09-17 to 2000-12-31
      and committed by Linus Torvalds \<torvalds@linuxfoundation.org> on 2007-11-23,
      with a strange commit by pad \<yoann.padioleau@facebook.com> in 2010.
  - JavaScript 1.0
    - [doodlewind/mocha1995](https://github.com/doodlewind/mocha1995) extracts
      Mocha from the same archive as I am doing. It is done by the Chinese
      translator of “JavaScript: The First 20 Years”.
    - I think JavaScript was originally distributed as JSRef (JavaScript
      reference) before SpiderMonkey. Rhino [refers to it](https://web.mit.edu/javascript/arch/i386_rh9/build/README.html).
      Maybe I could find a pre-Netscape 3.02 version. However, this [source tree](https://github.com/zii/netscape/tree/master/js/ref)
      for Netscape, has JSRef and appears to be after Mocha.
    - [Rhino](https://web.mit.edu/javascript/doc/rhino/index.html) is an
      implementation of JavaScript in Java, from [fall 1997](https://web.mit.edu/javascript/doc/rhino/history.html),
      when a version of Netscape entirely in Java was in the works
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
  - Notes inspiration
    - [Philip Zucker](https://www.philipzucker.com/notes/) [[git](https://github.com/philzook58/philzook58.github.io)]
    - [Andy Matuschak](https://notes.andymatuschak.org/About_these_notes)
    - [Nikita Voloboev](https://wiki.nikiv.dev/) [[git](https://github.com/nikitavoloboev/knowledge)]
- Forge
  - [Software Forge Performance Index](https://forgeperf.org/)
- Contributing to egglog
  - Interesting issues: [Egglog interface from rust](https://github.com/egraphs-good/egglog/issues/232)

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
- Formal methods
  - [Programming Z3](https://theory.stanford.edu/~nikolaj/programmingz3.html)
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
- Computability
  - [Eigenratio](https://esolangs.org/wiki/Eigenratio)
    - [Eigenratios of Self-Interpreters](https://eigenratios.blogspot.com/)
  - [Wolfram's (2,3) Turing machine](https://en.wikipedia.org/wiki/Wolfram%27s_2-state_3-symbol_Turing_machine)
  - [Bitwise Cyclic Tag](https://esolangs.org/wiki/Bitwise_Cyclic_Tag)
  - [Beaver](https://github.com/eterevsky/beaver): a solver in Rust to find
    the shortest Brainfuck program for which termination cannot be determined
    and the longest-running terminating programs for various lengths
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
  - [Gxhash](https://github.com/ogxd/gxhash): fast non-cryptograph hashing
    algorithm
  - [insta](https://github.com/mitsuhiko/insta): snapshot testing
  - [self_cell](https://github.com/Voultapher/self_cell): self-referential
    structs
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
