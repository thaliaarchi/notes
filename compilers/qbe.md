# QBE

- [Homepage](https://c9x.me/compile/)
- [Source](https://c9x.me/git/qbe.git) (`git clone git://c9x.me/qbe.git`)
  - QBE-1.0 release candidate
    [[2022-03-15](https://lists.sr.ht/~mpu/qbe/%3C51390118-2d77-4f40-90d5-b5986066ea4a%40www.fastmail.com%3E)]
    [[2022-05-13](https://lists.sr.ht/~mpu/qbe/%3Cb9b47bd5-f9c0-450d-9e7d-be6bb8487de1%40www.fastmail.com%3E)]
- [Mailing list](https://lists.sr.ht/~mpu/qbe)

Documentation:
- [QBE Intermediate Language](https://c9x.me/compile/doc/il.html): the reference
  document for QBE IL
- [QBE vs LLVM](https://c9x.me/compile/doc/llvm.html)
  [[HN](https://news.ycombinator.com/item?id=25273907)]: short comparison with
  LLVM
- [Resources for Amateur Compiler Writers](https://c9x.me/compile/bib/)
  [[HN](https://news.ycombinator.com/item?id=26925314)]:
  bibliography useful to understand and hack QBE
- [System V ABI AMD64](https://c9x.me/compile/doc/abi.html): simple description
  of the UNIX x64 ABI used in QBE

Compilers using QBE:
- [cproc](https://sr.ht/~mcf/cproc/)
  [[HN](https://news.ycombinator.com/item?id=28242024)]: C11 compiler written in
  C11 that can bootstrap GCC
  [[2021-07-21](https://lists.sr.ht/~mpu/qbe/%3C9bc92d80404aaf8f%40c9x.me%3E)]
- [Hare](https://harelang.org/): systems programming language
- [Antimony](https://github.com/antimony-lang/antimony): simplistic programming
  language
- [SCC - Simple C Compiler](https://www.simple-cc.org/): C99 compiler
- [qc - Quick C](https://github.com/andrewchambers/qc): C compiler in Myrddin
- [qmbfc](https://github.com/andrewchambers/qmbfc): Brainfuck compiler in
  Myrddin with QBE and LLVM backends
- [Myrddin](http://myrlang.org/): ongoing work to use QBE

Related projects:
- [PACC - PAscal C Compiler](https://github.com/BeRo1985/pacc): IR design
  inspired by QBE
- [sambe](https://github.com/samrat/sambe): backend for x86-64 with QBE IR as
  input
- [QBN - Quick Backend New](https://github.com/ssmid/qbn): backend inspired by
  QBE with similar IR

Tutorials:
- [Hello World](https://c9x.me/compile/): example program that calls `printf`
- [bf.ssa: Let's get hands-on with QBE](https://briancallahan.net/blog/20210829.html)
  [[code](https://github.com/ibara/bf.ssa)]:
  building a Brainfuck compiler in QBE IL
- minic [[code](https://c9x.me/git/qbe.git/tree/minic)]: simplified C frontend

Libraries:
- QBE IL (textual):
  - [qbe-rs](https://github.com/garritfra/qbe-rs) (Rust): generate
    [[2022-02-09](https://lists.sr.ht/~mpu/qbe/%3CD0E48364-DAB4-4ED8-B5E9-459C4301D61C%40slashdev.space%3E)]
  - [qbe-sml](https://github.com/pauloue/qbe-sml) (Standard ML): generate/parse
    [[2022-02-15](https://lists.sr.ht/~mpu/qbe/%3CCA%2B4P7duKN3aUm4AWzyFsPbHYYAQ-pu89u1dRCc20Ngsd-QTRFw%40mail.gmail.com%3E)]
- [qbe.vim](https://github.com/perillo/qbe.vim): syntax highlighting
  [[2022-04-30](https://lists.sr.ht/~mpu/qbe/%3CCAAToxAFoU6JnjtR0dYGApuS3bPf%3DVvoNv6Cb2xOrcnVKCpgKmQ%40mail.gmail.com%3E)]

Misc:
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
