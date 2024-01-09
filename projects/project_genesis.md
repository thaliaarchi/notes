# Project genesis

- Goal: Extract V8 and SpiderMonkey RegExp engines into standalone libraries,
  then add them to rebar.
- Goal: Port Shumway RegExp handling to Rust, manipulating the pattern given to
  regress ([ruffle#14651](https://github.com/ruffle-rs/ruffle/issues/14651#issuecomment-1882529719)).
  Add RegExp tests from other Flash emulators.
- Goal: Convert between arbitrary regex dialects.
  1. Parse Rust `regex` syntax in separate crate, using an arena AST and minimal
     allocations. This could be contributed to `regex-syntax`.
  2. Add support for other dialects.
  3. Convert between dialects like Shumway and Scala.js.
