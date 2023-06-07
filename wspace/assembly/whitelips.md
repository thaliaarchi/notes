# javascript/vii5ard-whitelips-ide

```bnf
SPACE ::= [ \t\n\r]+
LINE_COMMENT ::=
    | ";" [^\n]*
    | "#" [^\n]*
    | "--" [^\n]*
MULTILINE_COMMENT ::= {-.*?-}
NUMBER ::= [+-]?\d*
STRING ::=
    | "\"" …
    | "'" …
LABEL ::=

TOKEN ::=
    | LINE_COMMENT
    | MULTILINE_COMMENT
    | STRING
    | NUMBER
    | LABEL

NUMBER (SPACE | ";" | EOF)
```
