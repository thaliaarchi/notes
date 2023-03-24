# Unexpectedly Turing-complete

Various subsets programming languages or systems that are unintentionally
Turing-complete.

## Subsets of programming languages

- C99 variable-length arrays: A subset of C99, “disembodied C”, with only VLA
  length expressions and functions with empty bodies, parameters, and forward
  declarations.
  - [MD5, SHA-256, and Conway’s Game of Life](https://lemon.rip/w/c99-vla-tricks/)
    by lemon (2022)
- C++ templates: A subset of C++ with only templates, template specialization,
  `struct`, `typename`, and `typedef`.
  - [λ-calculus](https://matt.might.net/articles/c++-template-meta-programming-with-lambda-calculus/)
    by Matt Might (2009)
  - [4-bit adder](https://github.com/AaronBallman/adder) by Aaron Ballman (2013)
- Haskell type system: A subset of Haskell with multi-parameter typeclasses,
  functional dependencies, and undecidable instances.
  - [Turing machine](https://www.lochan.org/keith/publications/undec.html) by
    Keith Wansbrough (1998)
  - [SK combinator calculus](https://wiki.haskell.org/Type_SK) by Rob Dockins
    (2006)
  - [N-queens problem](https://aphyr.com/posts/342-typing-the-technical-interview)
    by Kyle Kingsbury (2017)
- Java generics: A subset of Java with subtype checking.
  - Turing machine and a parser generator for fluent interfaces in
    [“Java Generics are Turing Complete”](https://arxiv.org/abs/1605.05274) by
    Radu Grigore (2016)
- POSIX `printf`: A single call to POSIX `printf` in a loop.
  - Introduced in [“Control-Flow Bending: On the Effectiveness of Control-Flow
    Integrity”](https://nebelwelt.net/publications/#15SEC) by Nicholas Carlini,
    Antonio Barresi, Mathias Payer, David Wagner, and Thomas R. Gross (2015)
  - [Brainfuck](https://github.com/HexHive/printbf) by Mathias Payer and
    Nicholas Carlini (2015)
  - [Tic-tac-toe](https://github.com/carlini/printf-tac-toe) by Nicholas Carlini
    (2020)
- TypeScript type system
  - [Turing machine and primality test](https://github.com/microsoft/TypeScript/issues/14833)
    [[code](https://gist.github.com/hediet/63f4844acf5ac330804801084f87a6d4)]
    [[HN](https://news.ycombinator.com/item?id=14905043)] by Henning Dieterichs
    (2017)
  - [Smallfuck](https://itnext.io/typescript-and-turing-completeness-ba8ded8f3de3)
    [[code](https://gist.github.com/ryandabler/fd7884cb9072e66717d9f5d4b23bd5e8)]
    by Ryan Dabler (2021)
- Rust type system: A subset of Rust with type parameters, traits,
  multi-parameter traits, and associated types.
  - [Turing machine](https://www.reddit.com/r/rust/comments/2o6yp8/comment/cmkrjz2/)
    [[code](https://web.archive.org/web/20141225090046/http://pastie.org/9757227)]
    by comex (2014); [updated](https://www.reddit.com/r/rust/comments/5y4x9r/comment/denibgy/)
    [[code](https://web.archive.org/web/20170316010408/https://ghostbin.com/paste/vnjmh)]
    (2017)
  - [Smallfuck](https://sdleffler.github.io/RustTypeSystemTuringComplete/)
    [[code](https://github.com/sdleffler/tarpit-rs)]
    [[HN 1](https://news.ycombinator.com/item?id=13843288), [2](https://news.ycombinator.com/item?id=26445332)]
    by Shea Leffler (2017)
  - [Minsky machine](https://github.com/paholg/minsky/) by Paho Lurie-Gregg
    (2017)
- x86 `mov`: Only the `mov` instruction of x86.
  - Turing machine in [“`mov` is Turing-complete”](https://web.archive.org/web/20130924014250/http://www.cl.cam.ac.uk/~sd601/papers/mov.pdf)
    by Stephen Dolan (2013)
  - [M/o/Vfuscator compiler](https://github.com/xoreaxeaxeax/movfuscator) by
    Chris Domas (2015), with numerous programs, including [DOOM](https://github.com/xoreaxeaxeax/movfuscator/tree/master/validation/doom)

## Other

- Conway's Game of Life
  - [Tetris](https://codegolf.stackexchange.com/questions/11880/build-a-working-game-of-tetris-in-conways-game-of-life)
    by PhiNotPi, El'endia Starman, K Zhang, Blue (Muddyfish), Cows quack
    (Kritixi Lithos), Mego, and Quartata (2017)
- OpenType font files
  - [Addition](https://litherum.blogspot.com/2019/03/addition-font.html) by
    Litherum (2019)
- Tetris
  - [Tetris in Tetris](https://meatfighter.com/tetromino-computer/)
    [[HN](https://news.ycombinator.com/item?id=34309725)]
    by Mike Birken (2023)

## Lists

- [Wikipedia: “Unintentional Turing completeness”](https://en.wikipedia.org/wiki/Turing_completeness#Unintentional_Turing_completeness)
- [“Surprisingly Turing-Complete”](https://gwern.net/turing-complete) (2012)
- [”Accidentally Turing-Complete”](http://beza1e1.tuxen.de/articles/accidentally_turing_complete.html)
  by Andreas Zwinkau (2021)
- [“Java Generics are Turing Complete”](https://arxiv.org/abs/1605.05274) by
  Radu Grigore (2016) mentions several other undecidable type systems in §9 Related
  Work

## Not Turing-complete

- [Idris type system](https://cs.stackexchange.com/questions/19577/what-can-idris-not-do-by-giving-up-turing-completeness/23916#23916)
  (but Idris functions need not be total, i.e., are Turing complete)