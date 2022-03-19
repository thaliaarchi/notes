# QBE

- [Homepage](https://c9x.me/compile/)
- [Source](https://c9x.me/git/qbe.git)
  (`git clone git://c9x.me/qbe.git`)
- [Mailing list](https://lists.sr.ht/~mpu/qbe)

Compilers using QBE:
- [cproc](https://sr.ht/~mcf/cproc/): C11 compiler
- [Hare](https://harelang.org/)
- [Antimony](https://github.com/antimony-lang/antimony)
- [SCC - Simple C Compiler](https://www.simple-cc.org/): C99 compiler
- [qc - Quick C](https://github.com/andrewchambers/qc): C compiler in
  Myrddin
- [qmbfc](https://github.com/andrewchambers/qmbfc): Brainfuck compiler
  in Myrddin with QBE and LLVM backends
- [Myrddin](http://myrlang.org/): ongoing work to use QBE

Related projects:
- [PACC - PAscal C Compiler](https://github.com/BeRo1985/pacc): IR
  design inspired by QBE
- [sambe](https://github.com/samrat/sambe): backend for x86-64 with QBE
  IR as input
- [QBN - Quick Backend New](https://github.com/ssmid/qbn): backend
  inspired by QBE with similar IR

Libraries:
- QBE IL (textual):
  - [qbe-rs](https://github.com/garritfra/qbe-rs) (Rust): generate [[1]]
  - [qbe-sml](https://github.com/pauloue/qbe-sml) (Standard ML):
    generate/parse [[2]]
- Library interface: not being actively worked on [[3]]

Not suitable as JIT [[4]]

[Release 1.0 candidate](https://lists.sr.ht/~mpu/qbe/%3C51390118-2d77-4f40-90d5-b5986066ea4a%40www.fastmail.com%3E)

[Initialism](https://lists.sr.ht/~mpu/qbe/%3C407F27D6-F9A9-40EA-B390-72AC7F8F2608%40aarchibald.com%3E)

[1]: https://lists.sr.ht/~mpu/qbe/%3CD0E48364-DAB4-4ED8-B5E9-459C4301D61C%40slashdev.space%3E
[2]: https://lists.sr.ht/~mpu/qbe/%3CCA%2B4P7duKN3aUm4AWzyFsPbHYYAQ-pu89u1dRCc20Ngsd-QTRFw%40mail.gmail.com%3E
[3]: https://lists.sr.ht/~mpu/qbe/%3CYgHOXpjABvAaMvMt%40debussy%3E
[4]: https://lists.sr.ht/~mpu/qbe/%3CCAFbATBGDOmpxDoVD9eAudiqAMAFskD-sMeyOn5jz63iNeWYK0g%40mail.gmail.com%3E
