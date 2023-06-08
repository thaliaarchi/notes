# Data structures for a Whitespace VM

## Heap

The heap could be implemented with a contiguous array (like the reference
implementation), with a hash table, or some other structure.

A hybrid dense and sparse structure could have an array for the values
contiguous to 0 and use a hash table otherwise. When a `store` fills a gap and a
range of values becomes adjacent to the sparse array, it could move those values
from the hash table to the sparse array. It may need a cap to the number of
values to move, or it could suffer from a denial of service.

A [Judy array](https://en.wikipedia.org/wiki/Judy_array) is an associative array
with low memory usage and supposedly high performance over any comparable data
structure. However, its implementation is extremely complex, at around 20,000
lines of code, and its performance was not much better when [compared](http://www.nothings.org/computer/judy/)
to a simple, barely optimized hash table.
