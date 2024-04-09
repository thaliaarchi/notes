# Developing with the Internet Archive

## Documentation

- [Internet Archive Developer Portal](https://archive.org/developers/): IA
  developer resources; mostly oriented towards collections, not the Wayback
  Machine.
- File formats
  - [WARC and CDX specifications](https://iipc.github.io/warc-specifications/)
  - [An introduction to WARC](https://archive-it.org/blog/post/the-stack-warc-file/)
- Wayback Machine APIs
  - [API docs (2013)](https://archive.org/help/wayback_api.php)
  - WARC
    - WARC and ARC files seem to be stored at
      `https://archive.org/download/<filename>`, where the filename is from a
      CDX query, as indicated in [Archive-It documentation](https://support.archive-it.org/hc/en-us/articles/360015225051-Find-and-download-your-WARC-files-with-WASAPI).
      They give a 403 error, though.
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
    - [Save Page Now changelog](https://webapps.stackexchange.com/questions/151299/does-the-internet-wayback-machine-api-support-adding-a-link-to-scrape)
  - URL formats
    - [Advanced search](https://archive.org/web/web-advancedsearch.php)
    - [Wikipedia documentation](https://en.wikipedia.org/wiki/Help:Using_the_Wayback_Machine)

## Tools

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
  - IA [Heritrix](https://github.com/internetarchive/heritrix3) [[API docs](http://crawler.archive.org/apidocs/overview-summary.html)]
    [[Wikipedia](https://en.wikipedia.org/wiki/Heritrix)]: IA's web crawler.
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

## Other archives

- ArchiveTeam
  - [icka](https://github.com/osm/icka): IRCCloud keep-alive, for ArchiveTeam
    IRC channels.
- Archive-It
  - [Web Archiving Systems API (WASAPI)](https://support.archive-it.org/hc/en-us/articles/360015225051-Find-and-download-your-WARC-files-with-WASAPI):
    Querying and downloading WARCs from Archive-It.
  - [grab-site](https://github.com/ArchiveTeam/grab-site): Web crawler to
    recursively crawl a site interactively with a dashboard from a URL and write
    WARCs, using a fork of wpull.
  - [Wpull](https://github.com/ArchiveTeam/wpull): Wget-compatible (remake) web
    crawler and downloader.
- [Time Travel](https://timetravel.mementoweb.org/): Find mementos in IA,
  Archive-It, the British Library, archive.today, GitHub, and more.
