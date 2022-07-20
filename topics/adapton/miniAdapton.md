# miniAdapton: A Minimal Implementation of Incremental Computation in Scheme

Dakota Fisher, Mathew A. Hammer (University of Colorado Boulder), William Byrd,
and Matthew Might (University of Utah)

[[paper](https://arxiv.org/abs/1609.05337)],
[[code](https://github.com/fisherdj/miniAdapton)]

microAdapton:
- Minimal substrate (50 lines)
- Avoids building a demanded computation graph

miniAdapton:
- Automatically maintains a DCG
- Memoization
- Thunks
- Adapton variables (new from this paper)

Memoization vs Adapton:
- Memoization stores the results of a computation
- Adapton stores the results, how it got those results, and the computation
  dependency graph. Mutations dirty the graph.

## microAdapton

```scheme
(define-record-type (adapton adapton-cons adapton?)
  (fields thunk              ; The computation to cache
          (mutable result)   ; Cached result of the computation
          (mutable sub)      ; Set of subcomputations
          (mutable super)    ; Set of supercomputations
          (mutable clean?))) ; Whether or not the cached result is valid
```

Interface:

```scheme
(make-athunk thunk) ; Constructs a to-be-computed thunk
(adapton-add-dcg-edge! a-super a-sub) ; Adds edges to the DCG
(adapton-del-dcg-edge! a-super a-sub) ; Removes edges from the DCG
(adapton-compute a) ; Computes a thunk, performs maintenance, and returns its value
(adapton-dirty! a) ; Propagates the dirty flag to a thunk and its supercomputations
(adapton-ref val) ; Creates a ref cell with a given value
(adapton-ref-set! a val) ; Sets a ref cell to a value
```

## miniAdapton

Adapton variables act as expressions, rather than values, so that when
referenced values are updated, all usages receive that updated value. This is
implemented with thunks that `get` the referenced values.

Interface:

```scheme
; Marks a thunk as a subcomputation, if its computation occurs within a
; different thunk
(adapton-force a)
(adapt expr) ; Wraps an expression in a thunk
(adapton-memoize-l f) ; Memoizes its arg as a thunk
(adapton-memoize f) ; Memoizes its arg as a thunk and forces it
(lambda-amemo-l (args...) body...) ; ... with `lambda` syntax
(lambda-amemo (args...) body...) ; ... with `lambda` syntax
(define-amemo-l (f args...) body...) ; ... with `define` syntax
(define-amemo (f args...) body...) ; ... with `define` syntax
(define-avar name expr) ; Defines an avar and assigns it an expression
(avar-get v) ; Gets the value from evaluating the avar's expression
(avar-set! v expr) ; Sets the avar's expression
```
