# An interoperable CST for Whitespace assembly

## Overview

The reference parsers are very ad hoc and tokens are often parsed
inconsistently, so the lexer is driven by the parser in varying contexts. The
semantics of tokens varies by context, so they cannot be simply mapped
individually between dialects in a stream and more structure is needed. Syntax
can be nested (e.g., `ifoption`), so a tree structure is needed. Whitespace and
comment trivia tokens are represented explicitly, directly in the slots they can
appear in each node.

## Tokens

Token kinds:
- Mnemonic
- Integer
- Character
- String
- Identifier
- Instruction separator
- Argument separator
- Whitespace
- Line terminator
- Comment
- Spliced token (a token interspersed with block comments; Burghard)
- Ignored text (a sequence ignored due to a bug; e.g., voliva ignored arguments)
- Error

## Syntax

A concrete syntax tree with nodes for syntactic units, organized by shape.

Node kinds:
- Dialect marker (for mixing dialects)
- Arguments as in Whitespace
  - 0 arguments
  - 1 argument
- Optional arguments
  - 1 argument
  - 2 arguments
- Macros
  - Whitelips
  - Respace
  - Lime Whitespace
- Macro invocation
- Symbol definition
- Option blocks
  - If
  - Else if
  - Else
- Conditionally ignored block (suppress syntax errors)
