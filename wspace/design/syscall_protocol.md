# Protocol for Whitespace syscalls

A protocol for syscalls in Whitespace, similar to [PipeVM](https://github.com/lestrozi/pipevm)
(though conceived independently).

Suppose we have the following syscalls:

```rust
fn sys_open(path: &str) -> (fd: int);
fn sys_read(fd: int, addr: int, len: int) -> (n: int);
fn sys_write(fd: int, buf: &str) -> (n: int);
```

They could be expressed in Whitespace as follows:

```rust
const SYS_OPEN = 1;
const SYS_READ = 2;
const SYS_WRITE = 2;

const TMP_ADDR = 0;

fn sys_open(path: &str) -> (fd: int) {
  printc(SYS_OPEN);
  printi(path.len());
  for ch in path {
    printc(ch);
  }
  readi(TMP_ADDR);
  return retrieve(TMP_ADDR);
}

fn sys_read(fd: int, addr: int, len: int) -> (n: int) {
  printc(SYS_READ);
  printi(fd);
  printi(len);
  readi(TMP_ADDR);
  let n = retrieve(TMP_ADDR);
  for (let p = addr; p < addr + n; p++) {
    readc(p);
  }
  return n;
}

fn sys_write(fd: int, buf: &str) -> (n: int) {
  printc(SYS_WRITE);
  printi(fd);
  printi(buf.len());
  for ch in buf {
    printc(ch);
  }
  readi(TMP_ADDR);
  return retrieve(TMP_ADDR);
}
```

Multiple variants of `sys_open` could be provided with different styles of
strings for the parameter.

When the program is compiled in UTF-8 mode, int-based I/O needs to be used. In
byte mode, char-based I/O can be used.

If the tags are encoded in the Unicode private use area, it's unlikely that user
programs would use them; however, the encoding would be more expensive.

## IR

If the user cannot call builtin I/O commands (e.g., they are compiled as
syscalls), then analysis is easy. Each syscall is atomic.

If the user can initiate syscalls by hand, then analysis is more complicated. A
state value, tracking what has been passed over the protocol, needs to be
maintained.

It has the following states:

```gv
digraph states {
  start -> open0 [label="printc SYS_OPEN"];
  open0 -> open1 [label="printi len"];
  open1 -> open1 [label="printc ch (len times)"];
  open1 -> open2 [label="readi n"];
  open2 -> start [label="ε"];

  start -> read0 [label="printc SYS_READ"];
  read0 -> read1 [label="printi fd"];
  read1 -> read2 [label="printi len"];
  read2 -> read3 [label="readi n"];
  read3 -> read3 [label="readc (n times)"];
  read3 -> start [label="ε"];

  start -> write0 [label="printc SYS_WRITE"];
  write0 -> write1 [label="printi fd"];
  write1 -> write2 [label="printi len"];
  write2 -> write2 [label="printc ch (len times)"];
  write2 -> write3 [label="readi n"];
  write3 -> start [label="ε"];
}
```

Modeled something like this (with abstract values):

```rust
enum SysState {
  Start,

  OpenStart,
  OpenWithLen(Value),
  OpenWithChars(Value, Vec<Value>),

  ReadStart,
  ReadWithFd(Value),
  ReadWithLen(Value, Value),
  ReadWithN(Value, Value, Value),
  ReadWithChars(Value, Value, Value, Vec<Value>),

  WriteStart,
  WriteWithFd(Value),
  WriteWithLen(Value, Value),
  WriteWithChars(Value, Value, Vec<Value>),
  WriteWithN(Value, Value, Vec<Value>, Value),
}
```

Then rewrite rules can target these states. If an invalid transition occurs, the
code is replaced with the corresponding error that would be made by the driver.
Sub-instructions for multiple syscalls cannot be interleaved, because doing so
would be incomprehensible to the driver.

For arbitrary user implementations of these syscalls, a loop analysis would need
to transform the sequence of prints into a buffer.

egglog-ish rewrites:

```
(printc SYS_OPEN Start) ==> (sys-open-part0 Start)
(printi ?len (sys-open-part0 ?st)) ==> (sys-open-part1 ?len ?st)
(counted-loop
  ?len ; iterations
  [(sys-open-part1 ?len ?st)] ; initial IVs
  ; loop body, taking IV inputs and producing IV outputs
  (region (?st2) (printc 42 ?st2))
)
  ==> (sys-open-part2 [42, 42, ..., 42] ?st)
  (readi ?n-addr (sys-open-part2 ?buf ?st)) ==> (sys-open ?buf ?n-addr ?st)

(printc SYS_READ Start) ==> (sys-read-part0 Start)
; …
(printc SYS_WRITE Start) ==> (sys-write-part0 Start)
; …
```

It would be nice to be able to write egglog rewrite patterns as exhaustive
matches, instead of individual cases. How would this affect join ordering?
