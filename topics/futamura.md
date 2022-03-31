# Partial Evaluation of Computation Process: An Approach to a Compiler-Compiler

Yoshihiko Futamura

Systems.Computers.Controls, Volume 2, Number 5, 1971

Updated and revised 1999

[[PDF](https://web.archive.org/web/20160910024336/http://www.cs.au.dk:80/~hosc/local/HOSC-12-4-pp381-391.pdf)]

A technique to transform an interpreter to a compiler and its application to a
compiler-compiler. Paper is the first instance of applying partial evaluation in
a compiler-compiler.

## 2. Partial evaluation

For a program *π*, with *m+n* variables *c1,…,cm, r1,…,rm*, evaluate the
portions of *π*, which can be evaluated using the values *c′1,…,c′m* assigned to
*c1,…,cm*. This transforms *π* into a program with *n* variables.

    π(c′1,…,c′m, r′1,…,r′n) = α(π, c′1,…,c′m)(r′1,…,r′n)

- *α*: partial evaluator
- *c1,…,cm*: PE variables
- *r1,…,rn*: remaining variables
- *c′1,…,c′m*: constant PE values
- *r′1,…,r′n*: remaining values

## 3. Generation of a compiler from an interpreter

Within an interpreter, partition the variables into two groups:
- *s*: variables for source program and syntactic and semantic analysis
- *r*: remaining variables

### First projection: program source -> executable

    interp(s′, r′) = α(interp, s′)(r′)

- *α*: partial evaluator
- *s′*: source program
- *r′*: remaining values
- *α(interp, s′)*: object program
- *α(interp, s′)(r′)*: results of executing object program

If all computations concerning *s′* have been performed at PE-time, then the
generated program *α(interp, s′)* does not perform the parsing of *interp* and
can be considered a compiled object program corresponding to the source program.

### Second projection: interpreter -> compiler

    α(interp, s′)(r′) = α(α, interp)(s′)(r′)

- *α(α, interp)*: compiler
- *α(α, interp)(s′)*: object program
- *α(α, interp)(s′)(r′)*: results of executing object program

Properties of *α*:
- p1: evaluates as much with values for PE variables as possible
- p2: evaluates as little with the remaining variables as possible

### Third projection: partial evaluator -> compiler-compiler

α(α, interp)(s′)(r′) = α(α, α)(interp)(s′)(r′)

- *α(α, α)*: compiler-compiler
- *α(α, α)(interp)*: compiler
- *α(α, α)(interp)(s′)*: object program
- *α(α, α)(interp)(s′)(r′)*: results of executing object program

### Equivalences

    partial evaluator: α
    compiler-compiler: α(α, α)
    compiler:          α(α, α)(interp)         = α(α, interp)
    object program:    α(α, α)(interp)(s′)     = α(α, interp)(s′)     = α(interp, s′)
    results:           α(α, α)(interp)(s′)(r′) = α(α, interp)(s′)(r′) = α(interp, s′)(r′)
