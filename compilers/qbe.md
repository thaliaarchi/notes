# QBE

- [Homepage](https://c9x.me/compile/)
- [Source](https://c9x.me/git/qbe.git) (`git clone git://c9x.me/qbe.git`)
- [Mailing list](https://lists.sr.ht/~mpu/qbe)

## [Releases](https://c9x.me/compile/releases.html)

- 1.1
  [[git](https://c9x.me/git/qbe.git/tag/?h=v1.1)]
  [[tar.xz](https://c9x.me/compile/release/qbe-1.1.tar.xz)]
  [[2023-02-01](https://lists.sr.ht/~mpu/qbe/%3Cac12002d-d33a-4324-842c-faa2f7977993%40app.fastmail.com%3E)]
- 1.1 release candidate
  [[2022-12-15](https://lists.sr.ht/~mpu/qbe/%3Ce5ffcde5-937d-4717-8c19-bda3741e8dcf%40app.fastmail.com%3E)]
- 1.0
  [[git](https://c9x.me/git/qbe.git/tag/?h=v1.0)]
  [[tar.xz](https://c9x.me/compile/release/qbe-1.0.tar.xz)]
  [[2022-06-22](https://lists.sr.ht/~mpu/qbe/%3Cca09d158-25a3-4592-b9a2-4b013e4571b5%40www.fastmail.com%3E)]
- 1.0 release candidate
  [[git](https://c9x.me/git/qbe.git/commit/?id=9a3e131cf713f8619705f906caf28c5809708ad0)]
  [[2022-05-13](https://lists.sr.ht/~mpu/qbe/%3Cb9b47bd5-f9c0-450d-9e7d-be6bb8487de1%40www.fastmail.com%3E)]
- 1.0 release candidate
  [[git](https://c9x.me/git/qbe.git/commit/?id=cec9855fa0c8d9566d4c9755ef7677f49634bc60)]
  [[2022-03-15](https://lists.sr.ht/~mpu/qbe/%3C51390118-2d77-4f40-90d5-b5986066ea4a%40www.fastmail.com%3E)]
- Homebrew (`brew install qbe`)
  [[2022-06-25](https://lists.sr.ht/~mpu/qbe/%3CD1B8B993-3705-41DE-9CC2-34AEC4201E7E%40slashdev.space%3E)]

## Documentation

- [QBE Intermediate Language](https://c9x.me/compile/doc/il.html): the reference
  document for QBE IL
- [QBE vs LLVM](https://c9x.me/compile/doc/llvm.html): short comparison with
  LLVM [[HN](https://news.ycombinator.com/item?id=25273907)]
- [Resources for Amateur Compiler Writers](https://c9x.me/compile/bib/):
  bibliography useful to understand and hack QBE [[HN](https://news.ycombinator.com/item?id=26925314)]
- [System V ABI AMD64](https://c9x.me/compile/doc/abi.html): simple description
  of the UNIX x64 ABI used in QBE

## Language frontends

- [cproc](https://sr.ht/~mcf/cproc/): C11 compiler written in C11 that can
  bootstrap GCC [[HN](https://news.ycombinator.com/item?id=28242024)]
  [[2021-07-21](https://lists.sr.ht/~mpu/qbe/%3C9bc92d80404aaf8f%40c9x.me%3E)]
- [Hare](https://harelang.org/): systems programming language
- [Antimony](https://github.com/antimony-lang/antimony): simplistic programming
  language
- [SCC - Simple C Compiler](https://www.simple-cc.org/): C99 compiler
- [qc - Quick C](https://github.com/andrewchambers/qc): C compiler in Myrddin
- [qmbfc](https://github.com/andrewchambers/qmbfc): Brainfuck compiler in
  Myrddin with QBE and LLVM backends
- [Myrddin](http://myrlang.org/): ongoing work to use QBE

## Related projects

- [PACC - PAscal C Compiler](https://github.com/BeRo1985/pacc): IR design
  inspired by QBE
- [sambe](https://github.com/samrat/sambe): backend for x86-64 with QBE IR as
  input
- [QBN - Quick Backend New](https://github.com/ssmid/qbn): backend inspired by
  QBE with similar IR

## Tutorials

- [Hello World](https://c9x.me/compile/): example program that calls `printf`
- [bf.ssa: Let's get hands-on with QBE](https://briancallahan.net/blog/20210829.html):
  building a Brainfuck compiler in QBE IL [[code](https://github.com/ibara/bf.ssa)]
- [minic](https://c9x.me/git/qbe.git/tree/minic): simplified C frontend

## QBE IL libraries

- [qbe-rs](https://github.com/garritfra/qbe-rs) (Rust): generate
  [[2022-02-09](https://lists.sr.ht/~mpu/qbe/%3CD0E48364-DAB4-4ED8-B5E9-459C4301D61C%40slashdev.space%3E)]
- [qbe-sml](https://github.com/pauloue/qbe-sml) (Standard ML): generate/parse
  [[2022-02-15](https://lists.sr.ht/~mpu/qbe/%3CCA%2B4P7duKN3aUm4AWzyFsPbHYYAQ-pu89u1dRCc20Ngsd-QTRFw%40mail.gmail.com%3E)]
- [qbe-hs](https://git.sr.ht/~fgaz/qbe-hs) (Haskell): generate
  [[Hackage](https://hackage.haskell.org/package/qbe)]
  [[2022-07-13](https://lists.sr.ht/~mpu/qbe/%3C20220713122507.25e8f86f%40phi%3E)]
- [qbe.vim](https://github.com/perillo/qbe.vim) (Vim): syntax highlighting
  [[2022-04-30](https://lists.sr.ht/~mpu/qbe/%3CCAAToxAFoU6JnjtR0dYGApuS3bPf%3DVvoNv6Cb2xOrcnVKCpgKmQ%40mail.gmail.com%3E)]
- [hare-qbe](https://git.d2evs.net/~evan/hare-qbe) (Hare): generate/parse
  [[2023-03-26](https://lists.sr.ht/~mpu/qbe/%3CCRGOKEO864HW.2FS5Z224N0ORK%40kipisi%3E)]

## Misc

- Library interface is not being actively worked on
  [[2022-02-08](https://lists.sr.ht/~mpu/qbe/%3CYgHOXpjABvAaMvMt%40debussy%3E)]
- QBE is not suitable for implementing a JIT
  [[2022-02-20](https://lists.sr.ht/~mpu/qbe/%3CCAFbATBGDOmpxDoVD9eAudiqAMAFskD-sMeyOn5jz63iNeWYK0g%40mail.gmail.com%3E)]
- QBE initialism
  [[2022-03-19](https://lists.sr.ht/~mpu/qbe/%3C407F27D6-F9A9-40EA-B390-72AC7F8F2608%40aarchibald.com%3E)]
- Compiling aggregate types
  [[2022-04-11](https://lists.sr.ht/~mpu/qbe/%3CCAAS8gYCGQLSc3qpc4_1CjTb5eL11RRoXJ2RD0fNZCgsrW7TvSg%40mail.gmail.com%3E)]
- Hare's wishlist for qbe
  [[2022-05-16](https://lists.sr.ht/~mpu/qbe/%3CCK12HKZG9X8T.2I2C6VZPATL9X%40taiga%3E)]
- Line number info tracking (proposed)
  [[2023-01-26](https://lists.sr.ht/~mpu/qbe/patches/38465)]
