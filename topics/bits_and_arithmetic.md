# Bits and arithmetic

## Bit twiddling

- [Bit Twiddling Hacks](http://www.graphics.stanford.edu/~seander/bithacks.html)
  by Sean Eron Anderson
- [*Hacker's Delight*](https://en.wikipedia.org/wiki/Hacker%27s_Delight)
  by Henry S. Warren, Jr.
- *The Art of Computer Programming, Volume 4A: Combinatorial Algorithms, Part 1*,
  Section 7.1.3: Bitwise Tricks and Techniques, by Donald E. Knuth
- [The Aggregate Magic Algorithms](http://www.aggregate.org/MAGIC/)
  by Henry Gordon Dietz
- [Introduction to Low Level Bit Hacks](https://catonmat.net/low-level-bit-hacks)
  by Peter Krumins
- [Bitboard](https://en.wikipedia.org/wiki/Bitboard) data structure

## Low-level arithmetic

- [Transcendental functions](https://space.stackexchange.com/questions/30952/how-did-the-apollo-computers-evaluate-transcendental-functions-like-sine-arctan)
  in the [Apollo Guidance Computer](https://en.wikipedia.org/wiki/Apollo_Guidance_Computer):
  [sine and cosine in the command module](https://github.com/chrislgarry/Apollo-11/blob/master/Luminary099/SINGLE_PRECISION_SUBROUTINES.agc)
  and [lunar module](https://github.com/chrislgarry/Apollo-11/blob/master/Luminary099/SINGLE_PRECISION_SUBROUTINES.agc),
  and [natural log in the command module](https://github.com/chrislgarry/Apollo-11/blob/master/Comanche055/CSM_GEOMETRY.agc#L255-L297)
- musl [math](https://git.musl-libc.org/cgit/musl/tree/src/math), in particular
  its [`__cos`](https://git.musl-libc.org/cgit/musl/tree/src/math/__cos.c) with
  only 12 multiplies and 11 adds
  [[HN](https://news.ycombinator.com/item?id=35381968)]
- [Fast inverse square root](https://en.wikipedia.org/wiki/Fast_inverse_square_root),
  popularized by Quake III Arena; [revisited in 2023](https://hllmn.net/blog/2023-04-20_rsqrt/)
- [The radix 2^51 trick: Faster addition and subtraction on modern CPUs](https://www.chosenplaintext.ca/articles/radix-2-51-trick.html)
  by Tim McLean
- [Untitled collection of math notes](https://αβγ.ελ/) (formerly
  *Mathematics for Programmers*) by Dennis Yurichev

## Algorithms in assembly

- [*Reverse Engineering for Beginners*](https://beginners.re/) (alternatively
  known as *Understanding Assembly Language*) [[pdf](https://web.archive.org/web/20200205095923/https://beginners.re/RE4B-EN.pdf)]
  by Dennis Yurichev
- [Assembly Language Lab](http://www.azillionmonkeys.com/qed/asmexample.html)
  by Paul Hsieh
