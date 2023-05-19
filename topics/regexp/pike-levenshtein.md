# Pike–Levenshtein: Regular expressions with an edit distance

by Thalia Archibald, 19 May 2023

> I wonder if there's something like Levenshtein designed around Regexes...
>
> Like `abcc` doesn't match the Regex `a.cd` but it's pretty close to being able
> to. Say you have a lot of inputs or maybe a lot of Regexes are there close
> matches? This'd let you emit diagnostics like "Hey, I think this was
> *supposed* to match this Regex" or something.
>
> I'm sure this'd exponentially slow down the Regex but it'd be neat.
>
> —David Archibald, 19 May 2023

That's a really interesting idea! This would compute the minimum number of edits
needed for the string to satisfy the pattern.

The [Pike VM](https://swtch.com/~rsc/regexp/regexp2.html) is a regular
expression automaton, that executes in linear time. It maintains a list of
“threads” for different paths in the regexp. The threads all process the same
character in sync, so it visits each character only once. A thread stores the PC
(program counter) within the regexp automaton and positions of submatches.

To extend this algorithm for tracking the Levenshtein distance, each thread also
tracks the edits to the string, as consumed so far, to make it match the
pattern.

There are three kinds of edits: substitution, deletion, and insertion.
Substitution consumes the current character and advances the PC. Deletion
retries the same PC with the next character. Insertion matches the same
character again with the next PC(s). Equality can be seen as a special case of
substitution, where the edit distance is not incremented if the the current
character matches the pattern.

Insertion is the only edit that doesn't move to the next character, so it needs
to add to the thread list for the current character. This needs to be bounded,
to prevent infinite insertions.

The Pike VM limits the number of threads to the size of the compiled regexp—one
for each PC. Past edits do not affect future execution, since it matches without
backtracking; thus only the minimal edit distance needs to be retained.

By employing a sparse array, we can efficiently check if a thread exists at a
given PC. Threads are stored in a queue, and a separate array of `Option<usize>`
maps the PC to the index in the queue. (This is inspired by Russ Cox' [article
on sparse sets](https://research.swtch.com/sparse), but without using
uninitialized memory.) We only need a thread queue for the current character and
a thread queue and index array for the next character.

For the current character, apply an equality or substitution to each of the
current threads and add them to the next thread queue. Then, the same for
deletion. If a thread already exists in the next thread queue, only replace it
if the new edit distance is shorter. Then, apply an insertion to each of the
threads in the next queue and add those to the back of the same queue, until
threads exist for every PC. The initial thread queue contains one thread at the
first character and at PC 0.

There will always be at most one thread executing per PC or, if all PCs are
reachable from the program entrypoint, exactly one per PC.

The Pike VM has runtime *O(n \* m)*, where *n* is the length of the string and
*m* is the number of opcodes in the regexp automaton. Pike–Levenshtein has the
same complexity, because the number of edits to reach every state in the
automaton is at most *m*.

The matches captured are regular expressions, instead of literals as usual.
Matches index into the edit list, rather than the input string. The edit list,
in turn, records the character index and PC at each step, to allow for
reconstruction of the matched pattern.

To my knowledge this is a novel algorithm.
