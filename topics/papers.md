http://matt.might.net/articles/cesk-machines/

> The CESK machine is a state-machine in which each state has four
> components: a (C)ontrol component, an (E)nvironment, a (S)tore and a
> (K)ontinuation. One might imagine these respectively as the
> instruction pointer, the local variables, the heap and the stack.

...

> ```bnf
> lam ::= (λ (var1 ... varN) exp)
>
> aexp ::= lam
>       |  var
>       |  #t  |  #f
>       |  integer
>       |  (prim aexp1 ... aexpN)
>
> cexp ::= (aexp0 aexp1 ... aexpN)
>       |  (if aexp exp exp)
>       |  (call/cc aexp)
>       |  (set! var aexp)
>       |  (letrec ((var1 aexp1) ... (varN aexpN)) exp)
>
> exp ::= aexp
>      |  cexp
>      |  (let ((var exp)) exp)
>
> prim ::= +  |  -  |  *  |  =
> ```

Is `call/cc` like WS `jmp` as opposed to WS `call`?

## Abstracting Abstract Machines

http://matt.might.net/papers/vanhorn2010abstract.pdf

> With no recursive structure in the state-space, an abstract machine
> becomes eligible for conversion into an abstract interpreter through a
> simple structural abstraction.

Values in the heap can refer to other values in the heap, thus being
recursively defined. This doesn't mean that the heap itself is
recursive, or by extension, the store? The heap is just a flat address
space, so I don't think it would be recursive.

## Improving Flow analysis via GammaCFA

http://matt.might.net/papers/might2006gcfa.pdf
