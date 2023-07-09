# Obscure Security Language (September 2013)

[Competition](https://web.archive.org/web/20140909011426/http://www.pltgames.com/competition/2013/9)

## Description

Software security has become a hot topic for the past few months.

So what if programming languages were more focused on security? Imagine if the
attributes of information in the [Parkerian hexad](https://en.wikipedia.org/wiki/Parkerian_Hexad)
were applied to programming languages:

- Confidentiality
- Control
- Integrity
- Authenticity
- Availability
- Utility

The goal for this competition is to create a language that focuses on software
security. For example:

- Make it easy to put bounds on usages of information
- Build modules which work on the concept of privilege
- Make the currently most discovered security vulnerabilities impossible
- Limit denial of service attacks by expressing computational bounds on code

### Inspiration

[E](http://erights.org/)

```e
def makeMint(name) :any {
  def [sealer, unsealer] := makeBrandPair(name)
  def mint {
    to makePurse(var balance :(int >= 0)) :any {
      def decr(amount :(0..balance)) :void {
        balance -= amount
      }
      def purse {
        to getBalance() :int { return balance }
        to sprout() :any { return mint.makePurse(0) }
        to getDecr() :any { return sealer.seal(decr) }
        to deposit(amount :int, src) :void {
          unsealer.unseal(src.getDecr())(amount)
          balance += amount
        }
      }
      return purse
    }
  }
  return mint
}
```

[Jif](https://www.cs.cornell.edu/jif/)

```jif
public static void main{}(String{}[]{} args) {
    String filename = args[0];
    final principal p = Runtime.user();
    final label lb;
    lb = new label{p:};
    Runtime[p] runtime = Runtime.getRuntime(p);
    FileInputStream{*lb} fis = runtime.openFileRead(filename, lb);
    InputStreamReader{*lb} reader = new InputStreamReader{*lb}(fis);
    BufferedReader{*lb} br = new BufferedReader{*lb}(reader);
    PrintStream{*lb} out = runtime.out();
    String line = br.readLine();
    while (line != null) {
        out.println(line);
        line = br.readLine();
    }
}
```

### Resources

- [LANGSEC: Language-theoretic Security](https://www.cs.dartmouth.edu/~sergey/langsec/)
- [Secure by design](https://en.wikipedia.org/wiki/Secure_by_design)

## Submissions

This competition received no submissions.
