# Division and modulo rounding

Programming languages implement division and modulo with various rounding modes.
Most languages use truncated division, though the reference Whitespace
interpreter uses floored division. More information and additional languages can
be found on the [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation)
Wikipedia article.

Truncated:

- Haskell [`quot`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:quot)
  [`rem`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:rem)
  [`quotRem`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:quotRem)
  (Haskell [98](https://www.haskell.org/onlinereport/basic.html#sect6.4.2)
  and [2010](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1370006.4.2))
- GMP [`mpz_tdiv_q` `mpz_tdiv_r` `mpz_tdiv_qr`](https://gmplib.org/manual/Integer-Division)
- C/C++ `/` `%`
- Go [`/` `%`](https://golang.org/ref/spec#Integer_operators)
  [`big.Int.Quo`](https://golang.org/pkg/math/big/#Int.Quo)
  [`big.Int.Rem`](https://golang.org/pkg/math/big/#Int.Rem)
  [`big.Int.QuoRem`](https://golang.org/pkg/math/big/#Int.QuoRem)
- Rust [`/` `%`](https://doc.rust-lang.org/stable/reference/expressions/operator-expr.html#arithmetic-and-logical-binary-operators)
- LLVM [`sdiv`](https://llvm.org/docs/LangRef.html#sdiv-instruction)
  [`srem`](https://llvm.org/docs/LangRef.html#srem-instruction)
- jq [`%`](https://github.com/stedolan/jq/blob/master/src/builtin.c#L396)

Floored:

- Haskell [`div`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:div)
  [`mod`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:mod)
  [`divMod`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:divMod)
  (Haskell [98](https://www.haskell.org/onlinereport/basic.html#sect6.4.2)
  and [2010](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1370006.4.2))
- GMP [`mpz_fdiv_q` `mpz_fdiv_r` `mpz_fdiv_qr`](https://gmplib.org/manual/Integer-Division)

Euclidean:

- Go [`big.Int.Div`](https://golang.org/pkg/math/big/#Int.Div)
  [`big.Int.Mod`](https://golang.org/pkg/math/big/#Int.Mod)
  [`big.Int.DivMod`](https://golang.org/pkg/math/big/#Int.DivMod)
- Rust [`div_euclid`](https://doc.rust-lang.org/std/primitive.i32.html#method.div_euclid)
  [`rem_euclid`](https://doc.rust-lang.org/std/primitive.i32.html#method.rem_euclid)

Ceiling:

- GMP [`mpz_cdiv_q` `mpz_cdiv_r` `mpz_cdiv_qr`](https://gmplib.org/manual/Integer-Division)

Rounding:

Non-negative:

- GMP [`mpz_mod`](https://gmplib.org/manual/Integer-Division)
