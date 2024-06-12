# Notes on archive relations

The structure of a .tar or .zip is a tree with the exception of hardlinks, which
may make it a graph. Archives usually only have mtimes.

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

How should hardlinks affect the structure? Since a hardlink in a tar is a
separate file that links to the first, it would have have its own metadata.
Should each hardlink be considered distinct?
