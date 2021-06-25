# Whitespace language specification

https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php

## Tokens

The only tokens in the Whitespace language are space (U+0020), tab
(U+0009), and line feed (U+000A), represented hereafter as S, T, and L,
respectively. All other characters are considered comments and must be
ignored.

### Non-standard mappings

- space U+0020, tab U+0009, line feed U+000A
- `S`, `T`, `L`
- `S`, `T`, `N`
- `S`, `T`, line feed U+000A
- `A`, `B`, `C`

## Types

All values in Whitespace are arbitrary-precision integers.

## Instructions

| Prefix | Group              |
| ------ | ------------------ |
| S      | Stack manipulation |
| TS     | Arithmetic         |
| TT     | Heap access        |
| L      | Control flow       |
| TL     | I/O                |

The mnemonics listed below are defined by [Whitelips](https://vii5ard.github.io/whitespace/)
and are non-normative.

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

### Non-standard extensions

STT, TSTL, TSL, TTL, TLSL, TLTL, TLL, LLS, and LLT

| Mnemonic | Syntax | Arg | Stack | Heap | Description | Implementation | Author |
| -------- | ------ | --- | ----- | ---- | ----------- | -------------- | ------ |
| shuffle  | STTS |   | a0 .. an -- s0 .. sn | | Randomly permute the order of all values on the stack | [whitespace-0.4](https://github.com/haroldl/whitespace-nd) | Harold Lee |
| shell    | TLL  | s | ?              | | Execute shell command (unimplemented) | [Spitewaste](https://github.com/collidedscope/spitewaste) | Collided Scope |
| jp       | LSL  | l | cond --        | | Jump to a label if the top of the stack is positive | [R interpreter](https://github.com/bmazoure/whitespace) | Bogdan Mazoure |
| pyfn     | LLS  | l | a1 .. an -- a1 .. an retval | | Call the Python function registered as *l* with *n* arguments | [PYWS](https://github.com/EizoAssik/pyws) | Eizo Assik |
| trace    | LLT  |   | --             | | Dump program trace | [pywhitespace](https://github.com/wspace/phlip-pywhitespace) | Phillip Bradbury |
| eval     | LLT  | s | ?              | | (unimplemented) | [Spitewaste](https://github.com/collidedscope/spitewaste) | Collided Scope |
