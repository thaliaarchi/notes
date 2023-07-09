# Testing the Waters (January 2013)

[Competition](https://web.archive.org/web/20141024032101/http://www.pltgames.com/competition/2013/1)

## Description

Now that we've made an [impractical language](https://web.archive.org/web/20140910193725/http://www.pltgames.com/competition/2012/12),
let's stop the academic elitism and build something for the Real World™.

Automated testing is extremely important for finding bugs. [Even for formally
verified software](https://web.archive.org/web/20150517173933/http://ssrg.nicta.com.au/publications/papers/Klein_EHACDEEKNSTW_09.pdf).
An example is automated unit testing, which tests an individual part of the
code, such as a method:

```
assert(adder.add(1, 1) == 2);
```

Automated tests are generally written in the same language as the implementation code, in a separate module, using a test framework and test runner.

Despite its importance, testing is almost never *the* primary concern for language designers.

Until now.

The goal of this theme is to create a language that is somehow related to automated testing. This could be interpreted however you like, for example:

- An implementation language that is highly testable
- A language that enforces [TDD](http://en.wikipedia.org/wiki/Test-driven_development)
- A language for specifying tests for existing software

Go on and make testing better!

### Inspiration

[D](https://dlang.org/spec/unittest.html)

```d
class Sum {
  int add(int x, int y) { return x + y; }

  unittest
  {
    Sum sum = new Sum;
    assert(sum.add(3,4) == 7);
    assert(sum.add(-2,0) == -2);
  }
}
```

[Cobra](http://cobra-language.com/docs/quality/)

```cobra
class Utils
    shared
        def countChars(s as String, c as char) as int
            """
            Returns the number of instances of c in s.
            """
            test
                assert Utils.countChars('', c'x') == 0
                assert Utils.countChars('x', c'x') == 1
                assert Utils.countChars('X', c'x') == 0  # case sensitive
                assert Utils.countChars(' ! ! ', c'!') == 2
            body
                count = 0
                for ch in s
                    if c == ch
                        count += 1
                return count
```

[Noop](https://code.google.com/archive/p/noop/wikis/ProposalForTestingApi.wiki)

```noop
import noop.Console;
import noop.FakeConsole;

class HelloWorld(Console c) {
  Int main(List args) {
    c.println("Hello tests!");
    return 1;
  }

  test "prints hello" scope (Console -> FakeConsole) {
    main(List()) should equal(1);
    c.asInstance(FakeConsole).getPrintedText() should contain("Hello tests!"));
  }
}
```

### Resources

- ["Unit Tests as First-class Entity in Programming Languages"](https://web.archive.org/web/20140606231859/http://www.iam.unibe.ch:80/~akuhn/blog/2009/unit-tests-as-first-class-entity-in-programming-languages/)
- ["A programming language designed to be testable" on StackOverflow](https://stackoverflow.com/questions/3371268/a-programming-language-designed-to-be-testable)

## Submissions

| Repo                                                              | User                                                                                                   | Innovation | Completeness | Theme | Total |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ---------- | ------------ | ----- | ----- |
| [pltgames-testoy](https://github.com/mdg/pltgames-testoy)         | [mdg](https://web.archive.org/web/20141024194103/http://www.pltgames.com/user/mdg)                     | 5 | 5 | 5 | 15 |
| [vigil](https://github.com/munificent/vigil)                      | [munificent](https://web.archive.org/web/20141024200801/http://www.pltgames.com/user/munificent)       | 5 | 5 | 3 | 13 |
| [bianca](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://github.com/aaditmshah/bianca) (archive) | [aaditmshah](https://web.archive.org/web/20141024191401/http://www.pltgames.com/user/aaditmshah) | 4 | 4 | 4 | 12 |
| [pipo](https://github.com/zayac/pipo)                             | [zayac](https://web.archive.org/web/20141024200843/http://www.pltgames.com/user/zayac)                 | 4 | 4 | 4 | 12 |
| [symplex](https://github.com/greedy/symplex)                      | [greedy](https://web.archive.org/web/20141024191421/http://www.pltgames.com/user/greedy)               | 4 | 4 | 4 | 12 |
| [fortholito](https://github.com/tormaroe/fortholito)              | [tormaroe](https://web.archive.org/web/20141024200806/http://www.pltgames.com/user/tormaroe)           | 3 | 5 | 2 | 10 |
| [isitoq](https://github.com/gatesphere/isitoq)                    | [gatesphere](https://web.archive.org/web/20141024191416/http://www.pltgames.com/user/gatesphere)       | 4 | 4 | 1 | 9  |
| [plt-banker](https://github.com/efoxepstein/plt-banker)           | [elitheeli](https://web.archive.org/web/20141024191406/http://www.pltgames.com/user/elitheeli)         | 2 | 4 | 2 | 8  |
| [constrained](https://github.com/fwg/constrained)                 | [fwg](https://web.archive.org/web/20141024191411/http://www.pltgames.com/user/fwg)                     | 1 | 1 | 3 | 5  |
| [11rank](https://github.com/morefreeze/11rank)                    | [morefreeze](https://web.archive.org/web/20141024200742/http://www.pltgames.com/user/morefreeze)       | 1 | 1 | 1 | 3  |
