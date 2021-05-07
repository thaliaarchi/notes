# My Whitespace projects

- hello-world.ws - Learn Whitespace language
- Respace - Learn lexing, parsing, and buffered IO; pack with Huffman coding
- Spacebar - Abandoned redesign of Respace
- Datalog - Learn graph optimizing and profiling
- Nebula - Learn static single assignment form, IR design, LLVM IR, peephole optimization, dead code elimination
- ws-corpus - Evaluate Whitespace community
- wsjq - Learn jq advanced features

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
    - Warn on inconsistent mnemonics between corresponding (read|print)[ic]
    - Warn on inconsistent mnemonic capitalization
- wsdisasm disassembler
  - Format according to dialect definition
  - Automatically collapse constant or address arguments
  - Format constants in ASCII range as chars
- wspack compresser
  - wsx-format compression and decompression
