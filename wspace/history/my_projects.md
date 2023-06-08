# My Whitespace projects

- [hello-world.ws](https://github.com/thaliaarchi/respace/blob/master/programs/hello-world.ws):
  Learn Whitespace language
- [Respace](https://github.com/thaliaarchi/respace): Learn lexing, parsing, and
  buffered IO; pack with Huffman coding
- Spacebar: Abandoned redesign of Respace
- Datalog: Learn graph optimizing and profiling
- [Nebula](https://github.com/thaliaarchi/nebula): Learn static
  single-assignment form, IR design, LLVM IR, peephole optimization, and dead
  code elimination
- [The Whitespace Corpus](https://github.com/wspace/corpus): Evaluate and
  catalog Whitespace community
- [wsjq](https://github.com/thaliaarchi/wsjq): Learn jq advanced features
- [lazy-wspace](https://github.com/thaliaarchi/lazy-wspace): Model lazy
  semantics of Whitespace

## Next

- Written in Rust
- wspls language server
  - Inline values for instruction names that are preserved while editing
  - Debugging
- wsvs VS Code extension
  - Syntax highlighting
  - Render whitespace characters
  - Disassembly panel
- wsasm assembler
  - Support all dialects
  - Macros like Whitelips and others
  - Support constant or address arguments like WhitespaceAssembler
  - Linting
    - Warn on usage of multiple mnemonic for same instruction
    - Warn on inconsistent mnemonics between corresponding IO instructions
    - Warn on inconsistent mnemonic capitalization
- wsdisasm disassembler
  - Format according to dialect definition
  - Automatically collapse constant or address arguments
  - Format constants in ASCII range as chars
- wspack compresser
  - wsx-format compression and decompression
- wspace interpreter
  - File execution
  - Whitespace Assembly REPL
