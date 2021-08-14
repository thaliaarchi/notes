# Haskell notes

`stdin` and `stdout` [translate](https://hackage.haskell.org/package/base-4.15.0.0/docs/System-IO.html#g:25)
LF to CRLF on Windows because they are text-mode `Handle`s.

`putChar` used to print the value mod 256 as a byte.

`ghc --show-iface file.hi` dumps an interface file in human-readable
form. The .h source cannot be recovered from a .hi/.o pair.

Default values for `localeEncoding`: On Linux it is the `LANG` and
`LC_*` environment variables. On Windows it is code page.

## Relevant GHC changelog

Changes related to I/O, especially encodings, arbitrary-precision
integers, and building GHC:

- [GHC 9.0.1](https://downloads.haskell.org/~ghc/9.0.1/docs/html/users_guide/9.0.1-notes.html):

  > Windows: New IO Manager.
  >
  > A new I/O manager (WinIO) is now available as a community technical
  > preview which is designed to allow experimentation and bootstrapping
  > of third-party packages such as Network. The new I/O manager is off
  > by default and can be enabled with the RTS flag
  > `--io-manager=native`. Currently the I/O manager is *unoptimized*
  > and is focused more on correctness. There is also no support for
  > pipes and sockets. These will be added in the next release.
  > [\*see more\*](https://www.youtube.com/watch?v=kgNh5mdZ1xw).

  > Big-number support
  >
  > - GHC now relies on a new `ghc-bignum` package to provide
  >   Integer/Natural implementations. This package supports the
  >   following backends:
  >
  >   - gmp: adapted from integer-gmp package that was used before
  >   - native: new Haskell implementation, faster than `integer-simple`
  >     which is not used anymore
  >
  > - All backends now use the same representation for big numbers (the
  >   one that was previously used only by `integer-gmp`). It led to
  >   several compiler simplifications, performance improvements and bug
  >   fixes (e.g. #15262, #15286).
  >
  > - All backends must provide exactly the same set of functions with
  >   deterministic results so that they can be tested one against the
  >   other (they can only differ in performance). As a consequence,
  >   some functions that were only provided by integer-gmp (prime test,
  >   secure powmod, etc.) are no longer provided by ghc-bignum. Note
  >   that other packages (e.g. `hgmp`) provide these functions.
  >
  > - For now GHC still doesn’t allow dynamic selection of the
  >   `ghc-bignum` backend to use.

  > Support for 32-bit Windows has officially been dropped as Microsoft
  > has formally discontinued new 32-bit Windows 10 releases in 2020.
  > See [#18487](https://gitlab.haskell.org/ghc/ghc/issues/18487) for
  > details.

- [GHC 8.10.5](https://downloads.haskell.org/~ghc/8.10.5/docs/html/users_guide/8.10.5-notes.html):

  > First-class support for Apple M1 hardware using GHC’s LLVM ARM
  > backend

- [GHC 8.10.1](https://downloads.haskell.org/~ghc/8.10.1/docs/html/users_guide/8.10.1-notes.html):

  > The LLVM backend of this release is to be used with LLVM 9.

- [GHC 8.8.1](https://downloads.haskell.org/~ghc/8.8.1/docs/html/users_guide/8.8.1-notes.html):

  > The LLVM backend of this release is compatible with LLVM 7.

- [GHC 8.6.1](https://downloads.haskell.org/~ghc/8.6.1/docs/html/users_guide/8.6.1-notes.html):

  > Programs are no longer constrained by the Windows `MAX_PATH` file
  > path length limit. The file path limit is now approximately 32,767
  > characters. Note that GHC itself is still somewhat limited due to
  > GCC not supporting file namespaced paths. Paths that are passed
  > directly to the compiler, linker or other GNU tools are currently
  > still constrained. See
  > [File paths under Windows](https://downloads.haskell.org/~ghc/8.6.1/docs/html/users_guide/win32-dlls.html#windows-file-paths)
  > for details.

  > Underscores in numeric literals (e.g. `1_000_000`), enabled with
  > [`NumericUnderscores`](https://downloads.haskell.org/~ghc/8.6.1/docs/html/users_guide/glasgow_exts.html#extension-NumericUnderscores).
  > See [Numeric underscores](https://downloads.haskell.org/~ghc/8.6.1/docs/html/users_guide/glasgow_exts.html#numeric-underscores)
  > for the full details.

- [GHC 8.4.1](https://downloads.haskell.org/~ghc/8.4.1/docs/html/users_guide/8.4.1-notes.html):

  > LLVM code generator (e.g. `-fllvm`) compatible with LLVM releases in
  > the 5.0 series.

- [GHC 8.0.1](https://downloads.haskell.org/~ghc/8.0.1/docs/html/users_guide/8.0.1-notes.html):

  > The LLVM code generator now supports only LLVM 3.7. This is in
  > contrast to our previous policy where GHC would try to support a
  > range of LLVM versions concurrently. We hope that by supporting a
  > narrower range of versions we can provide more reliable support for
  > each.

- [GHC 7.10.1](https://downloads.haskell.org/~ghc/7.10.1/docs/html/users_guide/release-7-10-1.html):

  > The integer-gmp package has been completely rewritten from the
  > ground up. The primary change in this rewrite is that GHC-compiled
  > programs that link to GMP no longer 'hook' GMP allocation routines,
  > to create an Integer on the raw Haskell heap. Instead, integer-gmp
  > now allocates all memory in Haskell code, and talks to GMP via
  > normal FFI imports like other C code.
  >
  > The practical side effect of this is that C libraries which bind to
  > GMP (such as MPFR or FLINT) no longer need careful (or impossible)
  > hacks to be used inside a GHC-compiled program via the FFI; GMP is
  > treated just like any other C library, with no special
  > accomodations.

  > Added support for [binary integer literals](https://downloads.haskell.org/~ghc/7.10.1/docs/html/users_guide/syntax-extns.html#binary-literals)

  > GHC has had its internal Unicode database for parsing updated to the
  > Unicode 7.0 standard.

- [GHC 7.8.1](https://downloads.haskell.org/~ghc/7.8.1/docs/html/users_guide/release-7-8-1.html):

  > OS X Mavericks with XCode 5 is now properly supported by GHC. As a
  > result of this, GHC now uses Clang to preprocess Haskell code by
  > default for Mavericks builds.
  >
  > Note that normally, GHC used gcc as the preprocessor for Haskell
  > code (as it was the default everywhere,) which implements
  > -traditional behavior. However, Clang is not 100% compatible with
  > GCC's -traditional as it is rather implementation specified and does
  > not match any specification. Clang is also more strict.
  >
  > As a result of this, when using Clang as the preprocessor, some
  > programs which previously used -XCPP and the preprocessor will now
  > fail to compile. Users who wish to retain the previous behavior are
  > better off using cpphs as an external preprocessor for the time
  > being.
  >
  > In the future, we hope to fix this by adopting a better preprocessor
  > implementation independent of the C compiler (perhaps cpphs itself,)
  > and ship that instead.

  > GHC now has substantially better support for cross compilation. In
  > particular, GHC now has all the necessary patches to support cross
  > compilation to Apple iOS, using the LLVM backend.

  > GHC now uses Unicode left/right single quotation marks (i.e. U+2018
  > and U+2019) in compiler messages if the current locale supports
  > Unicode characters.

  > GHC >= 7.4 is now required for bootstrapping.

- [GHC 7.6.1](https://downloads.haskell.org/~ghc/7.6.1/docs/html/users_guide/release-7-6-1.html):

  > GHC >= 7.0 is now required for bootstrapping.
  >
  > Windows 64bit is now a supported platform.

- [GHC 7.4.1](https://downloads.haskell.org/~ghc/7.4.1/docs/html/users_guide/release-7-4-1.html):

  > GHC now works with LLVM version 3.0, and requires at least version
  > 2.8.

- [GHC 7.2.2](https://downloads.haskell.org/~ghc/7.2.2/docs/html/users_guide/release-7-2-2.html):

  > Incorrectly encoded text at the end of a file is now handled
  > correctly ([#5436](http://hackage.haskell.org/trac/ghc/ticket/5436)).

- [GHC 7.2.1](https://downloads.haskell.org/~ghc/7.2.1/docs/html/users_guide/release-7-2-1.html):

  > GHC >= 6.12 is now required to build GHC.
  >
  > Building with gcc 4.6 now works.

  > GHC now works with LLVM 3.0.

  > Characters in the unicode OtherNumber category are now treated as
  > being 'digit's, rather than 'other graphical' characters.

  > Unicode support has generally been improved across the core
  > libraries. This has a few consequences:
  >
  > Code that has been using the `*CString` functions may need to be
  > corrected to use the `*CAString` functions.
  >
  > Users may now observe strings — particularly those from the
  > commandline — containing private-use characters, i.e. those in the
  > range 0xEF00 to 0xEFFF inclusive.
  >
  > Programs may now get exceptions when writing strings in the wrong
  > encoding to (for example) stdout.

  > `GHC.IO.Encoding` now exports three new `TextEncodings`:
  >
  > The `fileSystemEncoding` encoding is the Unicode encoding of the
  > current locale, but allows arbitrary undecodable bytes to be
  > round-tripped through it. It is used to decode and encode command
  > line arguments and environment variables on non-Windows platforms.
  >
  > The `foreignEncoding` encoding is the Unicode encoding of the
  > current locale, but undecodable bytes are replaced with their
  > closest visual match. It's used for the `CString` marshalling
  > functions in `Foreign.C.String`.
  >
  > In the `char8` encoding Unicode code points are translated to bytes
  > by taking the code point modulo 256. When decoding, bytes are
  > translated directly into the equivalent code point. This encoding is
  > also exported by `System.IO`.
  >
  > The functions to make TextEncodings now have mk* variants which take
  > a CodingFailureMode argument. The new functions, together with what
  > they generalise, are:
  >
  > |                          |                  |                    |
  > | ------------------------ | ---------------- | ------------------ |
  > | `GHC.IO.Encoding.Latin1` | `latin1`         | `mkLatin1`         |
  > | `GHC.IO.Encoding.Latin1` | `latin1_checked` | `mkLatin1_checked` |
  > | `GHC.IO.Encoding.UTF8`   | `utf8`           | `mkUTF8`           |
  > | `GHC.IO.Encoding.UTF8`   | `utf8_bom`       | `mkUTF8_bom`       |
  > | `GHC.IO.Encoding.UTF16`  | `utf16`          | `mkUTF16`          |
  > | `GHC.IO.Encoding.UTF16`  | `utf16be`        | `mkUTF16be`        |
  > | `GHC.IO.Encoding.UTF16`  | `utf16le`        | `mkUTF16le`        |
  > | `GHC.IO.Encoding.UTF32`  | `utf32`          | `mkUTF32`          |
  > | `GHC.IO.Encoding.UTF32`  | `utf32be`        | `mkUTF32be`        |
  > | `GHC.IO.Encoding.UTF32`  | `utf32le`        | `mkUTF32le`        |
  >
  > Similarly, there are new `mkCodePageEncoding` and `mkLocaleEncoding`
  > generalisations of `codePageEncoding` and `localeEncoding` in
  > `GHC.IO.Encoding.CodePage`.
  >
  > `GHC.IO.Encoding.Iconv` has been similarly altered, and now only
  > exports `iconvEncoding`, `mkIconvEncoding`, `localeEncoding` and
  > `mkLocaleEncoding`.
  >
  > `GHC.IO.Encoding.Types` and `GHC.IO.Encoding` now export a new type
  > `CodingProgress` which describes the state of a text encoder. The
  > `BufferCodec`, `DecodeBuffer` and `EncodeBuffer` types have also
  > changed.

  > The Unicode data is now based on version 6.0.0 (was 5.1.0) of the
  > Unicode spec.

- [GHC 7.0.1](https://downloads.haskell.org/~ghc/7.0.1/docs/html/users_guide/release-7-0-1.html):

  > GHC now defaults to the Haskell 2010 language standard.

  > GHC now includes an LLVM code generator. For certain code,
  > particularly arithmetic heavy code, using the LLVM code generator
  > can bring some nice performance improvements.

  > GHC now understands the Haskell98 and Haskell2010 languages.

- [GHC 6.12.1](https://downloads.haskell.org/~ghc/6.12.1/docs/html/users_guide/release-6-12-1.html):

  > The I/O libraries are now Unicode-aware, so your Haskell programs
  > should now handle text files containing non-ascii characters,
  > without special effort.

  > Handle IO now supports automatic character set encoding and newline
  > translation. For more information, see the "Unicode
  > encoding/decoding" and "Newline conversion" sections in the
  > System.IO haddock docs.

  > Lazy I/O now throws an exception if an error is encountered, in a
  > divergence from the Haskell 98 spec which requires that errors are
  > discarded (see Section 21.2.2 of the Haskell 98 report). The
  > exception thrown is the usual IO exception that would be thrown if
  > the failing IO operation was performed in the IO monad, and can be
  > caught by System.IO.Error.catch or Control.Exception.catch.

  > We now require GHC >= 6.8 to build.
  >
  > We now require that gcc is >= 3.0.

  > GHC now works (as a 32bit application) on OS X Snow Leopard.
  >
  > The native code generator now works on Sparc Solaris.

- [GHC 6.6.1](https://downloads.haskell.org/~ghc/6.6.1/docs/html/users_guide/release-6-6-1.html):

  > GHC works on Windows Vista.

- [GHC 6.6](https://downloads.haskell.org/~ghc/6.6/docs/html/users_guide/release-6-6.html):

  > GHC now treats source files as UTF-8 (ASCII is a strict subset of
  > UTF-8, so ASCII source files will continue to work as before).
  > However, invalid UTF-8 sequences are ignored in comments, so ASCII
  > code with comments in, for example, Latin-1 will also work.

- [GHC 6.4](https://downloads.haskell.org/~ghc/6.4/docs/html/users_guide/release-6-4.html):

  > GHC now keeps much more accurate source locations in its internal
  > abstract syntax. By default, this results in error messages which
  > contain column numbers in addition to line numbers. e.g.
  >
  >     read001.hs:25:10: Variable not in scope: `+#'
  >
  > Additionally, you can ask GHC to report the full span (start and
  > end-location) for error messages by giving the `-ferror-spans` option
  > (See [Section 4.5, “Help and verbosity options”](https://downloads.haskell.org/~ghc/6.4/docs/html/users_guide/options-help.html)).
  > e.g.
  >
  >     read001.hs:25:10-11: Variable not in scope: `+#'

- [GHC 6.2](https://downloads.haskell.org/~ghc/6.2/docs/html/users_guide/release-6-2.html):

  > The I/O library now supports large files (>4Gb) if the underlying OS
  > supports them.

- [GHC 5.04](https://downloads.haskell.org/~ghc/5.04/docs/html/users_guide/release-5-04.html):

  > Full support for MacOS X, including fully optimized compilation, has
  > been added. Only a native code generator and support for
  > `-split-objs` is still missing. Everything else needs more testing,
  > but should work.

- [GHC 5.02](https://downloads.haskell.org/~ghc/5.02.3/docs/set/release-5-02.html):

  > Majorly improved support for Windows platforms. Binary builds are
  > now entirely freestanding. There is no longer any need to install
  > Cygwin or Mingwin to use it. It's a one-click-install-and-off-you-go
  > story now.
