# GraalVM 21.2 with lots of native image usability improvements

https://medium.com/graalvm/graalvm-21-2-ee2cce3b57aa

## Compiler Updates

In 21.2 there are a number of interesting optimizations added to the compiler. Let’s start with the ones available in GraalVM Enterprise, available as part of an Oracle Java SE Subscription.

One very welcome addition that landed in 21.2 is the implementation of **the class pre-definition to support `ClassLoader.loadClass` calls at run time**. Desired classes that need to be loaded at run time must be made available to the static analysis at build time so that they are included in the closed world analysis, but otherwise the code patterns that include loading classes at arbitrary moments of run time are now working in native images just as you'd expected them to.

We improved **loop limit analysis** for counted loops, so the compiler also analyzes the control flow preceding the loop to reason about the induction variables. This can make more uncounted loops, like the example one below, amendable for advanced optimizations.

```java
long i = 0;
  if (end < 1) return;
  do {
      // body
      i++;
  } while (i != end);
```

Here the compiler can combine the info from before the loop that `i` is `0` and `end ≥ 1` to prove that `end > i` and use that data for optimizing the loop body.

We also added a novel **Strip Mining** optimization for non-counted loops, enabled by default, which splits loop iteration into parts, making them easier to optimize later.

We improved compilation of the code which uses typical `StringBuilder` patterns, and enhanced support for these patterns in JDK11 based GraalVM builds by making it aware of the compact strings in JDK11.

Then in terms of GraalVM Community Edition, one notable improvement to the compiler is the addition of the **Speculative Guard Movement** optimization, which tries to move a loop invariant guard, for example, an array bounds check, from inside a loop to outside of the loop. This can improve relevant workloads dramatically.

Also, we improved **safe-point elimination mechanisms** in long counted loops. The compiler can now eliminate safe-points in loops that have a long induction variable where it can statically prove that the range of the induction variable is `Integer.MAX_VALUE - Integer.MIN_VALUE`. Consider this for-loop example:

```java
for (long i = Integer.MIN_VALUE; I < Integer.MAX_VALUE; I++) { 
  // body 
}
```

The compiler can now statically prove `i` only iterates within integer range even though it is a `long`. As a result, the integer overflow situation doesn't need to be accounted for and the loop optimizes better.

On top of these there are a few optimizations available in this release not yet enabled by default and considered experimental. One experimental optimization called **Write Sinking** tries to move writes out of loops. You can enable it with `-Dgraal.OptWriteMotion=true`. Another optimization availabel in GraalVM Enteprise, but not yet enabled by default is a novel **SIMD (Single Instruction Multiple Data)** vectorization optimization for sequential code. You can experiment with it by using the -Dgraal.VectorizeSIMD=true option. If you're not ready to experiment yourself, stay tuned — in an upcoming standalone article we're going to explore in detail what it gives you, and how your code can benefit from it.