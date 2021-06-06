# Whitespace language specification

https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php

## Tokens

The only tokens in the Whitespace language are space (ASCII 32), tab
(ASCII 9), and line feed (ASCII 10), represented hereafter as S, T, and
L, respectively. All other characters are considered comments and must
be ignored.

## Types

All values in Whitespace are arbitrary-precision integers.

## Instructions

The mnemonics listed below are defined by [Whitelips](https://vii5ard.github.io/whitespace/)
and are non-normative.

| Mnemonic | Syntax | Arg | Stack | Heap | Description |
| -------- | ------ | --- | ----- | ---- | ----------- |
| push     | SS   | n | -- n            | | Push the number onto the stack |
| dup      | SLS  |   | x -- x x        | | Duplicate the top item on the stack |
| copy     | STS  | n | s_n..s_0 -- s_n..s_0 s_n | | Copy the nth item on the stack (given by the argument) onto the top of the stack |
| swap     | SLT  |   | x y -- y x      | | Swap the top two items on the stack |
| drop     | SLL  |   | x --            | | Discard the top item on the stack |
| slide    | STL  | n | s_n..s_0 -- s_0 | | Slide n items off the stack, keeping the top item |
| add      | TSSS |   | x y -- x+y      | | Addition |
| sub      | TSST |   | x y -- x-y      | | Subtraction |
| mul      | TSSL |   | x y -- x*y      | | Multiplication |
| div      | TSTS |   | x y -- x/y      | | Integer Division |
| mod      | TSTT |   | x y -- x%y      | | Modulo |
| store    | TTS  |   | addr val --     | addr <- val | Store |
| retrieve | TTT  |   | addr -- *addr   | | Retrieve |
| label    | LSS  | l | --              | | Mark a location in the program |
| call     | LST  | l | --              | | Call a subroutine |
| jmp      | LSL  | l | --              | | Jump unconditionally to a label |
| jz       | LTS  | l | cond --         | | Jump to a label if the top of the stack is zero |
| jn       | LTT  | l | cond --         | | Jump to a label if the top of the stack is negative |
| ret      | LTL  |   | --              | | End a subroutine and transfer control back to the caller |
| end      | LLL  |   | --              | | End the program |
| printc   | TLSS |   | char --         | | Output the character at the top of the stack |
| printi   | TLST |   | int --          | | Output the number at the top of the stack |
| readc    | TLTS |   | addr --         | addr <- char | Read a character and place it in the location given by the top of the stack |
| readi    | TLTT |   | addr --         | addr <- int  | Read a number and place it in the location given by the top of the stack |

### Extensions

STT, TSTL, TSL, TTL, TLSL, TLTL, TLL, LLS, and LLT
