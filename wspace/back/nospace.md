# Nospace (cpp/buyoh-nospace)

[[code](https://github.com/buyoh/nospace/blob/master/main.cpp)]
[[docs](https://github.com/buyoh/nospace/blob/master/docs/tutorial_en.md)]

```bnf
program ::= (func | let)*

# Tokens
integer ::= /[0-9]+/
char ::= /'([^\\\t\n\s']|\\[\\tns'])*'/
ident ::= /[A-Za-z_][A-Za-z0-9_]*/

# Whitespace (allowed between every token)
space ::= /[ \t\n\v\f\r]/
comment ::= /#[^#]*#/

# Expressions
expr ::= expr_bin5
expr_val ::=
    | integer
    | char
    | ident
    | ident "(" (expr ("," expr)*)? ")"
    | "(" expr ")"
    | "&" ident
expr_unary ::=
    | ("-" | "!" | "*") expr_unary
    | expr_val
expr_index ::= expr_unary ("[" expr "]")?
expr_bin1 ::= expr_index (("*" | "/" | "%") expr_bin1)?
expr_bin2 ::= expr_bin1 (("+" | "-") expr_bin2)?
expr_bin3 ::= expr_bin2 (("==" | "!=" | "<" | "<=" | ">" | ">=") expr_bin3)?
expr_bin4 ::= expr_bin3 (("&&" || "||") expr_bin4)?
expr_bin5 ::= expr_bin4 (("=" | "+=" | "-=" | "*=" | "/=" | "%=") expr_bin5)?

# Statements
func ::=
    | "func" ":" ident "(" (ident ("," ident)*)? ")"
        "{" (stmt | let)* "}"
let ::=
    | "let" ":" let_decl ("," let_decl)* ";"
let_decl ::=
    | ident ("[" expr "]")? ("(" (expr ("," expr)*)? ")")?
stmt ::=
    | "if" "(" expr ")" block
        ("elsif" "(" expr ")" block)*
        ("else" block)?
    | "while" "(" expr ")" block
    | "return" (":" expr)? ";"
    | expr ";"
block ::= "{" stmt* "}"
```
