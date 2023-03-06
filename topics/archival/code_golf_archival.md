# Code Golf archival

## Querying

To archive Code Golf answers for Whitespace, I should first query the
[Stack Exchange Data Explorer](https://data.stackexchange.com/codegolf/queries),
which is updated weekly with the content from all its sites, for
Whitespace-related posts. [For example](https://data.stackexchange.com/codegolf/query/1717592/search-for-whitespace-in-post-bodies),
with queries over the bodies of posts:

```sql
SELECT * FROM Posts WHERE Body LIKE '%Whitespace%'
```

Searching for the case-sensitive string “Whitespace” eliminates many false
positives, except for occurrences at the start of a sentence. Any posts with
“Whitespace” in a header or a link to the Whitespace site should also be
included.

It could query all posts containing Try It Online or Attempt This Online
permalinks, parse them ([Try It Online](https://github.com/TryItOnline/tryitonline/blob/master/usr/share/tio.run/frontend.js)
and [Attempt This Online source](https://github.com/attempt-this-online/attempt-this-online/blob/main/frontend/lib/urls.ts)),
and filter by those with the Whitespace language ID. This should yield no false
positives.

Code Golf Meta may possibly have relevant posts.

The dump gives posts rendered as HTML, not in the original Markdown, so those
would need to be retrieved separately, as well as prior revisions.

Quarterly data dumps are released [on the Internet Archive](https://archive.org/details/stackexchange),
which may be useful for more advanced offline processing. The Code Golf and Code
Golf Meta archives expand to around 2 GB combined. If I cache those, it should
periodically check for updates and track the last-updated time.

To detect polyglots and test Whitespace program detection heuristics, in
general, it could parse all code blocks in the quarterly dump.

For general information on Stack Exchange dumps and past dumps, see
[“Where are the Stack Exchange data dumps?”](https://meta.stackexchange.com/questions/19579/where-are-the-stack-exchange-data-dumps).

## Git repo

I should construct a single git repo for all Whitespace posts (as opposed to
repos for individual authors). Including posts makes answers self-contained,
but is not strictly necessary. Perhaps it could be structured into directories
for each question, `<question_id>-<slug>`, each containing `question.md` and
directories for each answer, `<answer-slug>`, with `answer.md`, `solution.ws`
(numbered if appropriate), etc.

Code blocks and TIO/ATO sources should be extracted into separate files in their
same commits, with automatic fixup of mangled tabs in a new commit at the end.
Automated site-wide revisions within a short time period should be coalesced.

To enable for easier navigation, it should have Markdown indexes by question
date, answer date, and author.
