# Burghard assembly

- Source: [code](https://github.com/wspace/burghard-wsa/blob/main/trans.hs),
  [docs](https://github.com/wspace/burghard-wsa/blob/main/intro.md)
  (last updated [2023-02-20](https://github.com/wspace/burghard-wsa/tree/9f463d027f9e59238382adb69a1af9bc294c1f6a))
- Corpus: [haskell/burghard-wsa](https://github.com/wspace/corpus/blob/main/haskell/burghard-wsa/project.json)

## Parsing

The file is first preprocessed by removing comments, that are outside of
strings. Comments are of the form:

```bnf
line_comment ::= (";" | "--") [^\n]*
block_comment ::= "{-" .*? (block_comment .*?)*? "-}"
```

Then, it is split into lines and lines into word and string tokens. Space is
required between two words, but not around strings. `{-`, `-}`, `;`, and `--`
cannot occur within a word, but can be in a string. `"` cannot occur in either a
word or string, since it has no escapes.

This step unquotes strings, making them indistinguishable from words afterwards,
so, for example, `"add""'A'"` is parsed as `add` `'A'`. When block comments are
removed, they are replaced with nothing, so can be used to splice words.
Everything is also lowercased, which makes mnemonics case-insensitive, but also
lowercases strings and chars.

```bnf
lines ::= line*
line ::=
    | word? (space | string) line
    | lf
token ::= word | string
word ::= [^ "]+
string ::= "\"" [^"]* "\""
space ::= [ \t]+
lf ::= "\n" | EOF
```

After this point, all grammars are in terms of tokens. Since strings have been
unquoted to words, it is just `word` and `lf` now.

Then, preprocess all includes on lines matching the pattern
`"include" word lf`. The extension `.wsa` is appended to included filenames and
only the first reference to a file is included.

Then, preprocess options. `option` declares a named boolean option to be true
for the rest of the program.

```bnf
option_program ::= option_line*
option_line ::=
    | "option" word lf
    | "ifoption" word lf option_line*
      (("elseifoption" word | "elseoption") lf option_line*)*
      "endoption" lf
    | word* lf
```

Finally, parse the instructions.

```bnf
program ::= (inst? lf)*
inst ::=
    | "push" integer
    | "pushs" string
    | "doub"
    | "swap"
    | "pop"
    | "add" integer?
    | "sub" integer?
    | "mul" integer?
    | "div" integer?
    | "mod" integer?
    | "store" integer?
    | "retrive" integer?
    | "label" label
    | "call" label
    | "jump" label
    | "jumpz" label
    | "jumpn" label
    | "jumpp" label
    | "jumpnz" label
    | "jumppz" label
    | ("jumpnp" | "jumppn") label
    | "ret"
    | "exit"
    | "outc"
    | "outn"
    | "inc"
    | "inn"
    | "debug_printstack"
    | "debug_printheap"
    | "test" integer
    | "valueinteger" integer_variable integer
    | "valuestring" string_variable string
integer ::= integer_literal | integer_variable
string ::= string_literal | string_variable
integer_literal ::= word
string_literal ::= word
integer_variable ::= "_":word
string_variable ::= "_":word
label ::= word
```

Where `"_":word` denotes a word that starts with `_`. The rest after the prefix
may be empty.

Integer literals are parsed with `read :: Integer`, so it follows the same
grammar as `readi` in the reference interpreter.

## Translating

Extension control flow instructions generate auxiliary labels of the form
`__trans__pc__kind__`, where `pc` is the 1-indexed position of the instruction
in the instruction list and `kind` is unique to the operation.

Extension instructions translate as follows:

- `pushs` translates to a `0`-terminated sequence of pushes in reverse order
- `jumpp l` branches on positive and translates to:

  ```wsa
      dup jn __trans__pc__0__
      dup jz __trans__pc__0__
      drop jmp l
  __trans__pc__0__:
      drop
  ```

- `jumpnp l` (and its alias `jumppn`) branches on negative or positive and
  translates to:

  ```wsa
      jz __trans__pc__1__
      jmp l
  __trans__pc__1__:
  ```

- `jumpnz l` branches on negative or zero and translates to:

  ```wsa
      dup jn __trans__pc__2__
      dup jz __trans__pc__2__
      jmp __trans__pc__3__
  __trans__pc__2__:
      drop jmp l
  __trans__pc__3__:
      drop
  ```

- `jumppz l` branches on positive or zero and translates to:

  ```wsa
      jn __trans__pc__4__
      jmp l
  __trans__pc__4__:
  ```

- `test n` translates to `dup push n sub`
- `retrive n` translates to `push n retrieve`
- `store n` translates to `push n swap store`
- `add n` translates to `push n add`
- `sub n` translates to `push n sub`
- `mul n` translates to `push n mul`
- `div n` translates to `push n div`
- `mod n` translates to `push n mod`

`0` is encoded with a sign and digit as `SS`.

Labels are encoded as signed integers incrementing from 0 in definition order.
Duplicate labels are forbidden.

Variables defined with `valueinteger` and `valuestring` do not conflict and can
share names. They are visible to any successive instructions.

An extra `\n\n\n` is appended to the encoded program.

## Bugs in assembler

- Anything can be `"`-quoted
- Block quotes are replaced with nothing, instead of with a space or LF, which
  can concatenate adjacent tokens
- Strings and chars are lowercased
- `elseoption` can appear before `elseoption` or there can be multiple
  `elseoption`
