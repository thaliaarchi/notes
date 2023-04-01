# Formal grammar for Whitespace

The Whitespace grammar is regular, as it can be expressed using only productions
of the form `<A> ::= "a"` and `<A> ::= "a" <B>`.

```bnf
<Ws>  ::= "S" <S>
        | "T" <T>
        | "L" <L>
<S>   ::= "S" <signed>
        | "T" <ST>
        | "L" <SL>
<ST>  ::= "S" <signed>
        | "L" <signed>
<SL>  ::= "S"
        | "T"
        | "L"
<T>   ::= "S" <TS>
        | "T" <TT>
        | "L" <TL>
<TS>  ::= "S" <TSS>
        | "T" <TST>
<TSS> ::= "S"
        | "T"
        | "L"
<TST> ::= "S"
        | "T"
<TT>  ::= "S"
        | "T"
<TL>  ::= "S" <TLS>
        | "T" <TLT>
<TLS> ::= "S"
        | "T"
<TLT> ::= "S"
        | "T"
<L>   ::= "S" <LS>
        | "T" <LT>
        | "L" <LL>
<LS>  ::= "S" <unsigned>
        | "T" <unsigned>
        | "L" <unsigned>
<LT>  ::= "S" <unsigned>
        | "T" <unsigned>
        | "L"
<LL>  ::= "L"

<signed>   ::= "S" <unsigned>
             | "T" <unsigned>
<unsigned> ::= "S" <unsigned>
             | "T" <unsigned>
             | "L"
```

This contradicts a facetious [comment](https://slashdot.org/comments.pl?sid=59152&cid=5638094)
on the original Whitespace announcement on SlashDot, stating that Whitespace was
the first language to use a context-free grammar.
