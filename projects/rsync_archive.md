# rsync archival

Goal: An rsync client which produces archival quality incremental backups of
servers.

## Implementations

- rsync at <https://github.com/RsyncProject/rsync>
- openrsync by Kristaps Dzonsons, originally at <https://github.com/kristapsdz/openrsync>,
  now maintained in OpenBSD ([CVS](https://cvsweb.openbsd.org/src/usr.bin/rsync/),
  [Git mirror](https://github.com/openbsd/src/tree/master/usr.bin/rsync))

## Documentation

- [The rsync algorithm](https://rsync.samba.org/tech_report/),
  Andrew Tridgell and Paul Mackerras (1998) [technical report]
- [Efficient Algorithms for Sorting and Synchronization](https://www.samba.org/~tridge/phd_thesis.pdf),
  Andrew Tridgell (1999) [PhD thesis]
- [How Rsync Works: A Practical Overview](https://rsync.samba.org/how-rsync-works.html)
- [Algorithm and architecture](https://github.com/kristapsdz/openrsync/blob/master/README.md#algorithm)
  documented by Kristaps Dzonsons for openrsync

## Archive design

Is full fidelity of the rsync protocol in the archive a goal? It couldn't easily
be replayed since another implementation would need to implement a similar
client. Additionally, several aspects seem to be unstable between runs.

The rsync protocol couldn't be easily fit into a WARC.

The server picks the seed of the MD4 hashing, so blocks cannot be stably
identified by their MD4 digests. This implies a structure like .git/objects/
would not work.

Is the Adler-32 checksum stable? Are block sizes stable?

For incremental backups, there are three modes of equality: metadata equality,
hash equality, and exact equality. The first two leave room for changed
contents. With the third, the client would request the full tree.

Timestamps should track the times of each file access, since there are
possibilities for race conditions.
