# Whitespace token mappings

## Examples

### Gorispace

[Gorispace](https://github.com/technohippy/gorispace) is two mappings, one in
Japanese and one in English. The patterns `ウホ+` is space, `ウッホ+` is tab, and
`ウホ+ーイ` is LF. In English, the patterns are `hoo+`, `hoo+s`, and `wraa+gh`,
respectively. Any characters that don't appear in those tokens are removed
before processing, so the patterns really have `[^ウッホーイ]*` or `[^hoswragh]*`,
respectively, between every character.

[fact.gs](https://github.com/technohippy/gorispace/blob/master/samples/fact.gs)
excerpt (wrapped):

```gorispace-ja
ウホホウホホホウホホホ、ウホ。ウホホホホーイウホホホ、ウホウホホホウッホホウホウホホホホウホホ、
ウッホホウホホホウッホホウホーイ。ウッホホホ。ウッホホホホウホホ。ウホホ、ウホホホホ。ウホホホホ
ウッホホホウホーイ。ウホホホ、ウホホホホ。ウホウッホホ。ウッホホ、ウホウッホホ。ウッホ、ウッホホホホ
ウホウホホホホーイウッホホホ。ウッホホ、ウホホホホウホホホウホホホウホホホ。ウッホホホウホホホホ。
ウホホホホーイウホホホホ。ウホホホホウホウッホホホホ。ウッホホホホ、ウッホホホウホウッホ。…
```

[en/fact.gs](https://github.com/technohippy/gorispace/blob/master/samples/en/fact.gs)
excerpt (wrapped):

```gorispace-en
hoooo, hoooo hoo hooo. wraagh. hoooo, hoo hooo hooos. hooo. hoo, hoooo hoooos,
hoo hooos. wraaaagh hooos hooos, hooo, hoo hooo hooo hooos wraaagh, hooo hoooo,
hooo hooos hoooos hoooo hoooos hooos. hooos hoooo wraaagh. hooos, hooos, hoooo
hoo hoo, hoo hooos, hoooo. wraaaagh, hooo hooo hooo, hooos hoos hoooos hoooo
hoooos, hoo. hoooo, wraaaagh, hooos hooos hoooo hoo, hoo hoooo. hooos hoooos, …
```

### hohoho

[hohoho](https://github.com/freyamade/hohoho) uses `snow` for space, `hohoho`
for tab, and LF as itself. When converting from Whitespace to hohoho, spaces are
added after `snow` and `hohoho`, but when parsing, the spaces are ignored. It is
important that `hohoho` be parsed non-overlapping, otherwise, for example,
`hohohohohoho` would be parsed as TTTT, instead of TT.

[hello.ho](https://github.com/freyamade/hohoho/blob/master/hello.ho) excerpt:

```hohoho
snow snow snow snow
snow snow snow hohoho snow snow hohoho snow snow snow
hohoho hohoho snow snow snow snow hohoho
snow snow snow hohoho hohoho snow snow hohoho snow hohoho
hohoho hohoho snow snow snow snow hohoho snow
…
```
