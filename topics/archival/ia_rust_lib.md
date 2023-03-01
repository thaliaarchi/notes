# Internet Archive library in Rust

I need good caching for IA content. Since it never changes, I don't need cache
invalidation. I could store it in
`~/.ia/cache/<urlkey>/<timestamp>/{content,headers,meta}`. The `urlkey` field
has `/`s, so I'd need to escape it differently, but it would still have the same
idea of normalizing case. It would download in parallel and track failed
downloads.

Versioning files would be essential and it would track duplicated digests and
content. Archives (i.e., tar/zip) should be indexed and compared with other
files.

It would provide a JSON schema to specify missing details for a reconstructed
git revision history, as well as a lockfile of sorts, which would contain
important metadata for reproducibility and legacy. Ignoring HTML markup changes
and converting HTML to Markdown would be useful. File similarity would be useful
for cross-site comparisons.

Parsing and versioning FTP trees would be useful. I'd want to strip URL
parameters like `?S=A` and `?S=D` sorting directions.

Live webpage snapshots could also be captured and stored in the cache. It should
capture enough data to be able to upload those snapshots to IA. I should learn
the WARC spec, to see if its worth storing in WARC.

It could analyze a graph of links, provide insights into the HTTP status of a
page over time, and determine the canonical version of a URL over time with
redirects. As further pages are added, they would be added to the link graph.
