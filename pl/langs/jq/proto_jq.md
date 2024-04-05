# Initial implementations of jq

The [initial commit](https://github.com/jqlang/jq/commit/eca89acee00faf6e9ef55d84780e6eeddf225e5c)
of jq is a Haskell implementation, before it was converted to C a [month later](https://github.com/stedolan/jq/commit/2002dc1a2f4c35478b55149bc1a731e65d9a4268).
This reviews the language in those two commits.

## Features

- Values:
  - Objects
    - Keys:
      - String keys (Haskell-only)
      - Ident keys
      - Expression keys
    - Values
  - Arrays
  - Strings (Haskell-only)
  - Integers
  - Booleans (no parsing)
  - Null (no parsing)
- Expressions:
  - `|` Pipe
  - `,` Stream
  - `.` No-op
  - `.ident`, `x.ident` Named property lookup
  - `[]` Array spreading
  - `[…]` Array and object lookup
  - `… as $ident` Variable bindings (C-only)
  - `$ident` Variable references (C-only)
  - `ident`, `ident(…)` Arity 0 or 1 filter call (Haskell-only)
    - `select/1` Select values other than `false` and `null`
    - `find/1`
    - `set/1` Update
    - `sort/0` Sort array
    - `group/1` Group array or return `null`
  - `ident` Arity 0 filter call (C-only)
    - `true` Boolean true
    - `false` Boolean false
  - `+` Integer addition, string concatenation, and array concatenation
  - `==` Equality (Haskell-only)
- Bytecode: (C-only)
  - `LOADK` (constant; a -- b)
  - `DUP` (a -- b c) Duplicate top of stack
  - `SWAP` (x y -- y x) Swap top two on stack
  - `POP` (x -- ) Pop from stack
  - `LOADV` (variable; a -- b)
  - `STOREV` (variable; a -- )
  - `INDEX` (a b -- c) Array and object lookup
  - `APPEND` (a b -- c) Array append
  - `INSERT` (a b c d -- e f) Object assignment
  - `YIELD` (a -- )
  - `EACH` (a -- b) Streaming (`[]`)
  - `FORK` (branch; -- )
  - `JUMP` (branch; -- ) Unconditional jump
  - `BACKTRACK` ( -- )
  - `CALL_BUILTIN_1_1` (function; a -- b) Call a builtin

Notably, it only supported integers, not floating point, and the syntax of
filter calls was different. It was not Turing-complete.

Stack annotations with `a`, `b`, `c`, `d`, `e`, and `f` have not been analyzed
to be named. I am not sure of the precise operation of the unlabeled operations
(`find`, `LOADK`, `LOADV`, and `STOREV`) and most control-flow operations
(`YIELD`, `EACH`, `FORK`, `JUMP`, and `BACKTRACK`).

## Haskell implementation grammar

Lexer:

```bnf
IDENT ::= [a-z A-Z _] [a-z A-Z 0-9 _]*

STRING ::= "\"" CHAR* "\""
CHAR ::=
    | PRINTABLE -- [\"\\]
    | "\\" ["\\/]
    | "\\" [nrt]
    | "\\u" [0-9 a-f A-F]{4}

INT ::= [0-9]+

WHITESPACE ::= …

RESERVED ::=
    | "." | "[" | "]" | "," | ":" | "(" | ")" | "{" | "}" | "|" | "==" | "+"
```

Parser:

```bnf
Exp ::=
    | Exp "|" Exp   # left associativity
    | Exp "," Exp   # left associativity
    | Exp "==" Exp  # no associativity
    | Exp "+" Exp   # left associativity
    | Term

ExpD ::=
    | ExpD "|" ExpD
    | ExpD "==" ExpD
    | Term

Term ::=
    | "."
    | Term "." IDENT
    | "." IDENT
    | STRING
    | Term "[" Exp "]"
    | Term "[" "]"
    | "(" Exp ")"
    | "[" Exp "]"
    | INT
    | "{" MkDict "}"
    | IDENT "(" Exp ")"
    | IDENT

MkDict ::=
    | MkDictPair
    | MkDictPair "," MkDict  # left associativity

MkDictPair ::=
    | IDENT ":" ExpD
    | IDENT
    | STRING ":" ExpD
    | "(" Exp ")" ":" ExpD
```

## C implementation grammar

Lexer:

```bnf
Number ::= [0-9]+

IDENT ::= [a-z A-Z 0-9]+

WHITESPACE ::= [ \n\t]+

RESERVED ::=
    | "." | "=" | ";" | "[" | "]" | "," | ":" | "(" | ")" | "{" | "}"
    | "|" | "+" | "$" | "==" | "as"
```

Parser:

```bnf
Exp ::=
    | Term "as" "$" IDENT "|" Exp  ; "|" is left associative
    | Exp "|" Exp                  ; left associativity
    | Exp "," Exp                  ; left associativity
    | Term

ExpD ::=
    | ExpD "|" ExpD
    | Term

Term ::=
    | "."
    | Term "." IDENT
    | "." IDENT
    | Term "[" Exp "]"
    | Term "[" "]"
    | NUMBER
    | "(" Exp ")"
    | "[" Exp "]"
    | "[" "]"
    | "{" MkDict "}"
    | IDENT
    | "$" IDENT

MkDict ::=
    |
    | MkDictPair
    | MkDictPair ',' MkDict

MkDictPair ::=
    | IDENT ':' ExpD
    | IDENT
    | '(' Exp ')' ':' ExpD
```
