# Comparison of integer literal syntax

A comparison of the syntaxes for integer literals in various programming
languages.

The sign (i.e., `-` or sometimes `+`) is often considered an operator and not
documented in the grammars with integer literals, so it is not included here.

This focuses on grammars. For history and context, read the [“Integer Literals”](https://web.archive.org/web/20141021124940/http://hhh.gavilan.edu/dvantassel/history/literals.html#_Toc193407229)
section in Dennie Van Tassel's [History and comparison of programming languages](https://web.archive.org/web/20150118032430/http://hhh.gavilan.edu:80/dvantassel/history/history.html).

| Language  | Bases        | Decimal prefix | Binary prefix | Octal prefix    | Hex prefix | Leading zero | Separator | Leading sep | Trailing sep | Repeated sep | Exponent |
| --------- | ------------ | -------------- | ------------- | --------------- | ---------- | ------------ | --------- | ----------- | ------------ | ------------ | -------- |
| Ada       | 2-16         | "", `10#`      | `2#`          | `8#`            | `16#`      | Decimal      | `_`       | No          | No           | No           | Yes      |
| C89–C17   | 8, 10, 16    | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | No       |
| C23       | 2, 8, 10, 16 | ""             | `0b`, `0B`    | `0`             | `0x`, `0X` | Octal        | `'`       | No          | No           | No           | No       |
| Erlang    | 2-36         | "", `10#`      | `2#`          | `8#`            | `16#`      | Decimal      | `_`       | No          | No           | No           | No       |
| Go        | 2, 8, 10, 16 | ""             | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | `_`       | Yes         | No           | No           | No       |
| Java 6    | 8, 10, 16    | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | No       |
| Java 7–20 | 2, 8, 10, 16 | ""             | `0b`, `0B`    | `0`             | `0x`, `0X` | Octal        | `_`       | No          | No           | Yes          | No       |
| Python 2  | 2, 8, 10, 16 | ""             | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | No       |
| Python 3  | 2, 8, 10, 16 | ""             | `0b`, `0B`    | `0o`, `0O`      | `0x`, `0X` | Illegal      | `_`       | Yes         | No           | No           | No       |
| Ruby      | 2, 8, 10, 16 | "", `0d`, `0D` | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | `_`       | No          | No           | No           | No       |
| Rust      | 2, 8, 10, 16 | ""             | `0b`          | `0o`            | `0x`       | Decimal      | `_`       | Yes         | Yes          | Yes          | No       |

Shared definitions:

```bnf
dec_digit       ::= [0-9]
bin_digit       ::= [0-1]
oct_digit       ::= [0-7]
hex_digit       ::= [0-9 a-f A-F]
```

## C-style

### C

#### C23

```bnf
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= [1-9] ("'"? dec_digit)*
bin_literal     ::= "0" [bB] bin_digit ("'"? bin_digit)*
oct_literal     ::= "0" ("'"? oct_digit)*
hex_literal     ::= "0" [xX] hex_digit ("'"? hex_digit)*
integer_suffix  ::= unsigned_suffix (long_suffix | long_long_suffix | bit_precise_int_suffix)?
                  | (long_suffix | long_long_suffix | bit_precise_int_suffix) unsigned_suffix?
unsigned_suffix ::= [uU]
long_suffix     ::= [lL]
long_long_suffix ::= "ll" | "LL"
bit_precise_int_suffix ::= "wb" | "WB"
```

From §6.4.4.1 “Integer constants” in the [C Standard](https://iso-9899.info/wiki/The_Standard)
as of [N3096 (2023-04-02)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3096.pdf).

#### C99, C11, and C17

```bnf
integer_literal ::= (dec_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= [1-9] dec_digit*
oct_literal     ::= "0" oct_digit*
hex_literal     ::= "0" [xX] hex_digit+
integer_suffix  ::= unsigned_suffix (long_suffix | long_long_suffix)?
                  | (long_suffix | long_long_suffix) unsigned_suffix?
unsigned_suffix ::= [uU]
long_suffix     ::= [lL]
long_long_suffix ::= "ll" | "LL"
```

From §6.4.4.1 “Integer constants” in the [C Standard](https://iso-9899.info/wiki/The_Standard)
as of [N1256 (2007-09-07)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf),
[N1570 (2011-04-04)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf),
and [N2310 (2018-11-11)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf).

#### C89 and C90

C89 and C89 have identical integer literals to later versions through C17,
except for not having a suffix for `long long`:

```bnf
integer_suffix  ::= unsigned_suffix long_suffix? | long_suffix unsigned_suffix?
unsigned_suffix ::= [uU]
long_suffix     ::= [lL]
```

From §3.1.3.2 “Integer constants” in the [C89 draft](https://port70.net/~nsz/c/c89/c89-draft.html#3.1.3.2)
and §6.1.3.2 “Integer constants” in the [C89 standard](https://web.archive.org/web/20200909074736if_/https://www.pdf-archive.com/2014/10/02/ansi-iso-9899-1990-1/ansi-iso-9899-1990-1.pdf).

### Go

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] ("_"? dec_digit)* | "0"
bin_literal     ::= "0" [bB] ("_"? bin_digit)+
oct_literal     ::= "0" [oO]? ("_"? oct_digit)+
hex_literal     ::= "0" [xX] ("_"? hex_digit)+
```

From the [language specification](https://go.dev/ref/spec#Integer_literals)
as of Go 1.20, revised [15 Dec 2022](https://web.archive.org/web/20230606081724/https://go.dev/ref/spec#Integer_literals).

### Java

#### Java 7–20

```bnf
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= [1-9] ("_"* dec_digit)* | "0"
bin_literal     ::= "0" [bB] bin_digit ("_"* bin_digit)*
oct_literal     ::= "0" ("_"* oct_digit)+
hex_literal     ::= "0" [xX] hex_digit ("_"* hex_digit)*
integer_suffix  ::= [lL]
```

From the [The Java Language Specification](https://docs.oracle.com/javase/specs/)
as of [Java SE 7](https://docs.oracle.com/javase/specs/jls/se7/html/jls-3.html#jls-3.10.1)
through [Java SE 20](https://docs.oracle.com/javase/specs/jls/se20/html/jls-3.html#jls-3.10.1).

#### Java 6

```bnf
integer_literal ::= (dec_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= [1-9] dec_digit* | "0"
oct_literal     ::= "0" oct_digit+
hex_literal     ::= "0" [xX] hex_digit+
integer_suffix  ::= [lL]
```

From the [The Java Language Specification](https://docs.oracle.com/javase/specs/)
as of [Java SE 6](https://docs.oracle.com/javase/specs/jls/se6/html/lexical.html#3.10.1).

### Python

#### Python 3

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] ("_"? dec_digit)* | "0" ("_"? "0")*
bin_literal     ::= "0" [bB] ("_"? bin_digit)+
oct_literal     ::= "0" [oO] ("_"? oct_digit)+
hex_literal     ::= "0" [xX] ("_"? hex_digit)+
```

From the [language reference](https://docs.python.org/3/reference/lexical_analysis.html#integer-literals)
as of [Python 3.11.4](https://docs.python.org/3.11/reference/lexical_analysis.html#integer-literals).

#### Python 2

```bnf
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) long_suffix?
dec_literal     ::= [1-9] dec_digit* | "0"
bin_literal     ::= "0" [bB] bin_digit+
oct_literal     ::= "0" [oO] oct_digit+ | "0" oct_digit+
hex_literal     ::= "0" [xX] hex_digit+
long_suffix     ::= [lL]
```

C-style octal numbers with a leading zero were allowed until Python 3.0.

From the language reference as of [Python 2.7](https://docs.python.org/2.7/reference/lexical_analysis.html#integer-and-long-integer-literals).

### Ruby

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] ("_"? dec_digit)* | "0" [dD] dec_digit ("_"? dec_digit)*
bin_literal     ::= "0" [bB] bin_digit ("_"? bin_digit)*
oct_literal     ::= "0" [oO] oct_digit ("_"? oct_digit)* | "0" ("_"? oct_digit)*
hex_literal     ::= "0" [xX] hex_digit ("_"? hex_digit)*
```

From the informal [language documentation](https://docs.ruby-lang.org/en/master/syntax/literals_rdoc.html#label-Integer+Literals)
supplemented with the [Ruby Spec Suite](https://github.com/ruby/spec/blob/master/core/kernel/Integer_spec.rb),
revised [31 May 2023](https://github.com/ruby/spec/blob/109d976477e726c1b5006ba3d42b7e9f5d9798be/core/kernel/Integer_spec.rb).

### Rust

```bnf
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) suffix_no_e?
dec_literal     ::= dec_digit (dec_digit | "_")*
bin_literal     ::= "0b" "_"* bin_digit (bin_digit | "_")*
oct_literal     ::= "0o" "_"* oct_digit (oct_digit | "_")*
hex_literal     ::= "0x" "_"* hex_digit (hex_digit | "_")*
```

where `suffix_no_e` is an identifier or keyword not beginning with `e` or `E`.

From the [language reference](https://doc.rust-lang.org/reference/tokens.html#integer-literals)
as of [Rust 1.70.0](https://doc.rust-lang.org/1.70.0/reference/tokens.html#integer-literals).

## Ada-style

### Ada

Ada supports integer literals of any base from 2 to 16, with the form
`base#value#exponent`.

```bnf
integer_literal ::= base_2_literal | … | base_16_literal
dec_literal     ::= dec_digit ("_"? dec_digit)* exponent?
base_2_literal  ::= "0"* "2#" [0-1] ("_"? [0-1])* "#" exponent?
base_3_literal  ::= "0"* "3#" [0-2] ("_"? [0-2])* "#" exponent?
…
base_10_literal ::= "0"* "10#" [0-9] ("_"? [0-9])* "#" exponent?
base_11_literal ::= "0"* "11#" [0-9 a A] ("_"? [0-9 a A])* "#" exponent?
base_12_literal ::= "0"* "12#" [0-9 a-b A-B] ("_"? [0-9 a-b A-B])* "#" exponent?
…
base_16_literal ::= "0"* "16#" [0-9 a-f A-F] ("_"? [0-9 a-f A-F])* "#" exponent?
exponent        ::= [eE] [+-]? dec_literal
```

From [§2.4.1 “Decimal Literals”](http://www.ada-auth.org/standards/22rm/html/RM-2-4-1.html#S0009)
and [§2.4.2 “Based Literals”](http://www.ada-auth.org/standards/22rm/html/RM-2-4-2.html)
in the [Language Reference Manual](https://www.adaic.org/ada-resources/standards/)
as of [Ada 83](https://www.adaic.org/ada-resources/standards/ada83/),
[Ada 95](https://www.adaic.org/ada-resources/standards/ada-95-documents/),
[Ada 2005](https://www.adaic.org/ada-resources/standards/ada05/),
[Ada 2012](http://www.ada-auth.org/standards/ada12_w_tc1.html),
and [Ada 2022 draft 35](http://www.ada-auth.org/standards/ada22.html).

### Erlang

Erlang supports integer literals of any base from 2 to 36, with the form
`base#value`.

```bnf
integer_literal ::= dec_literal | base_2_literal | … | base_36_literal
dec_literal     ::= dec_digit ("_"? dec_digit)*
base_2_literal  ::= "0"* "2#" [0-1] ("_"? [0-1])*
base_3_literal  ::= "0"* "3#" [0-2] ("_"? [0-2])*
…
base_10_literal ::= "0"* "10#" [0-9] ("_"? [0-9])*
base_11_literal ::= "0"* "11#" [0-9 a A] ("_"? [0-9 a A])*
base_12_literal ::= "0"* "12#" [0-9 a-b A-B] ("_"? [0-9 a-b A-B])*
…
base_36_literal ::= "0"* "36#" [0-9 a-z A-Z] ("_"? [0-9 a-z A-Z])*
```

From the [reference manual](https://www.erlang.org/doc/reference_manual/data_types.html#number)
as of [Erlang 14.0.1](https://www.erlang.org/docs/26/reference_manual/data_types.html#number).
