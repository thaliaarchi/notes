# My notes regarding Rust `tar` and the tar format

## Annoyances with Rust `tar` for if I want to make a tar library

- Errors are strings wrapped as `io::Error`, not enums. It's a library, so they
  should be enumerated. Even internally, this is an issue: `prepare_header_path`
  in builder.rs re-checks a condition, because it can't introspect on errors.
- Header casting checks bytes to determine if it is safe to cast. As an example,
  `prepare_header` in builder.rs constructs a GNU-format header with
  `let mut header = Header::new_gnu();`, then immediately casts it to GNU with
  `header.as_gnu_mut().unwrap()`, which requires redundant checks and less type
  safety. Instead, I would use the typestate pattern, with care to not inflate
  code size via monomorphism.
- Boolean flags in `ArchiveInner` should be a bitset.
- Methods should exist on the header to get each field, choosing the most
  precise version given among the extended headers. I think Go does this while
  parsing.
- Paths should not be normalized or converted for the conventions of the host
  OS, until and only if they are used with the host filesystem. When converting
  to `Path`, `OsString::from_encoded_bytes_unchecked` could be used with
  appropriate sanitization first, to allow for more patterns of invalid UTF-8.
- Date parsing is suspicious. For base-256 numbers, it doesn't handle negative
  numbers and only uses the last 8 bytes, whereas [Go](https://github.com/golang/go/blob/f19f31f2e7c136a8dae03cbfe4f8ebbb8b54569b/src/archive/tar/strconv.go#L93-L135)
  decodes all bytes, checks for overflow, and handles negative.
- Retrieving the most precise version of each field, from the various extended
  headers, and parsing and verifying it is cumbersome.
- It doesn't seem to support PAX format.
- The rough edges and incompleteness implies a better library could be
  influential.

## Previous implementations

I'd want to survey foundational implementations. Plan 9 tar is listed on
Wikipedia as influential, so I could use my archival work there.

I'd want to make compatibility modes, for functioning as different
implementations.

An in-depth [Go issue](https://golang.org/issues/12594) describes the incorrect
assumptions made in `archive/tar`, which is useful for a historical perspective
and survey (see [the `Reader` fix](https://github.com/golang/go/blob/f19f31f2e7c136a8dae03cbfe4f8ebbb8b54569b/src/archive/tar/reader.go#L432-L460)).
It mentions the commit introducing base-256 numbers into GNU tar [in 1999](https://git.savannah.gnu.org/cgit/tar.git/commit/?id=e4e624848b53ac02f1212af2209a63d28e40afec).

### star

Schily tar (star) by Jörg Schilling is an influential and early tar
implementation. Its [man pages](https://linux.die.net/man/1/ustar) compare many
tar implementations (see `artype`). Its source is on SourceForge in [star](https://sourceforge.net/projects/s-tar/),
and possibly also [schilytools](https://sourceforge.net/projects/schilytools/)
which has more releases. [FreshPorts](https://www.freshports.org/archivers/star)
describes its benefits over other tar implementations.
