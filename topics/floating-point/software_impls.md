# Software floating point libraries

## Berkeley SoftFloat

[Berkeley SoftFloat](http://www.jhauser.us/arithmetic/SoftFloat.html) by John
Hauser is a C library, that implements IEEE-754. The source is primarily
distributed as archives and is seemingly maintained [on GitHub](https://github.com/ucb-bar/berkeley-softfloat-3).

[Berkeley TestFloat](http://www.jhauser.us/arithmetic/TestFloat.html) tests
IEEE-compliance. [Berkeley HardFloat](http://www.jhauser.us/arithmetic/HardFloat.html)
provides Verilog implementations.

Bindings and libraries:
- [softfloat-wrapper](https://github.com/dalance/softfloat-wrapper) for Rust
  provides a high-level API using softfloat-sys.
  [[crates.io](https://crates.io/crates/softfloat-wrapper)]
- [softfloat-sys](https://salsa.debian.org/Kazan-team/softfloat-sys) for Rust
  provides FFI.
  [[crates.io](https://crates.io/crates/softfloat-sys)]
  It looks to be verified with [softfloat-verify](https://salsa.debian.org/Kazan-team/softfloat-verify).
  A fork is maintained at [tacanslabs/softfloat-sys](https://github.com/tacanslabs/softfloat-sys).
- [chipshort/softfloat-c](https://github.com/chipshort/softfloat-c) is an
  automatic conversion of SoftFloat to Rust.
- [softfloat-hs](https://github.com/GaloisInc/softfloat-hs) for Haskell.
- [wangkui0508/float128](https://github.com/wangkui0508/float128) for Go.

Forks:
- [SDL-Hercules-390/SoftFloat](https://github.com/SDL-Hercules-390/SoftFloat)
  for Hercules has more recent maintenance, but it seems to not be for
  general-purpose use.
- [tacanslabs/berkeley-softfloat-3](https://github.com/tacanslabs/berkeley-softfloat-3)
  adds Wasm build support.

## LLVM `APFloat`

`llvm::APFloat` is a C++ data type in LLVM, that implements arbitrary-precision
floats with various semantics. The sources are at
[`llvm/include/llvm/ADT/APFloat.h`](https://github.com/llvm/llvm-project/blob/main/llvm/include/llvm/ADT/APFloat.h),
[`llvm/unittests/ADT/APFloatTest.cpp`](https://github.com/llvm/llvm-project/blob/main/llvm/unittests/ADT/APFloatTest.cpp),
and [`llvm/lib/Support/APFloat.cpp`](https://github.com/llvm/llvm-project/blob/main/llvm/lib/Support/APFloat.cpp).

[`rustc_apfloat`](https://github.com/rust-lang/rustc_apfloat) is a port of it to
Rust, used in rustc and [Cranelift](https://github.com/CraneStation/rustc_apfloat).

[`ieee-apsqrt`](https://github.com/SolraBizna/ieee-apsqrt) extends
`rustc_apfloat` with square root.

## GNU MPFR

[GNU MPFR](https://www.mpfr.org/) is a C library for floating-point computations
with arbitrary precision, which is set on construction.

Rug for Rust wraps MPFR with [`Float`](https://docs.rs/rug/latest/rug/struct.Float.html).

## GCC …

…

## libm

libm is a C math library for machines that support IEEE-754 binary64. Is has
several implementations.

- [musl math](https://git.musl-libc.org/cgit/musl/tree/src/math) is the libm for
  musl-libc
- [fdlibm](https://www.netlib.org/fdlibm/) (Freely Distributable LIBM)
- [FreeMiNT FDlibm](https://github.com/freemint/fdlibm) forked from fdlibm in
  2008 and has since been maintained and expanded.
- [OpenLibm](https://openlibm.org/) was built for Julia, and works consistently
  across compilers and operating systems and in 32- and 64-bit environments.
- [FreeBSD msun](https://github.com/freebsd/freebsd-src/tree/master/lib/msun) is
  FreeBSD's math library
- CRlibm (correctly-rounded mathematical library)
  - [CRlibm.jl](https://github.com/JuliaIntervals/CRlibm.jl) wraps it for Julia
    and says that CRlibm is state-of-the-art

## simple-soft-float

[simple-soft-float](https://salsa.debian.org/Kazan-team/simple-soft-float) is
a straightforward reference implementation of IEEE-754 in Rust. It looks to be a
great reference and has excellent tests.
[[crates.io](https://crates.io/crates/simple-soft-float)]

## Other

- [starkat99/half-rs](https://github.com/starkat99/half-rs) (`half`) implements
  IEEE 754-2008 `binary16`, as well `bfloat16`, in Rust.
  [[crates.io](https://crates.io/crates/half/)]
- [huonw/float](https://github.com/huonw/float) provides an arbitrary-precision
  float type in, `Float`, in Rust using Ramp.
- [nbdd0121/softfp](https://github.com/nbdd0121/softfp) is a library in Rust.
  [[crates.io](https://crates.io/crates/softfp)]
- [wasm-float-transpiler](https://github.com/chipshort/wasm-float-transpiler)
  converts floating-point operations in WebAssembly programs to software
  implementations. It has backends for Berkeley SoftFloat, `rustc_apfloat`,
  softfp, and panicking.
- [Zeda/z80float](https://github.com/Zeda/z80float) is a library in Z80 assembly
  with IEEE-754 binary32, 80-bit extended floats, and custom binary24 and 32-bit
  formats.
- [jenska/float](https://github.com/jenska/float) implements 80-bit extended
  floats in Go and is derived from Berkeley SoftFloat.

## Tests and benchmarks

- [Berkeley TestFloat](http://www.jhauser.us/arithmetic/TestFloat.html)
- FreeMiNT FDlibm [tests](https://github.com/freemint/fdlibm/tree/master/tests)
- simple-soft-float [tests](https://salsa.debian.org/Kazan-team/simple-soft-float/-/tree/master/test_data)
- [Benchmark](https://github.com/dalance/softfloat_bench) of softfloat-sys,
  simple-soft-float, and Rug `Float`

## TODO

Fully list libraries from [this thread](https://stackoverflow.com/questions/2186788/is-there-an-open-source-c-c-implementation-of-ieee-754-operations).
