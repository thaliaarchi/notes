# Unexpectedly Turing-complete

Various subsets programming languages or systems that are unintentionally
Turing-complete.

## Subsets of programming languages

- C variable-length arrays: A subset of C99, “disembodied C”, with only VLA
  length expressions and functions with empty bodies, parameters, and forward
  declarations.
  - [MD5, SHA-256, and Conway’s Game of Life](https://lemon.rip/w/c99-vla-tricks/)
    by lemon (2022)
- C++ templates: A subset of C++ with only templates, template specialization,
  `struct`, `typename`, and `typedef`.
  - [“Impact of Economics on Compiler Optimization”](https://sci-hub.se/10.1145/376656.376751)
    by Arch D. Robison (2001), in section 4, frames C++ templates as a
    compile-time optimization in, provides a tree sum example, and compares it
    to functional programming:

    > Template metaprograms are programs that run at compilation time. When the
    > ISO C++ committee added templates to C++, the following features were
    > required:
    > - Instantiation of member types (and member constants of integral type) is
    >   demand driven.
    > - Template identifiers may be overloaded, with resolution based on pattern
    >   matching.
    > - Templates may be recursive.
    >
    > The list above makes obvious to functional programmers what the committee
    > did not realize until later: templates are a functional language,
    > evaluated at compilation time.

  - [λ-calculus](https://matt.might.net/articles/c++-template-meta-programming-with-lambda-calculus/)
    by Matt Might (2009)
  - [4-bit adder](https://github.com/AaronBallman/adder)
    by Aaron Ballman (2013)
- Coq typeclass resolver: Typeclass instance resolution is an unrestricted proof
  search. Notably, Coq's type system is Turing-complete, but it's language is
  not—the opposite of typical.
  - [Smallfuck](https://thaliaarchi.github.io/coq-turing-typeclass/)
    by Thalia Archibald (2023)
    [[code](https://github.com/thaliaarchi/coq-turing-typeclass)]
    [[HN](https://news.ycombinator.com/item?id=35591529)]
- Haskell type system: A subset of Haskell with multi-parameter typeclasses,
  functional dependencies, and undecidable instances.
  - [Turing machine](https://www.lochan.org/keith/publications/undec.html)
    by Keith Wansbrough (1998)
  - [SK combinator calculus](https://wiki.haskell.org/Type_SK)
    by Rob Dockins (2006)
  - [Typing the technical interview](https://aphyr.com/posts/342-typing-the-technical-interview):
    N-queens problem by Kyle Kingsbury (2017)
- Java generics: A subset of Java with subtype checking.
  - Turing machine and a parser generator for fluent interfaces in
    [“Java Generics are Turing Complete”](https://arxiv.org/abs/1605.05274)
    by Radu Grigore (2016)
- POSIX `printf`: A single call to POSIX `printf` in a loop.
  - Introduced in [“Control-Flow Bending: On the Effectiveness of Control-Flow
    Integrity”](https://nebelwelt.net/publications/#15SEC)
    by Nicholas Carlini, Antonio Barresi, Mathias Payer, David Wagner, and
    Thomas R. Gross (2015)
  - [Brainfuck](https://github.com/HexHive/printbf)
    by Mathias Payer and Nicholas Carlini (2015)
  - [Tic-tac-toe](https://github.com/carlini/printf-tac-toe)
    by Nicholas Carlini (2020)
- PostgreSQL: Uses common table expressions (CTEs) and windowing.
  - [Cyclic tag system](https://wiki.postgresql.org/wiki/Cyclic_Tag_System)
    by Andrew Gierth (2009)
  - [Mandelbrot set](https://wiki.postgresql.org/wiki/Mandelbrot_set)
    by Peter Eisentraut (2009)
  - [Presentation](https://web.archive.org/web/20201111224603/http://assets.en.oreilly.com/1/event/27/High%20Performance%20SQL%20with%20PostgreSQL%20Presentation.pdf)
    on cyclic tag system, Mandelbrot set, and travelling salesman problem
    by David Fetter (2009)
  - [Turing machine](https://blog.coelho.net/database/2013/08/17/turing-sql-1.html)
    by Fabien Coelho (2013)
- Rust type system: A subset of Rust with type parameters, traits,
  multi-parameter traits, and associated types.
  - [Turing machine](https://www.reddit.com/r/rust/comments/2o6yp8/comment/cmkrjz2/)
    by comex (2014)
    [[code](https://web.archive.org/web/20141225090046/http://pastie.org/9757227)],
    [updated](https://www.reddit.com/r/rust/comments/5y4x9r/comment/denibgy/)
    (2017)
    [[code](https://web.archive.org/web/20170316010408/https://ghostbin.com/paste/vnjmh)]
  - [Smallfuck](https://sdleffler.github.io/RustTypeSystemTuringComplete/)
    by Shea Leffler (2017)
    [[code](https://github.com/sdleffler/tarpit-rs)]
    [[HN 1](https://news.ycombinator.com/item?id=13843288), [2](https://news.ycombinator.com/item?id=26445332)]
  - [Minsky machine](https://github.com/paholg/minsky/)
    by Paho Lurie-Gregg (2017)
  - [Type System Chess](https://github.com/Dragon-Hatcher/type-system-chess)
    by Daniel James (2023), which spurred [improvements](https://github.com/rust-lang/rust/pull/114611)
    to rustc [[post](https://nnethercote.github.io/2023/08/25/how-to-speed-up-the-rust-compiler-in-august-2023.html#my-improvements)]
- Rust `macros_rules!` and traits
  - [fortraith](https://github.com/Ashymad/fortraith): compile-time Forth
    compiler by Szymon Mikulicz (2020)
    [[HN](https://news.ycombinator.com/item?id=23501474)]
- Transact-SQL
  - [Brainfuck](https://stackoverflow.com/questions/900055/is-sql-or-even-tsql-turing-complete/34847489#34847489)
    by Miroslav Popov (2016)
    [[code](https://github.com/PopovMP/BrainFuck-SQL)]
- TypeScript type system
  - [Turing machine and primality test](https://github.com/microsoft/TypeScript/issues/14833)
    by Henning Dieterichs (2017)
    [[code](https://gist.github.com/hediet/63f4844acf5ac330804801084f87a6d4)]
    [[HN](https://news.ycombinator.com/item?id=14905043)]
  - [Meta-Typing](https://github.com/ronami/meta-typing): many math, list,
    sorting, and puzzle functions and algorithms at type-level
    by Ronen Amiel (2020)
    [[HN](https://news.ycombinator.com/item?id=36595512)]
  - [Smallfuck](https://itnext.io/typescript-and-turing-completeness-ba8ded8f3de3)
    by Ryan Dabler (2021)
    [[code](https://gist.github.com/ryandabler/fd7884cb9072e66717d9f5d4b23bd5e8)]
  - [ts-calc](https://github.com/ecyrbe/ts-calc): integer arithmetic implemented
    at type-level as string operations in decimal with table digit lookups
    by ecyrbe (2022)
  - [Typescripting the technical interview](https://www.richard-towers.com/2023/03/11/typescripting-the-technical-interview.html):
    N-queens problem by Richard Towers (2023)
    [[HN](https://news.ycombinator.com/item?id=35120084)]
  - [Type Challenges](https://github.com/type-challenges/type-challenges)
    by Anthony Fu (2020)
  - [Type System Chess](https://github.com/Dragon-Hatcher/type-system-chess)
    by Daniel James (2023)
  - [Flappy Bird](https://zackoverflow.dev/writing/flappy-bird-in-type-level-typescript/)
    by Zack Radisic (2023) parses the types in Rust to emit a bytecode, which is
    evaluated by a VM in Zig
- x86 MMU fault handling
  - [trapcc](https://github.com/jbangert/trapcc): subleq compiler
    by Julian Bangert (2013)
    [[video](https://www.youtube.com/watch?v=eSRcvrVs5ug)]
    [[slides](https://github.com/jbangert/trapcc/blob/master/slides/PFLA-shmoocon.pdf)]
    [[HN](https://news.ycombinator.com/item?id=5261598)]
- x86 `mov`: Only the `mov` instruction of x86.
  - [“`mov` is Turing-complete”](https://web.archive.org/web/20130924014250/http://www.cl.cam.ac.uk/~sd601/papers/mov.pdf):
    Turing machine by Stephen Dolan (2013)
  - [M/o/Vfuscator compiler](https://github.com/xoreaxeaxeax/movfuscator)
    by Chris Domas (2015), with numerous programs, including [DOOM](https://github.com/xoreaxeaxeax/movfuscator/tree/master/validation/doom)
    [[talk](https://www.youtube.com/watch?v=2VF_wPkiBJY)]

## Automata

- [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
  - [Turing machine](http://rendell-attic.org/gol/tm.htm)
    by Paul Rendell (2000)
  - [Tetris](https://codegolf.stackexchange.com/questions/11880/build-a-working-game-of-tetris-in-conways-game-of-life)
    by PhiNotPi, El'endia Starman, K Zhang, Blue (Muddyfish), Cows quack
    (Kritixi Lithos), Mego, and Quartata (2017)
- [Rule 110](https://en.wikipedia.org/wiki/Rule_110)
  - Cyclic tag system in [“Universality in Elementary Cellular Automata”](https://wpmedia.wolfram.com/uploads/sites/13/2018/02/15-1-1.pdf)
    by Matthew Cook (2004)
  - P-completeness in [“P-completeness of cellular automaton Rule 110”](https://link.springer.com/chapter/10.1007/11786986_13)
    by Turlough Neary and Damien Woods (2006)
    [[preprint](http://services.ini.uzh.ch/~tneary/NearyWoodsBCRI-04-06.pdf)]

## File formats

- OpenType fonts
  - [Addition](https://litherum.blogspot.com/2019/03/addition-font.html)
    by Litherum (2019)

## Games

- Doom
  - [counter.wad](https://www.doomworld.com/idgames/levels/doom2/Ports/a-c/counter)
    by fraggle (2006) is an in-game 4-bit binary ripple carry adder circuit
    using voodoo dolls and conveyor belts [[video](https://www.youtube.com/watch?v=pvji3DJNnqE)].
  - [Half-adder](https://calabi-yau.space/blog/doom.html)
    by Jared Candelaria (2021) is an in-game half-adder circuit using lifts and
    teleporters [[video](https://www.youtube.com/watch?v=qB9R3L5FZ3Q)].
  - [Doom-in-Doom](https://www.youtube.com/watch?v=c6hnQ1RKhbo)
    by kgsws (2022) uses a code execution exploit to run Chocolate Doom in Doom
    2 on DOS [[code](https://github.com/kgsws/doom-in-doom)].
  - [conway.wad](https://www.doomworld.com/forum/topic/131881-conways-game-of-life-in-boom/)
    by Piotr Wieczore (2022) is an in-game simulator for Conway's Game of Life,
    using scrollers, teleporters and floor movement [[code](https://github.com/pwiecz/conway.wad)].
  - [Adding Machine](https://blog.otterstack.com/posts/202212-doom-calculator/)
    by Danny Spencer (2022) is an in-game calculator that adds 2-digit decimal
    numbers with a display, using a BDD encoding of logic as monsters, doors,
    teleporters, and switches [[code](https://github.com/nukep/doom-calculator)].
- Dwarf Fortress
- Magic: The Gathering
  - [Magic Turing Machine](https://www.toothycat.net/~hologram/Turing/)
    by Alex Churchill (2012) embeds a Turing machine in Magic, Wolfram's (2,3)
    universal Turing machine in [versions 1–4](https://www.toothycat.net/~hologram/Turing/Future.html)
    and [Yurii Rogozhin's](https://www.sciencedirect.com/science/article/pii/S0304397596000771)
    (2,18) universal Turing machine in version 5. Cory Doctorow [reported](https://boingboing.net/2012/09/12/magic-the-gathering.html)
    on it.
  - [“Magic: The Gathering is Turing Complete”](https://arxiv.org/abs/1904.09828)
    by Alex Churchill, Stella Biderman, and Austin Herrick (2019) embeds
    Rogozhin's (2,18) universal Turing machine in the game, such that the first
    player is guaranteed to win if and only if the Turing machine halts. Unlike
    the previous designs by the first author, players are not required to make
    particular choices.
  - [I Built a COMPUTER in Magic: The Gathering](https://www.youtube.com/watch?v=pdmODVYPDLA)
    by Because Science (2019) demonstrates the Turing machine of the paper in
    gameplay
- Minecraft
  - [Minecraft in Minecraft](https://www.youtube.com/watch?v=-BP7DhHTU-I)
    by sammyuri, Uwerta, and Stack (2022)
    [[PC Gamer](https://www.pcgamer.com/minecraftception-redstone-pc-chungus/)]
    [[HN](https://news.ycombinator.com/item?id=36716916)]
- Rollercoaster Tycoon
  - [A calculator made from rollercoasters in Rollercoaster Tycoon 2](https://www.youtube.com/watch?v=RQGa0DPwes0)
    by Marcel Vos (2016) is a calculator, which can add and multiply
    single-digit decimal numbers.
- Terraria
  - [Computerraria](https://github.com/misprit7/computerraria): a fully
    compliant 32-bit RISC-V computer
    by Xander Naumenko (2023)
    [[video](https://www.youtube.com/watch?v=zXPiqk0-zDY)]
- Tetris
  - [Tetris in Tetris](https://meatfighter.com/tetromino-computer/)
    by Mike Birken (2023)
    [[HN](https://news.ycombinator.com/item?id=34309725)]

## Other

- Excel
  - [Excel 16-Bit CPU](https://www.youtube.com/watch?v=5rg7xvTJ8SU)
    by Inkbox (2024) is a CPU in Excel with programs compiled from Excel-ASM16
    assembly [[code](https://github.com/InkboxSoftware/excelCPU)]

## Lists

- [Wikipedia: “Unintentional Turing completeness”](https://en.wikipedia.org/wiki/Turing_completeness#Unintentional_Turing_completeness)
- [“Surprisingly Turing-Complete”](https://gwern.net/turing-complete)
  by Gwern Branwen (2012)
- [”Accidentally Turing-Complete”](http://beza1e1.tuxen.de/articles/accidentally_turing_complete.html)
  by Andreas Zwinkau (2021)
- [“Java Generics are Turing Complete”](https://arxiv.org/abs/1605.05274)
  by Radu Grigore (2016) mentions several other undecidable type systems in
  section 9 Related Work

## Not Turing-complete

- [Idris type system](https://cs.stackexchange.com/questions/19577/what-can-idris-not-do-by-giving-up-turing-completeness/23916#23916)
  (but Idris functions need not be total, i.e., are Turing complete)
