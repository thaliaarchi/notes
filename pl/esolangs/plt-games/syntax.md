# Only Syntax (April 2013)

[Competition](https://web.archive.org/web/20140909011347/http://www.pltgames.com/competition/2013/4)

## Description

Wadler's Law claims that:

> In any language design, the total time spent discussing a feature in this list is proportional to two raised to the power of its position.
>
> 0. Semantics
> 1. Syntax
> 2. Lexical syntax
> 3. Lexical syntax of comments

Syntax is a very easy thing to have an opinion about; so everyone does!

The goal of this competition is to take an existing language and write a new syntax for it. The syntax can be different for any number of reasons:

- Imagine that you are the only user of the language. What would it look like?
- Is there a feature that is underused just because of its syntax?
- Java is verbose. Should we design the CoffeeScript of Java?
- What if Scala were a Lisp?

Go forward and bike-shed!

### Inspiration

[CoffeeScript](https://coffeescript.org/)

```coffeescript
grade = (student) ->
  if student.excellentWork
    "A+"
  else if student.okayStuff
    if student.triedHard then "B" else "B-"
  else
    "C"

eldest = if 24 > 21 then "Liz" else "Ike"
```

[Xtend](https://eclipse.dev/Xtext/xtend/)

```xtend
package com.acme

import java.util.List

class MyClass {
  String name

  new(String name) {
    this.name = name
  }

  def String first(List<String> elements) {
    elements.get(0)
  }
}
```

### Resources

- [Syntax across languages](http://rigaux.org/language-study/syntax-across-languages/)
- [Ola Bini's Notes On Syntax](https://olabini.com/blog/2012/02/notes-on-syntax/)

## Submissions

This competition received no submissions.
