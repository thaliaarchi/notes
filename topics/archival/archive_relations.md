# Notes on archive relations

In a .tar or .zip, there is no notion of hardlinks (verify), so the structure is
a tree, not a graph. Archives usually only have mtimes.

If a file is newer than its parent directory, then it has been present at least
since the directory was modified. It also implies the existence of an earlier
version of the file in the same directory, from no later than the parent's
mtime.

If a directory and its contents have the same timestamp, can it be considered
wholly unmodified?

An archive, where files, when sorted, have increasing timestamps may indicate,
that the tree originated from another archive. First sort filenames, matching
the order used by archiving utilities (alphabetical has been observed in old
Inferno snapshots).
