# GraalVM papers

GraalVM papers, particularly pertaining to IR design, filtered from the list of
[GraalVM publications](https://www.graalvm.org/community/publications/).

## 2020

- Jan Ehmueller, Alexander Riese, Hendrik Tjabben, Fabio Niephaus, Robert
  Hirschfeld [Polyglot Code Finder](https://doi.org/10.1145/3397537.3397559) In
  *Proceedings of the Programming Experience 2020 (PX/20) Workshop, companion
  volume to International Conference on the Art, Science, and Engineering of
  Programming (‹Programming›)*
  - [Hasso-Plattner-Institut, Universität Potsdam](https://hpi.de/)
  - Summary (7 pages)
    - Language-agnostic code searching in an IDE
    - Keyword-based and input-to-output transformation rule searches

- [Raphael Mosaner](https://ssw.jku.at/General/Staff/Mosaner/) [Machine Learning
  to Ease Understanding of Data Driven Compiler
  Optimizations](https://dl.acm.org/doi/10.1145/3426430.3429451) In *Proceedings
  of SPLASH Companion 2020*
  - Institute for System Software, Johannes Kepler Universität Linz
  - Summary (3 pages)
    - Machine learning in GraalVM predicted code size after compilation for a
      code duplication optimization more accurately than the heuristic.
    - HotSpot, JavaScript V8, and Graal compiler do not currently use machine
      learning in dynamic compilation. LLVM is working to use reinforcement
      learning in static compilation.

## 2019

- Florian Latifi, David Leopoldseder [Practical Second Futamura
  Projection](https://dl.acm.org/citation.cfm?id=3361077) *In Proceedings
  Companion of the 2019 ACM SIGPLAN International Conference on Systems,
  Programming, Languages, and Applications: Software for Humanity*
  - Institute for System Software, Johannes Kepler Universität Linz
  - 3 pages

## 2018

- David Leopoldseder, Roland Schatz, Lukas Stadler, Manuel Rigger, Thomas
  Wuerthinger, Hanspeter Moessenboeck [Fast-Path Loop Unrolling of Non-Counted
  Loops to Enable Subsequent Compiler
  Optimizations](https://dl.acm.org/citation.cfm?id=3237013) In *Proceedings of
  the 15th International Conference on Managed Languages & Runtimes, Article No.
  2 (ManLang’18)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 13 pages

## 2016

- Manuel Rigger, Matthias Grimmer, Christian Wimmer, Thomas Würthinger,
  Hanspeter Mössenböck [Bringing low-level languages to the JVM: efficient
  execution of LLVM IR on Truffle](https://doi.org/10.1145/2998415.2998416) In
  *Proceedings of the 8th International Workshop on Virtual Machines and
  Intermediate Languages (VMIL 2016)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 10 pages

- Manuel Rigger [Sulong: Memory Safe and Efficient Execution of LLVM-Based
  Languages](http://ssw.jku.at/General/Staff/ManuelRigger/ECOOP16-DS.pdf) *ECOOP
  2016 Doctoral Symposium*
  - Institute for System Software, Johannes Kepler Universität Linz
  - 8 pages

- Manuel Rigger, Matthias Grimmer, Hanspeter Mössenböck [Sulong - Execution of
  LLVM-Based Languages on the
  JVM](http://2016.ecoop.org/event/icooolps-2016-sulong-execution-of-llvm-based-languages-on-the-jvm)
  *Int. Workshop on Implementation, Compilation, Optimization of Object-Oriented
  Languages, Programs and Systems (ICOOOLPS’16)*

## 2015

- Matthias Grimmer, Chris Seaton, Roland Schatz, Thomas Würthinger, Hanspeter
  Mössenböck [High-performance cross-language interoperability in a
  multi-language runtime](http://dx.doi.org/10.1145/2936313.2816714) In
  *Proceedings of the 11th Symposium on Dynamic Languages (DLS 2015)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 13 pages

- Matthias Grimmer, Chris Seaton, Thomas Würthinger, Hanspeter Mössenböck
  [Dynamically composing languages in a modular way: supporting C extensions for
  dynamic languages](http://dx.doi.org/10.1145/2724525.2728790) In *Proceedings
  of the 14th International Conference on Modularity (MODULARITY 2015)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 13 pages

- David Leopoldseder, Lukas Stadler, Christian Wimmer, Hanspeter Mössenböck
  [Java-to-JavaScript translation via structured control flow reconstruction of
  compiler IR](http://dx.doi.org/10.1145/2816707.2816715) In *Proceedings of the
  11th Symposium on Dynamic Languages (DLS 2015)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 13 pages

- Michael L. Van De Vanter [Building debuggers and other tools: we can “have it
  all”](http://dx.doi.org/10.1145/2843915.2843917) In *Proceedings of the 10th
  Workshop on Implementation, Compilation, Optimization of Object-Oriented
  Languages, Programs and Systems (ICOOOLPS ‘15)*
  - Oracle Labs
  - 3 pages

## 2014

- [Matthias Grimmer](https://ssw.jku.at/General/Staff/Grimmer/)
  [High-performance language interoperability in multi-language
  runtimes](http://dx.doi.org/10.1145/2660252.2660256) In *Proceedings of the
  companion publication of the 2014 ACM SIGPLAN conference on Systems,
  Programming, and Applications: Software for Humanity (SPLASH ‘14)*
  - Institute for System Software, Johannes Kepler Universität Linz
  - 3 pages

- Christian Humer, Christian Wimmer, Christian Wirth, Andreas Wöß, Thomas
  Würthinger [A domain-specific language for building self-optimizing AST
  interpreters](http://dx.doi.org/10.1145/2658761.2658776)
  [[2]](http://lafo.ssw.uni-linz.ac.at/papers/2014_GPCE_TruffleDSL.pdf) In
  *Proceedings of the 2014 International Conference on Generative Programming:
  Concepts and Experiences (GPCE 2014)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 10 pages

- Thomas Würthinger [Graal and truffle: modularity and separation of concerns as
  cornerstones for building a multipurpose
  runtime](http://dx.doi.org/10.1145/2584469.2584663) In *Proceedings of the
  companion publication of the 13th international conference on Modularity
  (MODULARITY ‘14)*
  - Oracle Labs
  - Summary (1 page)
    - Multi-language runtimes still cannot provide high performance for each
      language and lag behind single-language runtimes. Truffle aims to solve
      this.
    - Guest languages communicate to the host via an interpreter written in the
      host language, not by generating bytecodes. Machine code derived via
      partial evaluation agnostic to guest languages. Compiler and GC are
      guest-language-agnostic.
    - Languages share the same heap and can reference cross-language values.

## 2013

- Thomas Würthinger, Christian Wimmer, Andreas Wöß, Lukas Stadler, Gilles
  Duboscq, Christian Humer, Gregor Richards, Doug Simon, Mario Wolczko [One VM
  to rule them all](http://dx.doi.org/10.1145/2509578.2509581)
  [[2]](http://lafo.ssw.uni-linz.ac.at/papers/2013_Onward_OneVMToRuleThemAll.pdf)
  In *Proceedings of the 2013 ACM international symposium on New ideas, new
  paradigms, and reflections on programming & software (Onward! 2013)*
  - Oracle Labs; Institute for System Software, Johannes Kepler Universität
    Linz; S<sup>3</sup> Lab, Purdue University
  - 18 pages

- Gilles Duboscq, Thomas Würthinger, Lukas Stadler, Christian Wimmer, Doug
  Simon, Hanspeter Mössenböck [An intermediate representation for speculative
  optimizations in a dynamic
  compiler](http://dx.doi.org/10.1145/2542142.2542143) In *Proceedings of the
  7th ACM workshop on Virtual machines and intermediate languages (VMIL ‘13)*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 10 pages

- Gilles Duboscq, Lukas Stadler, Thomas Würthinger, Doug Simon, Christian
  Wimmer, Hanspeter Mössenböck [Graal IR: An Extensible Declarative Intermediate
  Representation](http://ssw.jku.at/General/Staff/GD/APPLC-2013-paper_12.pdf) In
  *Proceedings of the Asia-Pacific Programming Languages and Compilers Workshop,
  2013*
  - Institute for System Software, Johannes Kepler Universität Linz; Oracle Labs
  - 9 pages

## 2012

- Thomas Würthinger, Andreas Wöß, Lukas Stadler, Gilles Duboscq, Doug Simon,
  Christian Wimmer [Self-optimizing AST
  interpreters](http://dl.acm.org/citation.cfm?doid=2384577.2384587) In
  *Proceedings of the 8th symposium on Dynamic languages (DLS ‘12)*
  - Oracle Labs; Institute for System Software, Johannes Kepler Universität Linz
  - 10 pages

- Christian Wimmer, Thomas Würthinger [Truffle: a self-optimizing runtime
  system](http://dx.doi.org/10.1145/2384716.2384723) In *Proceedings of the 3rd
  annual conference on Systems, programming, and applications: software for
  humanity (SPLASH ‘12)*
  - Oracle Labs in collaboration with the Institute for System Software,
    Johannes Kepler Universität Linz
  - Summary (2 pages)
    - Language implementors write AST interpreters with the Truffle framework.
    - The tree is specialized while interpreting with type feedback and
      profiling information, then, once stable, is partial-evaluated by Graal to
      optimized machine code.
    - Deoptimization triggered whenever the Truffle AST would be changed.
    - Most closely related to PyPy, but PyPy uses a trace-based JIT, while
      Truffle uses a traditional method-based JIT. The dynamic AST replacements
      in Truffle give it the benefit of trace compilers (compiling only
      specialized fast paths), while avoiding many of the problems (e.g.,
      handling recursive methods, complicated trace tree merging to avoid code
      explosion, and trace recording overhead).
