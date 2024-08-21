# Compiler optimization patterns

## Loop counter

```go
n := 255
for i := 0; i < 255; i++ {
  n--
  f(255-n)
}
```

```go
n := 0
for i := 0; i < 255; i++ {
  n++
  f(n)
}
```

```go
for i := 0; i < 255; i++ {
  f(i)
}
```

## [Sum as bitwise operations](https://www.reddit.com/r/programminghorror/comments/t8spag/what_in_the_sum/)

```go
func sum(a, b int) {
  for b != 0 {
    c := a & b
    a = a ^ b
    b = c << 1
  }
  return a
}
```

### SWAR for nibbles

```rust
x >= 0xa0 || 0x0a <= x && x <= 0x0f
// ==>
(if x > 0x0f { x >> 4 } else { x }) >= 0x0a
```
