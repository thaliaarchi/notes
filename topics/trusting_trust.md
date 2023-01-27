# Trusting Trust

## Reflections on Trusting Trust

In Ken Thompson's 1984 Turing Award Lecture, [“Reflections on Trusting Trust”](https://dl.acm.org/doi/10.1145/358198.358210)
[[mirror](https://users.ece.cmu.edu/~ganger/712.fall02/papers/p761-thompson.pdf)],
he describes a method for inserting a [backdoor](https://en.wikipedia.org/wiki/Backdoor_(computing)#Compiler_backdoors)
into a compiler binary, and programs it compiles, without it remaining in the
source—an attack, which he actually [carried out](https://niconiconi.neocities.org/posts/ken-thompson-really-did-launch-his-trusting-trust-trojan-attack-in-real-life/)
[[HN](https://news.ycombinator.com/item?id=33008519)]. He also discusses quines,
compiler bootstrapping, and the layers of trust in software. It's an easy,
3-page paper, well worth a read.

### Conventions

- A B : compilers
- P : program
- _s : source code
- _b : binary executable
- _′ : has Trojan

### No Trojan

- compile As with Bb → Ab
- compile Ps with Ab → Pb

### *P* source has Trojan

- compile As with Bb → Ab
- modify Ps → P′s
- compile P′s with Ab → P′b

### *A* injects Trojan into *P*

- modify As → A′s
- compile A′s with Bb → A′b
- compile Ps with A′b → P′b

### *A* propagates Trojan to later versions of itself and injects Trojan into *P*

- modify A₀s → A₀′s
- compile A₀′s with Bb → A₀′b;  compile Ps with A₀′b → P′s
- compile A₁s with A₀′b → A₁′b; compile Ps with A₁′b → P′s
- compile A₂s with A₁′b → A₂′b; compile Ps with A₂′b → P′s
- …
- compile Aₙs with Aₘ′b → Aₙ′b; compile Ps with Aₙ′b → P′s

## Countering Trusting Trust through Diverse Double-Compiling

David Wheeler introduces a method to counter this attack in [“Countering Trusting
Trust through Diverse Double-Compiling”](https://arxiv.org/abs/1004.5548)
(2005). With a compiler binary, the source for that compiler, and an alternate
compiler, compiling the source of the first compiler with both yields two
functionally equivalent stage-1 compilers. Compiling the compiler source again
with both stage-1 compilers yields two binary-equivalent stage-2 compilers.

### No Trojan in *A* or *B*

- compile As with Ab → AA₁b
- compile As with Bb → AB₁b
- compile As with AA₁b → AA₂b
- compile As with AB₁b → AB₂b
- AA₂b = AB₂b

### Trojan in *A*

- compile As with A′b → AA′₁b
- compile As with Bb → AB₁b
- compile As with AA′1b → AA′₂b
- compile As with AB1b → AB₂b
- AA₂b ≠ AB₂b
