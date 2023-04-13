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

## Version control history

The Easter egg commits at the start of the version control history were added
[by Russ Cox](https://research.swtch.com/govcs) during the migration to
Mercurial. Ken Thompson references a regret with UNIX in his commit “spell it
with an ‘e’” shortly after the public release.
