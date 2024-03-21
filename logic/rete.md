# Rete Algorithm

Notes on [“Rete: A Fast Algorithm for the Many Pattern/Many Object Pattern Match
Problem”](https://sci-hub.st/10.1016/0004-3702(82)90020-0) (Charles L. Forgy,
1982).

## §1.1 Semantics of OPS5

The paper focuses on OPS5, which is a language for production systems. Programs
in a production system consist of an unordered collection of if-then statements
(productions). The LHS (if) consists of pure patterns, that match over objects.
Objects have any number of attribute-value pairs and patterns correspond to
objects and have any number of attribute-predicate pairs.

Example production:

```ops5
(P Time 0x
    (Goal  ↑Type Simplify  ↑Object ‹X›)
    (Expression  ↑Name ‹X›  ↑Arg1 0  ↑Op *)
-->
    (MODIFY 2  ↑Op NIL  ↑Args NIL))
```

Constructed grammar for a pattern:

```bnf
    pattern ::= negation? "(" class_name field_pat* ")"
   negation ::= "-"           ; Pattern must not match for the LHS to match

     action ::= "(" "MAKE" class_name field_ctor* ")"
                              ; Constructs an object. Any unspecified fields
                              ; default to NIL.
              | "(" "MODIFY" pat_index field_ctor* ")"
                              ; Modifies the fields of the referenced object.
              | "(" REMOVE pat_index* ")"
                              ; Deletes the referenced objects.
              | …             ; More actions not described in paper
  pat_index ::= integer       ; Refers to a pattern by index (1-indexed) and
                              ; corresponds to the object matching that pattern.

  field_pat ::= "↑" attribute predicate? value
                              ; Pattern to match a field
 field_ctor ::= "↑" attribute value
                              ; Expression to construct a field
  attribute ::= ident         ; Name of the field in the object to match against
      value ::= "‹" ident "›" ; Variable binding. All occurrences of the same
                              ; variable in a pattern must match.
              | ident         ; Constant symbol
              | literal       ; Constant literal
  predicate ::= "="           ; Equal (omitted predicate also means equal)
              | "<>"          ; Not equal
              | "<"           ; Less than
              | ">"           ; Greater than
              | "<="          ; Less than or equal
              | ">="          ; Greater than or equal

 class_name ::= ident         ; Name of the class to match against
      ident ::= …             ; Identifier token
    literal ::= integer       ; Integer literal
              | …             ; Other literals
    integer ::= …             ; Integer token
```

Why are attribute-value pairs tied to objects? Since attributes are listed in a
pattern in any order and are optional, it would seem that the object grouping is
only a means of namespacing. If bindings in patterns can be freely used in
predicates for any attribute in any object, then an object pattern is not
necessarily tied to the same object in the RHS.
