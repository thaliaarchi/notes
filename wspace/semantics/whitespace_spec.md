# Draft Whitespace language specification

Whitespace is formally specified by its [implementation](https://web.archive.org/web/20150717140342/http://compsoc.dur.ac.uk/whitespace/download.php),
not by a language reference. This document attempts to fill in gaps from the
[tutorial](https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php)
with details from testing the reference interpreter and to compare
[various implementations](https://github.com/wspace/corpus).

## Tokens

The only tokens in the Whitespace language are space (U+0020), tab (U+0009), and
line feed (U+000A), represented hereafter as S, T, and L, respectively. All
other characters are considered comments and must be ignored.

### Non-standard mappings

- space U+0020, tab U+0009, line feed U+000A
- `S`, `T`, `L`
- `S`, `T`, `N`
- `S`, `T`, line feed U+000A
- `A`, `B`, `C`

## Types

All values in Whitespace are arbitrary-precision integers.

## Instructions

Instructions are grouped with a shared prefix, called the "instruction
modification parameter" in the tutorial.

| Prefix | Group              |
| ------ | ------------------ |
| S      | Stack manipulation |
| TS     | Arithmetic         |
| TT     | Heap access        |
| L      | Control flow       |
| TL     | I/O                |

| Mnemonic | Syntax | Arg | Stack | Heap | Description |
| -------- | ------ | --- | ----- | ---- | ----------- |
| push     | SS   | n | -- n           | | Push the number onto the stack |
| dup      | SLS  |   | x -- x x       | | Duplicate the top item on the stack |
| copy     | STS  | n | a0 .. an -- a0 .. an a0 | | Copy the *n*th item on the stack (given by the argument) onto the top of the stack |
| swap     | SLT  |   | x y -- y x     | | Swap the top two items on the stack |
| drop     | SLL  |   | x --           | | Discard the top item on the stack |
| slide    | STL  | n | a0 .. an -- an | | Slide *n* items off the stack, keeping the top item |
| add      | TSSS |   | x y -- x+y     | | Addition |
| sub      | TSST |   | x y -- x-y     | | Subtraction |
| mul      | TSSL |   | x y -- x*y     | | Multiplication |
| div      | TSTS |   | x y -- x/y     | | Integer Division |
| mod      | TSTT |   | x y -- x%y     | | Modulo |
| store    | TTS  |   | addr val --    | addr <- val | Store |
| retrieve | TTT  |   | addr -- *addr  | | Retrieve |
| label    | LSS  | l | --             | | Mark a location in the program |
| call     | LST  | l | --             | | Call a subroutine |
| jmp      | LSL  | l | --             | | Jump unconditionally to a label |
| jz       | LTS  | l | cond --        | | Jump to a label if the top of the stack is zero |
| jn       | LTT  | l | cond --        | | Jump to a label if the top of the stack is negative |
| ret      | LTL  |   | --             | | End a subroutine and transfer control back to the caller |
| end      | LLL  |   | --             | | End the program |
| printc   | TLSS |   | char --        | | Output the character at the top of the stack |
| printi   | TLST |   | int --         | | Output the number at the top of the stack |
| readc    | TLTS |   | addr --        | addr <- char | Read a character and place it in the location given by the top of the stack |
| readi    | TLTT |   | addr --        | addr <- int  | Read a number and place it in the location given by the top of the stack |

The instruction prefix encoding is not [self-synchronizing](https://en.wikipedia.org/wiki/Self-synchronizing_code).

The mnemonics used here follow the
[Whitelips](https://vii5ard.github.io/whitespace/)/[Nebula](https://github.com/thaliaarchi/nebula)
convention and are non-normative. Whitespace assembly dialects vary widely
between implementations and are out of scope of this document.

### Non-standard instructions

The instruction prefix tree is not full, so extended instructions may be defined
that are prefixed with STT, TSTL, TSL, TTL, TLSL, TLTL, TLL, LLS, or LLT. As
these are non-standard, few implementations support them and the syntax is
conflicting.

| Mnemonic         | Syntax | Arg | Stack | Heap | Description | Implementation |
| ---------------- | ------ | --- | ----- | ---- | ----------- | -------------- |
| Invert           | STT   |   | a0 .. an -- an .. a0 | | Invert the stack | [whitespacesdk](https://github.com/wspace/mash-whitespacesdk) by MArtin SHerratt |
| Shuffle          | STTS  |   | a0 .. an -- s0 .. sn | | Randomly permute the order of all values on the stack | [whitespace-nd](https://github.com/haroldl/whitespace-nd) by Harold Lee |
| OutputStack      | TLSSS (conflicts) | | .. -- | | Output the entire stack as characters | [whitespacesdk](https://github.com/wspace/mash-whitespacesdk) by MArtin SHerratt |
| shell            | TLL   | s | ?       | | Execute shell command (unimplemented) | [Spitewaste](https://github.com/collidedscope/spitewaste) by Collided Scope |
| PYFN             | LLS   | l | a1 .. an -- a1 .. an retval | | Call the Python function registered as *l* with *n* arguments | [PYWS](https://github.com/EizoAssik/pyws) by Eizo Assik |
| debug_printstack | LLSSS |   | --      | | Dump stack | [wsintercpp](https://github.com/wspace/burghard-wsintercpp), [wsinterws](https://github.com/wspace/burghard-wsinterws), and [wsa](https://github.com/wspace/burghard-wsa) by Oliver Burghard |
| debug_printheap  | LLSST |   | --      | | Dump heap | [wsintercpp](https://github.com/wspace/burghard-wsintercpp), [wsinterws](https://github.com/wspace/burghard-wsinterws), and [wsa](https://github.com/wspace/burghard-wsa) by Oliver Burghard |
| Trace            | LLT   |   | --      | | Dump program state | [pywhitespace](https://github.com/wspace/phlip-pywhitespace) by Phillip Bradbury |
| eval             | LLT   | s | ?       | | (unimplemented) | [Spitewaste](https://github.com/collidedscope/spitewaste) by Collided Scope |
