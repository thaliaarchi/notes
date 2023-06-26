# Macros

## Comparison of existing systems

### Whitelips

```bnf
macro ::= "macro" word ":" inst* "$$"
macro_call ::= word (word | number | string)*
```

- The typed arguments are overly restrictive
- Can only expand at opcode position
- Arguments can only be used once in the order given
- Macro definitions are globally scoped across all included files and can be
  redefined, affecting all references, even in calls to macros that are defined
  before the redefinition
- Macros cannot define macros, since the grammar for `$$` is greedy
- No token pasting

Questions:
- How does `$redef` work?

### Burghard

### Respace

```bnf
macro ::= "@define" ident ((macro_params) macro_body)?
    | ident macro_params?
    | "@ifdef" space ident lf program*
      ("@else" lf program*)?
      "@endif"
whitelips_inst ::= …
macro_params ::=
    | "(" ident* ")"
macro_body ::=
    | (inst | number | string)? (";" inst)*
```

- No token pasting

### Lime

## New macros!

```bnf
function ::= "func" sig body
macro    ::= "macro" sig body
sig      ::= word ("(" any* ")")?
block    ::= "{" … "}"
const    ::= "const" word "=" any
let      ::= "let" word "=" any
```

```
def X 123

macro x {
  1 2 3
}
func x(a b c) {
  let x = y; let y = z
  const x = y
}
```
