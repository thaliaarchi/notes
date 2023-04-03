# Haskell compiler feature detection

Develop a `./configure`-like tool, that detects Haskell features for specific
compiler versions, which cannot be easily detected with Whitespace programs.

For example:

- Range of `Int` with `minBound :: Int` and `maxBound :: Int`
- Maximum recursion depth of `store` before stack overflow

Other features, that would be easier to detect in Whitespace, may still be
valuable to check, such as:

- UTF-8 support
- Error messages
