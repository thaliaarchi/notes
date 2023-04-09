# Datalog with BDDs

In [“Using Datalog with Binary Decision Diagrams for Program Analysis”](https://people.csail.mit.edu/mcarbin/papers/aplas05.pdf)
(John Whaley, Dzintars Avots, Michael Carbin, and Monica S. Lam, 2005), the
authors use BDDs to power a Datalog engine, bddbddb. They show that program
analyses implemented with it are faster than hand-tuned implementations and use
dramatically fewer lines of code, and they use it to solve previously unsolved
problems like context-sensitive pointer analysis for large programs.

I might implement this myself and use it for analyses in my compiler.

The source for [bddbddb](https://bddbddb.sourceforge.net/) [[git](https://github.com/joewhaley/bddbddb)]
is available, as well as for its dependencies [JavaBDD](https://javabdd.sourceforge.net/)
[[git](https://github.com/joewhaley/javabdd)] and [joeq](https://joeq.sourceforge.net/)
[[git](https://github.com/joewhaley/joeq)].

CUDD, [BuDDy](https://buddy.sourceforge.net/manual/main.html) [[SourceForge](https://sourceforge.net/projects/buddy/)],
and [JDD](https://bitbucket.org/vahidi/jdd) are general-purpose BDD libraries.
In Rust, the crate [cudd-sys](https://crates.io/crates/cudd-sys) provides
bindings for CUDD and the crate [cudd](https://crates.io/crates/cudd) builds a
higher-level API upon that.

Similarly to bddbddb, [hsdatalog](https://github.com/chessai/hsdatalog) is a
compiler in Haskell from Datalog to relational algebra and an interpreter for
relational algebra using BDDs.
