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

## Previous implementations

I'd want to survey foundational implementations. Plan 9 tar is listed on
Wikipedia as influential, so I could use my archival work there.

I'd want to make compatibility modes, for functioning as different
implementations.
