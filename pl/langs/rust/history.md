# Rust history

## Initial release

[“Project Servo: Technology from the past come to save the future from itself”](http://venge.net/graydon/talks/intro-talk-2.pdf)
by Graydon Hoare (2010-07-07) at the Mozilla Annual Summit 2010.

Gradon Hoare details the philosophy of Rust, particularly of reusing proven
successful approaches from past languages, rather than new research. Rust gives
roughly equal support to functional, procedural, actor, object-oriented styles.

Many things have changed since then: The actor and typestate paradigms seem to
have since been de-emphasized and made second-class, and Rust no longer controls
side effects. Arbitrary-precision numbers are no longer in the standard library.
At the time, there was just the OCaml bootstrap compiler (38kloc) with an x86
backend and an in-progress LLVM backend.
