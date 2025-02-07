# Notes for rustc development

## Initial setup

Setup editor (interactive process):

```sh
x setup editor
```

Customize the target to compile for in `.vscode/settings.json`. It doesn't need
to match the host.

```json
{
  // https://doc.rust-lang.org/nightly/rustc/platform-support.html
  "rust-analyzer.cargo.target": "x86_64-unknown-linux-gnu"
}
```

Install `x` tool, so `./x.py` can be used from any directory in the repo:

```sh
cargo install --path src/tools/x
```

## Using `x.py`

Also read [“How to build and run the compiler”](https://rustc-dev-guide.rust-lang.org/building/how-to-build-and-run.html)
in the Rust Compiler Development Guide.

```sh
# Build
x build

# Check
x check

# Run test
x test library/std --stage 0 --test-args display_wtf8
x test library/std --stage 0 --test-args sys_common::wtf8::tests::display_wtf8
# Corresponding to
#cargo test --package std --lib -- sys_common::wtf8::tests::display_wtf8 --exact --show-output

# Run doctests
x test library/core --stage 0 --doc --test-args str

# Run benchmark
x bench library/alloc --stage 0 --test-args from_utf8_lossy
```
