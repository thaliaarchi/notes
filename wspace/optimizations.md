# Optimizations

## Loop idioms

### Popcount

LLVM [transforms](https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Scalar/LoopIdiomRecognize.cpp#L1449)
this loop into the popcount instruction:

```c
for (cnt = init; x != 0; cnt++) {
  x &= (x - 1);
}
```

I want to also recognize this more naïve version:

```c
for (cnt = init; x != 0; x >>= 1) {
  cnt += x & 1;
}
```
