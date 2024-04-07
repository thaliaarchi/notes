# Integer division and modulo rounding

Programming languages implement division and modulo with various rounding modes.
Most languages use truncated division by default. More information and
additional languages can be found on the Wikipedia article for [modulo](https://en.wikipedia.org/wiki/Modulo).

## Truncated

- C: `/` `%`
- C++: `/` `%`
- Coq:
  [`Z.quot` `Z.rem` `Z.quotrem` `Infix "÷"`](https://coq.inria.fr/library/Coq.ZArith.BinIntDef.html#lab1087)
- Go: [`/` `%`](https://go.dev/ref/spec#Integer_operators)
  [`big.Int.Quo`](https://go.dev/pkg/math/big/#Int.Quo)
  [`big.Int.Rem`](https://go.dev/pkg/math/big/#Int.Rem)
  [`big.Int.QuoRem`](https://go.dev/pkg/math/big/#Int.QuoRem)
- GMP: [`mpz_tdiv_q` `mpz_tdiv_r` `mpz_tdiv_qr`](https://gmplib.org/manual/Integer-Division)
- Haskell: [`quot`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:quot)
  [`rem`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:rem)
  [`quotRem`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:quotRem)
  (Haskell [98](https://www.haskell.org/onlinereport/basic.html#sect6.4.2)
  and [2010](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1370006.4.2))
- LLVM: [`sdiv`](https://llvm.org/docs/LangRef.html#sdiv-instruction)
  [`srem`](https://llvm.org/docs/LangRef.html#srem-instruction)
- num (Rust): [`/`](https://docs.rs/num/latest/num/struct.BigInt.html#impl-Div%3C%26%27a%20BigInt%3E)
  [`%`](https://docs.rs/num/latest/num/struct.BigInt.html#impl-Rem%3C%26%27a%20BigInt%3E)
- jq [`%`](https://github.com/stedolan/jq/blob/master/src/builtin.c#L396)
- Rug (Rust): [`/`](https://docs.rs/rug/latest/rug/struct.Integer.html#impl-Div%3C%26Integer%3E-for-Integer)
  [`%`](https://docs.rs/rug/latest/rug/struct.Integer.html#impl-Rem%3C%26Integer%3E-for-Integer)
  [`div_trunc`](https://docs.rs/rug/latest/rug/ops/trait.DivRounding.html#tymethod.div_trunc)
  [`rem_trunc`](https://docs.rs/rug/latest/rug/ops/trait.RemRounding.html#tymethod.rem_trunc)
  [`div_rem`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.div_rem)
- Rust: [`/` `%`](https://doc.rust-lang.org/stable/reference/expressions/operator-expr.html#arithmetic-and-logical-binary-operators)

## Floored

- Coq:
  [`Z.div` `Z.modulo` `Z.div_eucl` `Infix "/"` `Infix "mod"`](https://coq.inria.fr/library/Coq.ZArith.BinIntDef.html#lab1086)
  [`N.div` `N.modulo` `N.div_eucl` `Infix "/"` `Infix "mod"`](https://coq.inria.fr/library/Coq.NArith.BinNatDef.html#N.div_eucl)
- GMP: [`mpz_fdiv_q` `mpz_fdiv_r` `mpz_fdiv_qr`](https://gmplib.org/manual/Integer-Division)
- Haskell: [`div`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:div)
  [`mod`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:mod)
  [`divMod`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:divMod)
  (Haskell [98](https://www.haskell.org/onlinereport/basic.html#sect6.4.2)
  and [2010](https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1370006.4.2))
- Rug (Rust): [`div_floor`](https://docs.rs/rug/latest/rug/ops/trait.DivRounding.html#tymethod.div_floor)
  [`rem_floor`](https://docs.rs/rug/latest/rug/ops/trait.RemRounding.html#tymethod.rem_floor)
  [`div_rem_floor`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.div_rem_floor)
- Rust: [`div_floor`](https://doc.rust-lang.org/std/primitive.i32.html#method.div_floor)

## Euclidean

- Go: [`big.Int.Div`](https://go.dev/pkg/math/big/#Int.Div)
  [`big.Int.Mod`](https://go.dev/pkg/math/big/#Int.Mod)
  [`big.Int.DivMod`](https://go.dev/pkg/math/big/#Int.DivMod)
- Rug (Rust): [`div_euc`](https://docs.rs/rug/latest/rug/ops/trait.DivRounding.html#tymethod.div_euc)
  [`rem_euc`](https://docs.rs/rug/latest/rug/ops/trait.RemRounding.html#tymethod.rem_euc)
  [`div_rem_euc`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.div_rem_euc)
  [`mod_u`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.mod_u)
- Rust: [`div_euclid`](https://doc.rust-lang.org/std/primitive.i32.html#method.div_euclid)
  [`rem_euclid`](https://doc.rust-lang.org/std/primitive.i32.html#method.rem_euclid)
- SMT-LIB: [`(div Int Int)` `(mod Int Int)`](https://smtlib.cs.uiowa.edu/theories-Ints.shtml)

## Ceiling

- GMP: [`mpz_cdiv_q` `mpz_cdiv_r` `mpz_cdiv_qr`](https://gmplib.org/manual/Integer-Division)
- Rug (Rust): [`div_ceil`](https://docs.rs/rug/latest/rug/ops/trait.DivRounding.html#tymethod.div_ceil)
  [`ren_ceil`](https://docs.rs/rug/latest/rug/ops/trait.RemRounding.html#tymethod.rem_ceil)
  [`div_rem_ceil`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.div_rem_ceil)
- Rust: [`div_ceil`](https://doc.rust-lang.org/std/primitive.i32.html#method.div_ceil)

## Rounding

- Rug (Rust): [`div_rem_round`](https://docs.rs/rug/latest/rug/struct.Integer.html#method.div_rem_round)
  (not in GMP)

## Non-negative

- GMP: [`mpz_mod`](https://gmplib.org/manual/Integer-Division)
