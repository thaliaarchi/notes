# Pike–Levenshtein: Regular expressions with an edit distance

> I wonder if there's something like Levenshtein designed around Regexes...
>
> Like `abcc` doesn't match the Regex `a.cd` but it's pretty close to being able
> to. Say you have a lot of inputs or maybe a lot of Regexes are there close
> matches? This'd let you emit diagnostics like "Hey, I think this was
> _supposed_ to match this Regex" or something.
>
> I'm sure this'd exponentially slow down the Regex but it'd be neat.
>
> —David Archibald, 19 May 2023

That’s a really interesting idea! Counting the minimum number of changes to be
made to satisfy the pattern. You should read this article by Russ Cox on regular
expression automata and see if you can adapt the Pike VM to report a Levenshtein
distance. https://swtch.com/~rsc/regexp/regexp2.html. Here’s the C code
corresponding to that:
https://github.com/thaliaarchi/re1-archive/blob/main/pike.c

The Pike VM visits each character only once and maintains a list of “threads”
for different paths in the regexp that are visiting the current character. For
each thread, you could track the minimum cost to mutate the string to match the
pattern as consumed so far by the thread.

There are at most n threads, where n is the number of operations in the regexp

It may not be able to simply store only one mutation per thread, though, because
a deletion, edit, and insertion affect the remainder of the expression.

Instead, I think it would need to also generate threads for each kind of
mutation (3x). But then the threads are not processing the same character at the
same time.

Equal doesn’t change the edit distance and moves to the next character and next
opcode. The others add one to the edit distance of its thread. Edit moves to the
next character and the next opcode. Deletion retries the same opcode with the
next character. Insertion moves to the next opcode with the same character.

Insertion is the only mutation that doesn’t move to the next character, so it
would need to add to the thread queue for the current character. It would need
some way to bound this expansion.

In the Pike VM, a thread stores the PC (program counter) and positions of
matches. Pike-Levenshtein would also store the edit list. Suppose there are n
opcodes, then there are n threads. If the current character cannot be at a given
PC in the expression, then that thread is None.

When a thread is added, attempt to perform an insertion. This is done by
comparing the edit distance with the insertion to the edit distance for the
thread at the next PC. If it's less or would be a new thread, replace it. This
is done in a fixpoint until no new threads are added for the current character.

The Pike VM has runtime O(n \* m), where n is the length of the string and m is
the number of opcodes in the regexp. Pike-Levenshtein might be O(n^2 \* m),
because it may perform insertions up to the remaining number of characters (the
upper bound, since the edit distance can't be greater than n).

It's not about thread liveness—that doesn't affect runtime—but about how many
insertions can be performed at every step. An insertion consumes a made up
character instead of the current character, so it doesn't move the character
index. Pike VM coordinates threads to all move to the next character at the same
time, so for a Levenshtein distance, it would need to saturate all insertions
before moving on. That's where the squaring comes in.

If it tracks saved matches, the matches would be regular expressions, instead of
literals. Insertions and deletions mean that character in the match takes some
value matching the current character in the pattern.

Shorter strings with fewer edits could be preferred.

It would mean that the possibilities are evaluated in the order equal,
substitute, delete, insert. That gives priority to fewer edits and shorter
strings.

I’ve been assuming there’s some upper bound on the number of edits. The
complexity is actually O(n \* m \* o), where o is this upper bound. I was thinking
this upper bound was n, which is not right. I’m not sure what the upper bound
is.

It could use a sparse array trick so that the threads are in a queue, but also
have indexed access. The queue would contain threads to process. An
`[Option<usize>; m]` would index into the queue, so that a new thread could be
compared with the potentially existing one at the same PC. To perform all
possible insertions, it would iterate to the end of the queue.

Since the number of threads is bounded by PCs, there can’t be infinite
insertions at a single character, because it can only visit at most m PCs.

Levenshtein distance cannot be computed faster than O(n^2), so this complexity
is actually really good. Source:
https://en.wikipedia.org/wiki/Levenshtein_distance#Computational_complexity
