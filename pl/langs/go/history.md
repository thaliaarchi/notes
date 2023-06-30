# Go history

## Design

In the Google TechTalk [“The Go Programming Language”](https://www.youtube.com/watch?v=rKnDgT73v8s)
on 2009-10-30 by Rob Pike, he details the goals of Go and its design.

> ### Goals
>
> - The efficiency of a statically-typed compiled language with the ease of
>   programming of a dynamic language.
> - Safety: type-safe and memory-safe.
> - Good support for concurrency and communication.
> - Efficient, latency-free garbage collection.
> - High-speed compilation.

> ### Design principles
>
> - Keep concepts orthogonal.
>   A few orthogonal features work better than a lot of overlapping ones.
> - Keep the grammar regular and simple.
>   Few keywords, parsable without a symbol table.
> - Reduce typing. Let the language work things out.
>   No stuttering; don't want to see
>   `foo.Foo *myFoo = new foo.Foo(foo.FOO_INIT)`
>   Avoid bookkeeping.
>   But keep things safe.
> - Reduce typing. Leep the type system clear.
>   No type hierarchy. Too clumsy to write code by constructing type
>   hierarchies.
>   It can still be object-oriented.

> ### The big picture
>
> Fundamentals:
> - Clean, concise syntax.
> - Lightweight type system.
> - No implicit conversions: keep things explicit.
> - Untyped unsized constants: no more `0x80ULL`.
> - Strict separation of interface and implementation.
>
> Run-time:
> - Garbage collection.
> - Strings, maps, communication threads.
> - Concurrency.
>
> Package model:
> - Explicit dependencies to enable faster builds.

> ### What about generics?
>
> Go does not have generic types, etc.
>
> We don't yet understand the right semantics for them given Go's type system
> but we're still thinking. They will add complexity so must be done right.
>
> Generics would be definitely useful, though maps, slices, and interfaces
> address many common use cases.
>
> Collections can be built using the empty interface at the cost of manual
> unboxing.
>
> In short: not yet.

## Generics

At the time of the Go public release, Russ Cox [wrote about](https://research.swtch.com/generic)
the tradeoffs in approaches to generics. He discusses a tradeoff between slow
programmers, slow compilation and bloated binaries, and slow execution.

The [accepted proposal](https://go.googlesource.com/proposal/+/master/design/43651-type-parameters.md#implementation)
addresses this tradeoff:

> We believe that this design permits different implementation choices. Code may
> be compiled separately for each set of type arguments, or it may be compiled
> as though each type argument is handled similarly to an interface type with
> method calls, or there may be some combination of the two.
>
> In other words, this design permits people to stop choosing slow programmers,
> and permits the implementation to decide between slow compilers (compile each
> set of type arguments separately) or slow execution times (use method calls
> for each operation on a value of a type argument).

The technical hurdle in finding the approach that allows the compiler to use
monomorphization or fat pointers.

## Compiler and bootstrapping

The first release of the Go compiler written in Go was [Go 1.5](https://go.dev/doc/go1.5).
Before then, a custom in-tree C compiler was necessary to guarantee the C code
would work with the stack management of goroutines. The process of the new
implementation was presented at [Gopherfest 2015](https://go.dev/talks/2015/gogo.slide).

The compiler was converted in a semi-automated fashion from C to Go using tools
custom-written for the task. This process was outlined at [GopherCon 2014](https://go.dev/talks/2014/c2go.slide).
One large problem was the pervasive use of gotos. Rather than using a general
solution like [“An Algorithm for Structuring Flowgraphs”](https://dl.acm.org/doi/10.1145/321992.321999)
(Brenda S. Baker, 1977), which [Russ cites](https://go.dev/talks/2014/c2go.slide#40),
they handle trivial rewrites in their converter and rewrite the rest by hand.

The old in-tree C compiler is not mentioned in the current [bootstrapping docs](https://go.dev/doc/install/source#go14),
so I assume it's use is probably automated and unnecessary to mention.

The SSA backend was [proposed in 2015](https://docs.google.com/document/d/1szwabPJJc4J-igUZU4ZKprOrNRNJug2JPD8OYi3i1K0/edit),
motivated by the translation to Go, introduced for 64-bit x86 systems in
[Go 1.7](https://go.dev/doc/go1.7#compiler), and completed for all architectures
in [Go 1.8](https://go.dev/doc/go1.8#compiler).

## Possible influence of xoc, an extension-oriented compiler

Russ Cox, Tom Bergan, Austin Clements, Frans Kaashoek, and Eddie Kohler built
[xoc](https://pdos.csail.mit.edu/archive/xoc/), an extension-oriented compiler,
in the Parallel & Distributed Operating Systems Group at MIT. It was detailed in
ASPLOS 2008, Austin Clements's master's thesis, and Russ Cox Ph.D. thesis.

Russ Cox's personal page [links to xoc](http://web.archive.org/web/20080317094230/http://swtch.com:80/~rsc/),
but when Go was released, the destination was [replaced](http://web.archive.org/web/20091215124447/http://swtch.com:80/~rsc)
with golang.org, keeping the same text of “xoc (a new compiler)”. (The original
link was [restored](http://web.archive.org/web/20100724161716/http://swtch.com:80/~rsc/)
a year later and marked as unsupported.) This may imply that Go has lineage from
xoc. Russ and Austin have both been on the core Go team since before the public
release, so design decisions have certainly been influenced by their work on
xoc. Perhaps some of the technical details in how they implement abstractions on
top of C were used in Go, as well as the philosophy of staying close to C.

When I asked Russ, he said xoc had no direct influence on Go:

> That must have been an editing error. There was no secret message implied. Xoc
> did not directly influence Go, but they share the motivation of trying to
> improve the language support available for writing systems programs. I got to
> know Austin in grad school working on xoc and recruited them to Google and Go.
>
> —Russ Cox, 6 Jun 2023 08:38:40 -0400

## Version control history

The Easter egg commits at the start of the version control history were added
[by Russ Cox](https://research.swtch.com/govcs) during the migration to
Mercurial. Ken Thompson references a regret with UNIX in his commit “spell it
with an ‘e’” shortly after the public release.
