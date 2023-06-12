# Error handling

- [Lessons from Writing a Compiler](https://borretti.me/article/lessons-writing-compiler#err)
  [[HN](https://news.ycombinator.com/item?id=32100880)] and
  [Design of the Austral Compiler](https://borretti.me/article/design-austral-compiler#errors)

- [How Should Compilers Explain Problems to Developers?](https://static.barik.net/barik/publications/fse2018/barik_fse18.pdf)
  [[HN](https://news.ycombinator.com/item?id=35319824)]

- [Modular Errors in Rust](https://sabrinajewson.org/blog/errors)
  [[HN](https://news.ycombinator.com/item?id=35502874)]

## Obsolete syntax

Rust used to parse obsolete syntax, when not too difficult, and emit errors
suggesting migrations to updated syntax.

The [most kinds of unsupported syntax](https://github.com/rust-lang/rust/blob/4b266f1c0df9732bbdea44b0df3d459d4cf2756d/src/libsyntax/parse/obsolete.rs)
(36) were detected just before Rust 0.8 in 2013, after which they were gradually
removed until the mechanism was finally [deleted](https://github.com/rust-lang/rust/pull/49395)
in 2018. (Only 2 kinds were detected in 1.0.0.)
