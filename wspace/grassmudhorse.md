# GrassMudHorse

GrassMudHorse is an extension to Whitespace syntax.

## Syntax

GrassMudHorse uses 草 “grass” (U+8349), 泥 “mud” (U+6CE5), and 马 “horse”
(U+9A6C) for `S`, `T`, and `L` tokens, respectively, and adds two more tokens:
河 “river” (U+6CB3) and 蟹 “crab” (U+87F9). It extends the grammar by allowing
`end` to be written equivalently as either “river crab” or “horse horse horse”
(i.e., `L` `L` `L`). Only some implementations support river and crab.

## Error handling

There are two behaviors for handling unpaired river and crab tokens: ignoring
them (as in the original [Java implementation](https://github.com/wspace/bearice-grassmudhorse/blob/main/src/cn/icybear/GrassMudHorse/JOTCompiler.java))
or erroring (as in the [Erlang implementation](https://github.com/wspace/bearice-grassmudhorse/tree/main/erlang)
by the same author).

## Name

GrassMudHorse is a reference to a couple of Chinese internet memes: The
[Grass Mud Horse](https://en.wikipedia.org/wiki/Grass_Mud_Horse) (a profane
homophonic pun) is said to be a species of alpaca from the Mahler Gobi Desert,
whose existence is threatened by [river crabs](https://en.wikipedia.org/wiki/Euphemisms_for_Internet_censorship_in_China)
(a pun criticizing internet censorship).
