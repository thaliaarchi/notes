# Comparison of integer literal syntax

A comparison of the syntaxes for integer literals in various programming
languages.

The sign (i.e., `-` or sometimes `+`) is often considered an operator and not
documented in the grammars with integer literals, so it is not included here.

This focuses on grammars. For history and context, read the [Integer Literals](https://web.archive.org/web/20141021124940/http://hhh.gavilan.edu/dvantassel/history/literals.html#_Toc193407229)
section in Dennie Van Tassel's [History and comparison of programming languages](https://web.archive.org/web/20150118032430/http://hhh.gavilan.edu:80/dvantassel/history/history.html).
Pascal Rigaux's [Syntax across languages](http://rigaux.org/language-study/syntax-across-languages/Mthmt.html#MthmtNmbrSntx)
also lists more languages than here.

## Summary

| Language          | Bases            | Decimal prefix | Binary prefix | Octal prefix    | Hex prefix | Leading zero | Separator | Leading sep | Trailing sep | Repeated sep | Suffix   |
| ----------------- | ---------------- | -------------- | ------------- | --------------- | ---------- | ------------ | --------- | ----------- | ------------ | ------------ | -------- |
| Ada               | 2-16             | "", `10#`      | `2#`          | `8#`            | `16#`      | Decimal      | `_`       | No          | No           | No           | Exponent |
| C23               | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0`             | `0x`, `0X` | Octal        | `'`       | No          | No           | No           | Type     |
| C89–C17           | 8, 10, 16        | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | Type     |
| C#                | 2, 10, 16        | ""             | `0b`, `0B`    | N/A             | `0x`, `0X` | Decimal      | `_`       | Yes         | No           | Yes          | Type     |
| Erlang            | 2-36             | "", `10#`      | `2#`          | `8#`            | `16#`      | Decimal      | `_`       | No          | No           | No           | N/A      |
| Go 1.13+          | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | `_`       | Yes         | No           | No           | N/A      |
| Go <=1.12         | 8, 10, 16        | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | N/A      |
| Java 7+           | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0`             | `0x`, `0X` | Octal        | `_`       | No          | No           | Yes          | Type     |
| Java 6            | 8, 10, 16        | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | Type     |
| JSON              | 10               | ""             | N/A           | N/A             | N/A        | Illegal      | N/A       | N/A         | N/A          | N/A          | Exponent |
| Python 3.6+       | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0o`, `0O`      | `0x`, `0X` | Illegal      | `_`       | Yes         | No           | No           | N/A      |
| Python 3.0–3.5    | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0o`, `0O`      | `0x`, `0X` | Illegal      | N/A       | N/A         | N/A          | N/A          | N/A      |
| Python 2.6–2.7    | 2, 8, 10, 16     | ""             | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | Type     |
| Python <=2.5      | 8, 10, 16        | ""             | N/A           | `0`             | `0x`, `0X` | Octal        | N/A       | N/A         | N/A          | N/A          | Type     |
| Ruby              | 2, 8, 10, 16     | "", `0d`, `0D` | `0b`, `0B`    | `0`, `0o`, `0O` | `0x`, `0X` | Octal        | `_`       | No          | No           | No           | N/A      |
| Rust              | 2, 8, 10, 16     | ""             | `0b`          | `0o`            | `0x`       | Decimal      | `_`       | Yes         | Yes          | Yes          | Type     |
| Rust 0.1–0.8      | 2, 10, 16        | ""             | `0b`          | N/A             | `0x`       | Decimal      | `_`       | Yes         | Yes          | Yes          | Type     |
| Visual Basic 15.5 | 2, 8, 10, 16     | ""             | `&B`, `&b`    | `&O`, `&o`      | `&H`, `&h` | Decimal      | `_`       | Yes         | No           | Yes          | Type     |
| Visual Basic 15.0 | 2, 8, 10, 16     | ""             | `&B`, `&b`    | `&O`, `&o`      | `&H`, `&h` | Decimal      | `_`       | No          | No           | Yes          | Type     |
| Visual Basic 7.0  | 8, 10, 16        | ""             | N/A           | `&O`, `&o`      | `&H`, `&h` | Decimal      | N/A       | N/A         | N/A          | N/A          | Type     |
| YAML 1.2          | 8, 10, 16        | ""             | N/A           | `0o`            | `0x`       | Decimal      | N/A       | N/A         | N/A          | N/A          | N/A      |
| YAML 1.1          | 2, 8, 10, 16, 60 | ""             | `0b`          | `0`             | `0x`       | Decimal      | `_`       | Yes         | Yes          | Yes          | N/A      |
| Zig 0.8+          | 2, 8, 10, 16     | ""             | `0b`          | `0o`            | `0x`       | Decimal      | `_`       | No          | No           | No           | N/A      |
| Zig <=0.7         | 2, 8, 10, 16     | ""             | `0b`          | `0o`            | `0x`       | Decimal      | N/A       | N/A         | N/A          | N/A          | N/A      |

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

From §6.4.4.1 Integer constants in the [C Standard](https://iso-9899.info/wiki/The_Standard)
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

From §6.4.4.1 Integer constants in the [C Standard](https://iso-9899.info/wiki/The_Standard)
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

From §3.1.3.2 Integer constants in the [C89 draft](https://port70.net/~nsz/c/c89/c89-draft.html#3.1.3.2)
and §6.1.3.2 Integer constants in the [C89 standard](https://web.archive.org/web/20200909074736if_/https://www.pdf-archive.com/2014/10/02/ansi-iso-9899-1990-1/ansi-iso-9899-1990-1.pdf).

### C#

```bnf
integer_literal ::= (dec_literal | bin_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit ("_"* dec_digit)*
bin_literal     ::= ("0" [bB]) ("_"* bin_digit)+
hex_literal     ::= ("0" [xX]) ("_"* hex_digit)+
integer_suffix  ::= [Uu][Ll]? | [Ll][Uu]?
```

According to the language specification as of [C# 7](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/lexical-structure#6453-integer-literals)
and described informally in the [language reference](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/integral-numeric-types).

### Go

#### Go 1.13+

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] ("_"? dec_digit)* | "0"
bin_literal     ::= "0" [bB] ("_"? bin_digit)+
oct_literal     ::= "0" [oO]? ("_"? oct_digit)+
hex_literal     ::= "0" [xX] ("_"? hex_digit)+
```

From the [language specification](https://go.dev/ref/spec#Integer_literals)
as of [Go 1.13](https://github.com/golang/go/blob/go1.13/doc/go_spec.html#L272-L320)
through [1.20](https://github.com/golang/go/blob/go1.20/doc/go_spec.html#L277-L325).

#### Go <=1.12

```bnf
integer_literal ::= dec_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] dec_digit*
oct_literal     ::= "0" oct_digit*
hex_literal     ::= "0" [xX] hex_digit+
```

From the language specification as of the initial commit on [2008-03-02](https://github.com/golang/go/blob/18c5b488a3b2e218c0e0cf2a7d4820d9da93a554/doc/go_spec#L412-L417)
through [Go 1.12](https://github.com/golang/go/blob/go1.12/doc/go_spec.html#L271-L292).

### Java

#### Java 7+

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
through [20](https://docs.oracle.com/javase/specs/jls/se20/html/jls-3.html#jls-3.10.1).

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

### JSON

```bnf
number_literal  ::= "-"? integer fraction? exponent?
integer         ::= [1-9] dec_digit* | "0"
fraction        ::= "." dec_digit+
exponent        ::= [eE] [-+]? dec_digit+
```

Specified in [RFC 4627](https://datatracker.ietf.org/doc/html/rfc4627#section-2.4),
[RFC 7159](https://datatracker.ietf.org/doc/html/rfc7159#section-6),
[RFC 8259](https://datatracker.ietf.org/doc/html/rfc8259#section-6),
ECMA-404 ([1st](https://www.ecma-international.org/wp-content/uploads/ECMA-404_1st_edition_october_2013.pdf)
and [2nd](https://www.ecma-international.org/wp-content/uploads/ECMA-404_2nd_edition_december_2017.pdf)
editions), and [ISO/IEC 21778:2017](https://www.iso.org/standard/71616.html).

### Python

#### Python 3.6+

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] ("_"? dec_digit)* | "0" ("_"? "0")*
bin_literal     ::= "0" [bB] ("_"? bin_digit)+
oct_literal     ::= "0" [oO] ("_"? oct_digit)+
hex_literal     ::= "0" [xX] ("_"? hex_digit)+
```

From the [language reference](https://docs.python.org/3/reference/lexical_analysis.html#integer-literals)
as of [Python 3.6](https://docs.python.org/3.6/reference/lexical_analysis.html#integer-literals)
through [3.11.4](https://docs.python.org/3.11/reference/lexical_analysis.html#integer-literals).

#### Python 3.0–3.5

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= [1-9] dec_digit* | "0"+
bin_literal     ::= "0" [bB] bin_digit+
oct_literal     ::= "0" [oO] oct_digit+
hex_literal     ::= "0" [xX] hex_digit+
```

C-style octal numbers with a leading zero were allowed until Python 3.0.

From the language reference as of [Python 3.0](https://docs.python.org/3.0/reference/lexical_analysis.html#integer-literals)
through [3.5](https://docs.python.org/3.5/reference/lexical_analysis.html#integer-literals).

#### Python 2.6–2.7

```bnf
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) long_suffix?
dec_literal     ::= [1-9] dec_digit* | "0"
bin_literal     ::= "0" [bB] bin_digit+
oct_literal     ::= "0" [oO] oct_digit+ | "0" oct_digit+
hex_literal     ::= "0" [xX] hex_digit+
long_suffix     ::= [lL]
```

From the language reference as of [Python 2.6](https://docs.python.org/2.6/reference/lexical_analysis.html#integer-and-long-integer-literals)
through [2.7](https://docs.python.org/2.7/reference/lexical_analysis.html#integer-and-long-integer-literals).

#### Python <=2.5

```bnf
integer_literal ::= (dec_literal | oct_literal | hex_literal) long_suffix?
dec_literal     ::= [1-9] dec_digit* | "0"
oct_literal     ::= "0" oct_digit+
hex_literal     ::= "0" [xX] hex_digit+
long_suffix     ::= [lL]
```

From the [language reference](https://www.python.org/doc/versions/)
as of [Python 1.4](https://docs.python.org/release/1.4/ref/ref2.html#HDR17)
through [2.5](https://docs.python.org/release/2.5/ref/integers.html).

The language reference was first released with Python 1.4. Before that and as
early as [Python 0.9.1](https://github.com/smontanaro/python-0.9.1/blob/main/src/tokenizer.c#L418-L468),
the tokenizer matches this grammar.

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
integer_literal ::= (dec_literal | bin_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit (dec_digit | "_")*
bin_literal     ::= "0b" "_"* bin_digit (bin_digit | "_")*
oct_literal     ::= "0o" "_"* oct_digit (oct_digit | "_")*
hex_literal     ::= "0x" "_"* hex_digit (hex_digit | "_")*
```

The pattern `integer_suffix` has varied as integer types have been added:
- Rust [0.9](https://doc.rust-lang.org/0.9/rust.html#number-literals)–[0.12](https://doc.rust-lang.org/0.12.0/reference.html#number-literals):
  `u8`, `u16`, `u32`, `u64`, `u`, `i8`, `i16`, `i32`, `i64`, or `i`
- Rust [1.0](https://doc.rust-lang.org/1.0.0/reference.html#integer-literals)–[1.27](https://doc.rust-lang.org/1.27.0/reference/tokens.html#integer-literals):
  `u8`, `u16`, `u32`, `u64`, `usize`, `i8`, `i16`, `i32`, `i64`, or `isize`
- Rust [1.28](https://doc.rust-lang.org/1.28.0/reference/tokens.html#integer-literals)–[1.66](https://doc.rust-lang.org/1.66.0/reference/tokens.html#integer-literals):
  `u8`, `u16`, `u32`, `u64`, `u128`, `usize`, `i8`, `i16`, `i32`, `i64`, `i128`, or `isize`
- Rust [1.67](https://doc.rust-lang.org/1.67.0/reference/tokens.html#integer-literals)–[1.70](https://doc.rust-lang.org/1.70.0/reference/tokens.html#integer-literals):
  an identifier or keyword not beginning with `e` or `E`

From the [language reference](https://doc.rust-lang.org/reference/tokens.html#integer-literals)
as of [Rust 0.9](https://doc.rust-lang.org/0.9/rust.html#number-literals)
through [1.70](https://doc.rust-lang.org/1.70.0/reference/tokens.html#integer-literals).

<details>
<summary>Earlier Rust versions</summary>

#### Rust 0.1–0.8

These versions had no octal literals, but were otherwise identical to later
versions.

```bnf
integer_literal ::= (dec_literal | bin_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit (dec_digit | "_")*
bin_literal     ::= "0b" "_"* bin_digit (bin_digit | "_")*
hex_literal     ::= "0x" "_"* hex_digit (hex_digit | "_")*
integer_suffix  ::= "u8" | "u16" | "u32" | "u64" | "u"
                  | "i8" | "i16" | "i32" | "i64" | "i"
```

From the language reference as of [Rust 0.3](https://doc.rust-lang.org/0.3/rust.html#number-literals)
through [0.8](https://doc.rust-lang.org/0.8/rust.html#number-literals). The
rustc and rustboot lexers matched this behavior back to [2010-07-27](https://github.com/rust-lang/rust/blob/80307576245aabf00285db020bbfbc4c3a891766/src/boot/fe/lexer.mll#L141-L145)
in rust-lang/rust, 1.5 years before Rust 0.1.

From [2010-07-01](https://github.com/rust-lang/rust/blob/afc0dc8bfcc5d6fba1e907ab35c110fc074cad67/src/boot/fe/lexer.mll#L123-L127)
through [2010-07-27](https://github.com/rust-lang/rust/blob/6662aeb779d3e44886c466378578ebe1979de15a/src/boot/fe/lexer.mll#L124-L128)
in rust-lang/rust, integer suffixes had not yet been added.

#### Rust rustboot 2007–2010

These revisions had no suffixes or octal literals, and did not allow leading
underscores due to a bug.

```bnf
integer_literal ::= (dec_literal | bin_literal | hex_literal)
dec_literal     ::= dec_digit+
bin_literal     ::= "0b" bin_digit (bin_digit | "_")*
hex_literal     ::= "0x" hex_digit (hex_digit | "_")*
```

From [2007-05-22](https://github.com/graydon/rust-prehistory/blob/aa2d738554e561d526809f3cba0fd643e3d12906/src/lexer.mll#L77-L79)
in graydon/rust-prehistory through [2010-07-01](https://github.com/rust-lang/rust/blob/3aaff59dba4b9fff598c49eeb579cb6c631dd4f4/src/boot/fe/lexer.mll#L123-L126)
in rust-lang/rust.

#### Rust rustboot 2006–2007

These revisions had no suffixes, and did not allow leading underscores due to a
bug.

```bnf
integer_literal ::= (dec_literal | bin_literal | hex_literal)
dec_literal     ::= dec_digit+
bin_literal     ::= "0b" bin_digit (bin_digit | "_")*
oct_literal     ::= "0o" oct_digit (oct_digit | "_")*
hex_literal     ::= "0x" hex_digit (hex_digit | "_")*
```

From the initial commit on [2006-07-23](https://github.com/graydon/rust-prehistory/blob/b0fd440798ab3cfb05c60a1a1bd2894e1618479e/src/lexer.mll#L66-L69)
through [2007-05-22](https://github.com/graydon/rust-prehistory/blob/c1f80de7286b4268a4c1ebaddfa35cc2d7c57a4d/src/lexer.mll#L77-L80)
in graydon/rust-prehistory.

</details>

### YAML

#### YAML 1.2

```bnf
integer_literal ::= dec_literal | oct_literal | hex_literal
dec_literal     ::= [-+]? dec_digit+
oct_literal     ::= "0o" oct_digit+
hex_literal     ::= "0x" hex_digit+
```

According to the patterns in Tag Resolution in the language specification as of
[versions 1.2.0](https://yaml.org/spec/1.2.0/#id2604185), [1.2.1](https://yaml.org/spec/1.2.1/#id2805071),
and [1.2.2](https://yaml.org/spec/1.2.2/#10213-integer). The separate section on
the `int` type was removed and this section is less specific, so some details
may be missing.

#### YAML 1.1

Until YAML 1.2, YAML had sexagesimal (base 60) literals.

```bnf
integer_literal ::= [-+]? (dec_literal | oct_literal | hex_literal | sex_literal)
dec_literal     ::= [1-9] (dec_digit | "_")* | "0"
bin_literal     ::= "0b" (bin_digit | "_")+
oct_literal     ::= "0" (oct_digit | "_")+
hex_literal     ::= "0x" (hex_digit | "_")+
sex_literal     ::= [1-9][0-9_]* (":" [0-5]?[0-9])+
```

The grammar allows for empty digits when using underscores. This may be a bug in
the spec. An example has the decimal literal `+12,345`, but I assume this was a
mistake.

Specified in the [Integer Language-Independent Type](https://yaml.org/type/int.html)
specification for YAML 1.1. The YAML specification 1.0 does not have enough
details to describe it, but it has the [same examples](https://yaml.org/spec/1.0/#id2490997)
for decimal, octal, hexadecimal, and sexagesimal as 1.1.

### Zig

#### Zig 0.8+

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= dec_digit ("_"? dec_digit)*
bin_literal     ::= "0b" bin_digit ("_"? bin_digit)*
oct_literal     ::= "0o" oct_digit ("_"? oct_digit)*
hex_literal     ::= "0x" hex_digit ("_"? hex_digit)*
```

Defined in the Zig grammar from Zig [0.8.0](https://ziglang.org/documentation/0.8.0/#Grammar)
through [0.11.0](https://ziglang.org/documentation/0.11.0/#Grammar).

#### Zig <=0.7

```bnf
integer_literal ::= dec_literal | bin_literal | oct_literal | hex_literal
dec_literal     ::= dec_digit+
bin_literal     ::= "0b" bin_digit+
oct_literal     ::= "0o" oct_digit+
hex_literal     ::= "0x" hex_digit+
```

Defined in the Zig grammar from Zig [0.4.0](https://ziglang.org/documentation/0.4.0/#Grammar)
through [0.7.1](https://ziglang.org/documentation/0.7.1/#Grammar) and documented
by example from [0.1.0](https://ziglang.org/documentation/0.1.0/#integer-literals)
through [0.3.0](https://ziglang.org/documentation/0.3.0/#Integer-Literals).

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

From [§2.4.1 Decimal Literals](http://www.ada-auth.org/standards/22rm/html/RM-2-4-1.html#S0009)
and [§2.4.2 Based Literals](http://www.ada-auth.org/standards/22rm/html/RM-2-4-2.html)
in the [Language Reference Manual](https://www.adaic.org/ada-resources/standards/)
as of [Ada 83](https://www.adaic.org/ada-resources/standards/ada83/),
[95](https://www.adaic.org/ada-resources/standards/ada-95-documents/),
[2005](https://www.adaic.org/ada-resources/standards/ada05/),
[2012](http://www.ada-auth.org/standards/ada12_w_tc1.html),
and [2022 draft 35](http://www.ada-auth.org/standards/ada22.html).

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

## Visual Basic

### Visual Basic 15.5

VB 15.5 added leading digit separators.

```bnf
integer_literal ::= (int_literal | bin_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit ("_"* dec_digit)*
bin_literal     ::= ("&" [Bb]) ("_"* bin_digit)+
oct_literal     ::= ("&" [Oo]) ("_"* oct_digit)+
hex_literal     ::= ("&" [Hh]) ("_"* hex_digit)+
integer_suffix  ::= [Uu]?[Ss] | [Uu]?[Ii] | [Uu]?[Ll] | "%" | "&"
```

Noted in [what's new](https://learn.microsoft.com/en-us/dotnet/visual-basic/whats-new/#visual-basic-155)
for Visual Basic 15.0.

### Visual Basic 15.0

VB 15.0 added binary literals and digit separators.

```bnf
integer_literal ::= (int_literal | bin_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit ("_"* dec_digit)*
bin_literal     ::= ("&" [Bb]) bin_digit ("_"* bin_digit)*
oct_literal     ::= ("&" [Oo]) oct_digit ("_"* oct_digit)*
hex_literal     ::= ("&" [Hh]) hex_digit ("_"* hex_digit)*
integer_suffix  ::= [Uu]?[Ss] | [Uu]?[Ii] | [Uu]?[Ll] | "%" | "&"
```

Noted in [what's new](https://learn.microsoft.com/en-us/dotnet/visual-basic/whats-new/#visual-basic-15)
for Visual Basic 15.0.

### Visual Basic 8.0–11.0

VB 8.0 added unsigned types.

```bnf
integer_literal ::= (int_literal | oct_literal | hex_literal) integer_suffix?
dec_literal     ::= dec_digit+
oct_literal     ::= ("&" [Oo]) oct_digit+
hex_literal     ::= ("&" [Hh]) hex_digit+
integer_suffix  ::= [Uu]?[Ss] | [Uu]?[Ii] | [Uu]?[Ll] | "%" | "&"
```

Decimal literals represent the signed decimal value of the integral literal,
whereas octal and hexadecimal literals represent the unsigned binary value.

The suffix variants stand for the types `Short` and `UShort`, `Integer` and
`UInteger`, `Long` and `ULong`, `Integer`, and `Long`, respectively. When no
type suffix is specified, the type is `Integer` if it is in the range of
`Integer`, `Long` if in the range of `Long`, or otherwise a compile-time error.

According to the language specification for Visual Basic 8.0–11.0.

### Visual Basic 7.0–7.1

```bnf
integer_suffix  ::= [Ss] | [Ii] | [Ll] | "%" | "&"
```

According to the language specification for Visual Basic 7.0–7.1.
