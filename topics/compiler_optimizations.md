# Compiler optimization patterns

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
