# Buffered I/O library ideas

Go and Plan 9 generally have excellent standard libraries. For buffered I/O, Go
has `bufio` and Plan 9 has `libbio`.

Reading UTF-8 characters is particularly ergonomic in Go `bufio`, which I find
is often missing in other languages. I have implemented it myself in [Rust](https://github.com/thaliaarchi/lazy-wspace/commit/c1759d28064943b56dcac6b4b40bee616b9c961f)
and [Node.js](https://github.com/vii5ard/whitespace/blob/b2a65e8d7f4c1aa8d3d1a235c473a45635343ad0/ws_cli.js#L208-L230).
I have since switched to the Rust [`utf8-chars`](https://crates.io/crates/utf8-chars)
crate, which extends `io::BufRead` with a `read_char` method, but this should be
built in.

Rust [`io::BufReader::buffer`](https://doc.rust-lang.org/std/io/struct.BufReader.html#method.buffer)
allows you to get the internal buffer, which enables lower level operations. I
wish this was in Go `bufio`. I am undecided on whether the `io::BufRead` trait
is a useful pattern or too specific and rarely implemented besides
`io::BufReader`.
