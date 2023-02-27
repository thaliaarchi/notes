# Thoughts on polymorphic automata for string- and AP-matching

I should make my regexp engines polymorphic over character type. I could use it
to recognize other languages, like a Spin model. What would the appropriate
trait be?

```rust
trait Char {
    fn matches(&self, other: &Self) -> bool;
}

impl Char for char {
    fn matches(&self, other: &char) -> bool { self == other }
}
```

This falls short for matching chars to character classes or with case folding,
as well as matching a transition system (e.g., {b, c}) to predicates (e.g.,
¬b /\ c). This suggests, that the edge predicate type and the character type
need to be distinct.

```rust
trait Matcher {
    type Char;

    fn matches(&self, ch: &Char) -> bool;
}

impl Matcher for char {
    type Char = char;
    fn matches(&self, ch: &char) -> bool { self == ch }
}

struct AsciiCaseInsensitive(char);
impl Matcher for AsciiCaseInsensitive {
    type Char = char;
    fn matches(&self, ch: &char) -> bool {
        self.0.eq_ignore_ascii_case(ch)
    }
}
```

UTF-8–aware case-insensitive char matching falls short for any non-injective
mappings like ß as well as mappings that produce multiple chars, so probably
needs to be reduced to character classes and alternations in preprocessing.

Character classes would use a more complex, sorted interval set type, that could
easily implement this trait.

For atomic propositions:

```rust
// An set of atomic propositions, e.g., {"a", "b", "c"}. Only used for Display.
struct APNames {
    names: Box<[String]>,
}

// A set of up to 64 atomic propositions. Bit indices correspond to array
// indices in APNames.
struct APSet(u64);

// A conjunction of up to 64 variables.
struct Conj {
    mask: u64, // The variables used in the conjunction
    vals: u64, // The values for those variables
}

// A predicate in disjunctive normal form.
struct PredDNF {
    disj: Box<[Conj]>,
}

impl Matcher for Conj {
    type Char = APSet;
    fn matches(&self, state: &APSet) -> bool {
        // If all of the masked bits are equal to the expected values
        (state.0 ^ self.vals) & self.mask == 0

        // Equivalent, when vals is within mask:
        // state.0 & self.mask == self.vals
    }
}

impl Matcher for PredDNF {
    type Char = APSet;
    fn matches(&self, state: &APSet) -> bool {
        for conj in &self.disj {
            if conj.matches(state) {
                return true;
            }
        }
        false
    }
}

// A disjunction of up to 64 variables.
struct Disj {
    mask: u64, // The variables used in the disjunction
    vals: u64, // The values for those variables
}

// A predicate in conjunctive normal form.
struct PredCNF {
    conj: Box<[Disj]>,
}

impl Matcher for Disj {
    type Char = APSet;
    fn matches(&self, state: &APSet) -> bool {
        // If any of the masked bits are equal to the expected values
        !(state.0 ^ self.vals) & self.mask != 0
    }
}

impl Matcher for PredCNF {
    type Char = APSet;
    fn matches(&self, state: &APSet) -> bool {
        for disj in &self.conj {
            if !disj.matches(state) {
                return false;
            }
        }
        true
    }
}
```

This approach seems very feasible for modeling propositions of few variables
(<=64) and DNF and CNF seem to work equally well. Karnaugh maps and related may
also be useful, but I haven’t done much in that domain.
