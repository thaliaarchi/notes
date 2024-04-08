# Thompson regular expressions

[“Regular Expression Search Algorithm”](https://dl.acm.org/doi/10.1145/363347.363387)
(Ken Thompson, 1968)

Thompson's construction iteratively matches a character at a time against all
current states and advances to the next states. It does not use backtracking. He
states it in terms of [“Derivatives of regular expressions”](https://dl.acm.org/doi/10.1145/321239.321249)
(Janusz A. Brzozowski, 1964), in that it “continually takes the left derivative
of the given regular expression with respect to the text to be searched”.

He mentions its use in “a time-sharing text editor”, which I presume was QED.
Additionally, that “variant of this algorithm is used as the symbol table search
in an assembler”. Which assembler is this?

The language consists of just `|` and `·` (“juxtaposition”) binary operators and
`*` unary operator.

The compiler has three stages running concurrently. The first validates syntax
and inserts `·` for juxtaposition. The second converts it to reverse-Polish
form. The third compiles it into code using a pushdown stack. Binary operators
pop two operands and push a pointer to its compiled code. Unary operators pop
one and do likewise. The result is a pointer to the expression's compiled code.

The compiled code uses two node kinds. `NNODE` matches a single character and is
illustrated as an oval containing the character (`char` in [rsc's definition](https://swtch.com/~rsc/regexp/regexp2.html)).
`CNODE` splits the current search path and is illustrated as ⊕ with one input
edge and two output edges (rsc's `split`). For the remaining two operators
defined by rsc, in Thompson's graphs, there are no ε transitions (so no `jmp`)
and `match` is implicitly represented by an edge to the abstract expression.

## TODO

- Read cited paper on IBM 7094, insofar as to learn the necessary opcodes
- Read other cited papers
- Port algorithm as implemented to Rust and maybe to Lean
  - Does it differ from the prose description?
  - How were `jmp` and `match` implemented?
- Trace direct usage to public code
