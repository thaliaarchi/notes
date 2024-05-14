# Optimizing Datalog

## Tail call optimization

Tail call optimization seems to work with Datalog.

```datalog
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

In this ancestor rule like this, the second rule recurs. It could be tail-call
optimized as such. The `ancestor` relation starts out empty as it has no facts.
First, query `parent(X, Y)` and make two copies, `parents` and `ancestors`.
Rename the columns of `parents` to `X` and `Z` and of `ancestors` to to `Y` and
`Z`. Then in a loop, perform an natural join on `parents` and `ancestors` and
add a projection of it to `ancestors`. Exit the loop when no facts are added to
`ancestors`.

I suspect a more general case could be achieved with dominator analysis.

## Indexes

As a refinement of the above example, the natural join can be computed much more
efficiently by indexing both tables by the keys for the natural join. Then, the
both indexes can be iterated in parallel, scanning to keys that appear in both.

Indexes are a table of keys and record pointers, sorted by the key.

```
get_ancestors():
  parents := get_parents().rename(["X", "Z"])
  ancestors := parents.clone().rename(["Z", "Y"])
  parents_index := parents.index_by("Z")

  loop:
    ancestors_index := ancestors.index_by("Z")
    ancestors_size := ancestors.size()

    # Iterate over both tables in sorted order of column Z.
    parents_iter := parents_index.iter()
    ancestors_iter := ancestors_index.iter()

    loop:
      # Scan to the first record in both indexes where column Z matches.
      while parents_iter.peek().key() != ancestors_iter.peek().key():
        while parents_iter.peek().key() < ancestors_iter.peek().key():
          parents_iter.next()
        while parents_iter.peek().key() > ancestors_iter.peek().key():
          ancestors_iter.next()
      if parents_iter.eof() || ancestors_iter.eof():
        break

      # Do a cross product on the records matching the shared person.
      person = parents_iter.peek().get("Z")
      start = ancestors_iter.index()
      while parents_iter.peek().key() == person:
        ancestor := parents_iter.next().get("X")
        ancestors_iter.seek(start)
        while ancestors_iter.peek().key() == person:
          descendant := ancestors_iter.next().get("Y")
          ancestors.insert([ancestor, descendant])

    # Stop iterating once no more facts have been generated.
    if ancestors.size() == ancestors_size:
      break

  return ancestors
```

As a refinement, the next iteration only needs to scan the new ancestors from
last iteration, not all of them. The scan of new ancestors would be linear as it
is dense, but the scan of parents could adaptively use binary search, if it is
anticipated that the matching keys in it are very sparse.

## Sparse tables

For heavily inserted tables, it is likely worthwhile to make them sparse. One
approach could be to segment the table into fixed-size pages and have each space
reserve a percentage of free entries. In Postgres, this is controlled by the
fill factor.
