# Whitelips IDE (javascript/vii5ard-whitelips-ide)

[[code](https://github.com/vii5ard/whitespace/blob/master/ws_asm.js)]
[[docs](https://vii5ard.github.io/whitespace/help.html)]

```bnf
space ::= [ \t\n\r]+
line_comment ::=
    | ";" [^\n]*
    | "#" [^\n]*
    | "--" [^\n]*
multiline_comment ::= {-.*?-}
number ::= [+-]?\d*
string ::=
    | "\"" …
    | "'" …
label ::=

token ::=
    | line_comment
    | multiline_comment
    | string
    | number
    | label

number (space | ";" | eof)
```
