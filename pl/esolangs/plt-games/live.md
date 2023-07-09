# Do it Live (March 2013)

[Competition](https://web.archive.org/web/20140909011342/http://www.pltgames.com/competition/2013/3)

## Description

*Live coding* is a form of improvised performance. Code is written during the
performance to create music and/or video. The composition of code is often
projected for the audience to see.

Another form of live coding is used in conference presentations, where the
presenter wants to show how to build something in front of an audience.

An important aspect of live coding is the representation of time. The user needs
to be able to specify when sounds or video are played. One solution is to have
time as part of control flow. For example a recursive call could be scheduled at
a specific time in the future.

Some live coding environments allow multiple users to manipulate the
performance.

The goal of this competition is to make a programming language for a live coding
environment. The use is open-ended. For example, it could be designed to create:

- Music
- Video
- Games
- Conference presentations

### Inspiration

[SuperCollider](https://supercollider.github.io/)

```supercollider
play{SinOsc.ar(OnePole.ar(Mix(
  LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1]
),0.98)).dup*0.1}
```

[Impromptu](http://impromptu.moso.com.au/)

```impromptu
(dotimes (i 8)
   (play-note (+ (now) (* i 5000)) piano (+ 60 i) 80 4000))
```

[ChucK](https://chuck.cs.princeton.edu/)

```chuck
// our signal graph (patch)
SinOsc s => JCRev r => dac;
// set gain
.2 => s.gain;
// set dry/wet mix
.1 => r.mix;

// an array of pitch classes (in half steps)
[ 0, 2, 4, 7, 9, 11 ] @=> int hi[];

// infinite time loop
while( true )
{
    // choose a note, shift registers, convert to frequency
    Std.mtof( 45 + Std.rand2(0,3) * 12 +
        hi[Std.rand2(0,hi.cap()-1)] ) => s.freq;

    // advance time by 120 ms
    120::ms => now;
}
```

### Resources

- [Live coding description](https://en.wikipedia.org/wiki/Live_coding)
- [TOPLAP](https://toplap.org/)

## Submissions

| Repo                                                              | User                                                                                                   | Innovation | Completeness | Theme | Total |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ---------- | ------------ | ----- | ----- |
| [liveJSONAutomata](https://github.com/jacopofar/liveJSONAutomata) | jacopofar                                                                                              | 5 | 5 | 5 | 15 |
| [silica](https://github.com/gatesphere/silica)                    | [gatesphere](https://web.archive.org/web/20141024191416/http://www.pltgames.com/user/gatesphere)       | 5 | 5 | 5 | 15 |
| [Turbo-Impress](https://github.com/philipbjorge/Turbo-Impress)    | philipbjorge                                                                                           | 4 | 4 | 4 | 12 |
