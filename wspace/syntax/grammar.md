# Whitespace grammar

## Parsing forwards

```bnf
<prog> ::= <inst> <prog>
         | ε

<inst> ::= "S" "S" <bits>
         | "S" "T" "S" <bits>
         | "S" "T" "L" <bits>
         | "S" "L" "S"
         | "S" "L" "T"
         | "S" "L" "L"
         | "T" "S" "S" "S"
         | "T" "S" "S" "T"
         | "T" "S" "S" "L"
         | "T" "S" "T" "S"
         | "T" "S" "T" "T"
         | "T" "T" "S"
         | "T" "T" "T"
         | "T" "L" "S" "S"
         | "T" "L" "S" "T"
         | "T" "L" "T" "S"
         | "T" "L" "T" "T"
         | "L" "S" "S" <bits>
         | "L" "S" "T" <bits>
         | "L" "S" "L" <bits>
         | "L" "T" "S" <bits>
         | "L" "T" "T" <bits>
         | "L" "T" "L"
         | "L" "L" "L"

<bits> ::= "S" <bits>
         | "T" <bits>
         | "L"
```

The Whitespace grammar is regular, as it can be expressed using only productions
of the form `<A> ::= "a"` and `<A> ::= "a" <B>`.

```bnf
<prog> ::= <inst> <prog>
         | ε

<inst> ::= "S" <S>
         | "T" <T>
         | "L" <L>
<S>    ::= "S" <bits>
         | "T" <ST>
         | "L" <SL>
<ST>   ::= "S" <bits>
         | "L" <bits>
<SL>   ::= "S"
         | "T"
         | "L"
<T>    ::= "S" <TS>
         | "T" <TT>
         | "L" <TL>
<TS>   ::= "S" <TSS>
         | "T" <TST>
<TSS>  ::= "S"
         | "T"
         | "L"
<TST>  ::= "S"
         | "T"
<TT>   ::= "S"
         | "T"
<TL>   ::= "S" <TLS>
         | "T" <TLT>
<TLS>  ::= "S"
         | "T"
<TLT>  ::= "S"
         | "T"
<L>    ::= "S" <LS>
         | "T" <LT>
         | "L" <LL>
<LS>   ::= "S" <bits>
         | "T" <bits>
         | "L" <bits>
<LT>   ::= "S" <bits>
         | "T" <bits>
         | "L"
<LL>   ::= "L"

<bits> ::= "S" <bits>
         | "T" <bits>
         | "L"
```

This contradicts a facetious [comment](https://slashdot.org/comments.pl?sid=59152&cid=5638094)
on the original Whitespace announcement on SlashDot, stating that Whitespace was
the first language to use a context-free grammar.

Note that the parsing error for a signless number in the reference
implementation is lazy, so can be considered part of the language. Thus, signed
numbers and unsigned labels share the same production.

## Parsing backwards

When parsing in reverse, however, Whitespace is ambiguous, when it reaches a
number or label. I am unsure of its class.

```bnf
<prog> ::= <inst> <prog>
         | ε

<inst> ::= "S" "S" "S" "T"
         | "S" "S" "L" "T"
         | "S" "T" "S" "T"
         | "S" "T" "T"
         | "S" "T" "L" "T"
         | "S" "L" "S"
         | "T" "S" "S" "T"
         | "T" "S" "L" "T"
         | "T" "T" "S" "T"
         | "T" "T" "T"
         | "T" "T" "L" "T"
         | "T" "L" "S"
         | "L" "S" "S" "T"
         | "L" "T" "L"
         | "L" "L" "S"
         | "L" "L" "L"
         | "L" <bits> "S" "S"
         | "L" <bits> "S" "S" "L"
         | "L" <bits> "S" "T" "S"
         | "L" <bits> "S" "T" "L"
         | "L" <bits> "T" "S" "L"
         | "L" <bits> "T" "T" "L"
         | "L" <bits> "L" "S" "L"
         | "L" <bits> "L" "T" "S"

<bits> ::= "S" <bits>
         | "T" <bits>
         | ε
```
