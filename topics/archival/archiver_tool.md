# Archiver tool

I want to build an archival tool for indexing Internet Archive snapshots, web
content, and version control repositories, that analyzes a history of changes.
It could potentially be named `archi`.

## HTTP archival

Caching of IA snapshots and archival of live snapshots can be treated similarly.

### Internet Archive

I need good caching for IA content, to avoid frequent retrieval. The WARC and
HTTP headers would be stored together as a file at
`~/.archive/http/<url>/<timestamp>`, including prefix lines for metadata of
where the record was downloaded. The bodies would be stored in
`~/.archive/objects`. The `url` field would be normalized similarly to `urlkey`,
but be represented as nested dirs.

CDX API records should be recorded in a log file, sorted by the urlkey and
timestamp. Never-before queried results can be inserted at the position after
the first line and before the last line.

I should make a polished crate for working with the documented and undocumented
IA APIs.

### Live snapshots

Live webpage snapshots could also be captured and stored in the cache,
coexisting with IA content at `~/.archive/http/<url>/<timestamp>`, including
prefix lines stating that it's a live capture. It should capture the same data
as IA, even though 3rd-party WARC uploads [generally](https://www.reddit.com/r/Archiveteam/comments/oi6i96/archivebot_sending_warc_files_to_the_wayback/)
aren't imported to the Wayback Machine.

### Downloader

It would download in parallel and track failed downloads. For failed IA
requests, if the snapshot exists, it should retry. For failed live requests, the
response should be saved with WARC-compatible metadata, and, depending on the
status code, should try again later.

## Git archival

It would be useful to archive dated snapshots of Git repositories, to be able to
show a history of Git histories. A Git archive would be an archive of all blobs
and snapshot-dated versions of all branches, tags, and the reflog. A history
snapshot could be reconstructed by exporting snapshot's branches and tags, and
the reachable commits, in a [git fast-export format](https://github.com/git/git/blob/master/builtin/fast-import.c).

It should periodically and automatically pull for updates and make snapshots. In
my workflow, author and committer are not necessarily the times it was first
committed and last modified, respectively, so the time of snapshot is vital. If
the reflog is identical as the last snapshot, the repo can probably be
considered unchanged.

It could be stored at `~/.archive/git/repos/<repoid>`, where `repoid` is a
normalization of the remote URL or, if it is local-only, of the path. It would
be easiest to store it as a bare Git repo, with Git GC disabled.

Blobs would be referenced by their SHA-1 hash at
`~/.archive/.git/repos/<repoid>/objects/<sha1>`, which would be a text link to
the SHA-256 sum in the central store. To mitigate against SHA-1 collision
attacks, I could use [sha1collisiondetection](https://github.com/cr-marcstevens/sha1collisiondetection)
by Marc Stevens, which is used in git.git and [by GitHub](https://github.blog/2017-03-20-sha-1-collision-detection-on-github-com/),
or a [Rust port](https://crates.io/crates/sha1collisiondetection) of it.
sha1collisiondetection detects half of a colliding pair and can provide safe
hash to use alternatively.

Archived repos could have multiple remotes that would coexist, such as a local
working copy, a remote fork, and a remote upstream.

To enable performing actions on the archive of the repo at the working
directory, there should be a way to lookup a repo in the archive. This could use
an entry in local repos' Git config (doesn't work for remote repos)

Support of archiving other VCSs would be useful, at least for cloned snapshots
without deduplication, as well as automatic conversion to Git. Various tools for
other VCSs export using the Git fast-export format.

### Host archival

When archiving a repository, the hosting service metadata should be retrieved
and versioned alongside the repo. The hosting service should be automatically
archived on IA and the source on the Software Heritage archive (see the
[updateswh](https://github.com/rdicosmo/updateswh/blob/main/extension/updateswh.js)
browser extension for API usage).

## Analysis

Versioning files would be essential and it would track duplicated digests and
content across sites and repos. For generated HTML files, ignoring markup
changes and converting to Markdown would be useful.

It would provide a JSON schema to specify missing details for a reconstructed
Git revision history, as well as a lockfile of sorts, which would contain
important metadata for reproducibility and legacy.

It could analyze a graph of links, provide insights into the HTTP status of a
page over time, and determine the canonical version of a URL over time with
redirects. As further pages are added, they would be added to the link graph.

### Directory indexing

Archive file formats (e.g., tar, zip, WARC) should have their contents be
indexed and compared with other files (metadata and references stored at
`~/.archive/derived/<hash>`).

HTTP trees for FTP servers should be parsed and indexed as directories, to
gather more metadata and compare the entries, ignoring changes in the
dynamically generated HTML, such as from sorting direction URL parameters like
`?S=A` and `?S=D`.

A [WARC record](https://iipc.github.io/warc-specifications/specifications/warc-format/warc-1.1/)
contains WARC headers followed by the HTTP headers and body, exactly as
received. For bodies to be deduplicated, it would be helpful to decompose the
records. WARC headers and HTTP headers should be different for every request,
because of the `WARC-Date` and `Date` values, so can be stored together. Bodies
would be stored separately. Does WARC preserve the compression of bodies, i.e.,
will a gzipped file be compressed as the server compressed it in the record?

## Storage

A single version of every blob would be centrally stored in `~/.archive/objects`
and identified by a SHA-256 hash of its contents. The raw SHA-1 hashes cannot be
used, as Git object names take into account header information and IA digests
sometimes vary for equal contents.

Alternatively, files could remain in their source archive. WARC, Git, and zip
(but not tar) have random access to files, so blobs could reference the file
contained in the archive by byte offsets. However, this would lead to
cross-archive duplication. Archives have a single version of a project and WARC
files are assembled of snapshots from around the same time, so have little
inter-archive duplication, but lots of cross-archive duplication (they
conceptually resembles a commit).

For Git repos, duplication is less relevant, as they are usually more
self-contained, except for forks, but is still useful to analyze for.

Perhaps Git packfile-style compression could be used.

### File normalization

Normalize files in various ways, recording the hashes in
`~/.archive/derived/<hash>` with a bidirectional reference to the source file
and the transformation performed. The reference should be bidirectional, so
that, if a normalization algorithm is added, changed, or removed, an iteration
over source files could update its normalizations. Derived versions are not
stored for space reasons, as they can easily be recomputed.

Automatic file normalization strategies:
- Line ending normalization (caveat: how to handle mixed LF/CRLF/CR files?)
- Language AST equivalence or language-aware comment removal
- HTML/Markdown text extraction
- Decompression

Content extraction strategies:
- HTML code block extraction
- HTML element extraction

## Interface

Instead of building all tools in-tree, it could expose a CLI like `git log` and
`git show`.

## Internet Archive documentation

- [Internet Archive Developer Portal](https://archive.org/developers/): IA
  developer resources; mostly oriented towards collections, not the Wayback
  Machine.
- File formats
  - [WARC and CDX specifications](https://iipc.github.io/warc-specifications/)
  - [An introduction to WARC](https://archive-it.org/blog/post/the-stack-warc-file/)
- Wayback Machine APIs
  - [API docs (2013)](https://archive.org/help/wayback_api.php)
  - CDX (Capture Index)
    - [Wayback CDX Server API](https://archive.org/developers/wayback-cdx-server.html)
      [[docs source](https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server)]
    - [Differences between v1 and v2](https://github.com/edgi-govdata-archiving/wayback/issues/8)
    - Wayback Machine CDX image shards are privately stored in the [waybackcdx](https://archive.org/details/waybackcdx)
      collection.
    - sortkey is in [SURT form](http://crawler.archive.org/articles/user_manual/glossary.html#surt)
      (Sort-friendly URI Reordering Transform), which is implemented in the
      [webarchive-commons org.archive.url package](https://github.com/iipc/webarchive-commons/tree/master/src/main/java/org/archive/url)
      and the [internetarchive/surt Python port](https://github.com/internetarchive/surt).
  - Memento
    - Fully compliant with the [Memento protocol](http://timetravel.mementoweb.org/guide/api/)
    - [Examples (2013)](https://ws-dl.blogspot.com/2013/07/2013-07-15-wayback-machine-upgrades.html)
  - [Availability JSON](https://archive.org/help/wayback_api.php)
  - Save Page Now
    - Limits requests to 15 per minute, or it will block your IP for 5 minutes
      [(as of 2019)](https://archive.org/details/toomanyrequests_20191110)

## Internet Archive tools

- Lists
  - IIPC's [Awesome Web Archiving](https://github.com/iipc/awesome-web-archiving)
  - [Archive Team's list of tools to restore a site from the Wayback Machine](https://wiki.archiveteam.org/index.php/Restoring)
- Tools
  - [edgi-govdata-archiving/wayback](https://github.com/edgi-govdata-archiving/wayback)
    [[docs](https://wayback.readthedocs.io/en/stable/index.html)]: Python API to
    the Wayback Machine.
  - [ArchiveBox](https://github.com/ArchiveBox/ArchiveBox): Self-hosted archival
    tool.
  - [OutbackCDX](https://github.com/nla/outbackcdx): RocksDB-based CDX server
    for web archives, that's used by national libraries with millions of
    records. Works with OpenWayback (XML) and pywb (JSON) CDX protocols.
  - IA [cdx-summary](https://github.com/internetarchive/cdx-summary): Python CLI
    to summarize CDX files.
  - IIPC [jwarc](https://github.com/iipc/jwarc): WARC parser and writer.
  - IIPC [urlcanon](https://github.com/iipc/urlcanon): Python URL parser,
    browser-style URL canonicalizer, and SSURT (improved SURT).
- Source of IA projects:
  - IA [Heritrix](https://github.com/internetarchive/heritrix3) [[API docs](http://crawler.archive.org/apidocs/overview-summary.html)]:
    IA's web crawler.
  - [webrecorder/pywb](https://github.com/webrecorder/pywb) [[docs](https://pywb.readthedocs.io/en/latest/)]:
    Provides the basic functionality of a Wayback Machine.
  - IIPC [OpenWayback](https://github.com/iipc/openwayback) [[source](https://netpreserve.org/web-archiving/openwayback/)
    [wiki](https://github.com/iipc/openwayback/wiki)]: Project to build the
    Wayback Machine (no longer under development and recommends pywb).
- Rust crates
  - [wayback-rs](https://crates.io/crates/wayback-rs) [[source](https://github.com/travisbrown/wayback-rs)]:
    Downloader using the CDX v1 API. Saves pages with the Save Page Now API as
    an authenticated user. Guesses the body of a redirect and checks it against
    the digest, to reduce API calls. Handles retries and redirects.
  - [wayback-urls](https://crates.io/crates/wayback-urls) [[source](https://github.com/Xiphoseer/wayback)]:
    URL builder for Wayback Machine CDX v2 (timemap) API.
  - [wayback-mirror](https://crates.io/crates/wayback-mirror) [[source](https://github.com/jonas-schievink/wayback-mirror)]:
    Simple downloader for Wayback Machine CDX v1 API.
  - [wayback-archiver](https://crates.io/crates/wayback-archiver) [[source](https://github.com/bcongdon/wayback-archiver)]:
    CLI that saves pages with the Save Page Now API. Has good API status code
    handling.
  - [warc](https://crates.io/crates/warc) [[source](https://github.com/jedireza/warc)]:
    Reader and writer for WARC files.
  - [warc_nom_parser](https://github.com/sbeckeriv/warc_nom_parser) [[source](https://crates.io/crates/warc_parser)]:
    Small reader for WARC files using nom.
  - [rust_warc](https://crates.io/crates/rust_warc) [[source](https://crates.io/crates/rust_warc)]:
    Small reader for WARC files.
