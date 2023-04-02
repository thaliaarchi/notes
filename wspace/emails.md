# Emails with Edwin and friends

## 2023-03-27 22:41:01

From: Thalia Archibald \<thalia@archibald.dev>  
To: Edwin Brady \<ecb10@st-andrews.ac.uk>  
Subject: Whitespace: 20th anniversary and PL theory  
Date: Mon, 27 Mar 2023 22:41:01 +0000

Hello Edwin,

Congrats on 20 years of Whitespace! (soon)

Whitespace shifted my undergrad studies to PL and I’m about to apply for PhD programs in that area, so I’m very thankful for it. It’s been the source of a lot of interesting problems for me to solve. The first compiler I built was an optimizing AOT Whitespace compiler in Go, targeting LLVM IR. I cataloged and built all the Whitespace projects I could find with Docker (currently 346 projects). I wrote an interactive debugger for it in jq, a language underrated for programming. I formalized Whitespace with small-step semantics in Coq. Most recently, during a 24-hour hackathon over the weekend, I built the middle-end for a compiler in Rust, that accurately models Whitespace's lazy semantics, registerizes and eliminates all stack operations in a basic block, performs common-subexpression elimination, and does some basic aliasing analysis of the heap.

I’m preparing a project for the 20th anniversary of Whitespace on Saturday and have some questions for you:

Did you intend for Whitespace to have lazy semantics? On the surface, it seems to be entirely eager. Going by the reference implementation, most of the stack and IO instructions, the control flow instructions, as well as heap store, are eager. But, due to its implementation in Haskell, parsing, arithmetic operations, stack copy and slide, and heap retrieve are lazy. For example, you could have a number literal that would fail parsing or a division by zero, that is never forced to be evaluated, so never panics. There’s many different examples of control-flow-dependent errors resulting from these semantics, that most implementations handle statically or eagerly. I assume none of this was intentional, right?

You’ve mentioned in a few places, that Whitespace was inspired by the G-machine. I assume you’re referring to the work by Simon Peyton Jones, but I don’t see much of a relation, beyond that the G-machine is compiled to using a stack. Does Whitespace resemble a compilation target for the G-machine? Can you provide more insight here?

Do you have files related to Whitespace, that you’d be willing to share (including metadata)? In archiving the CompSoc homepage, as well as the d.j.walrond and Oxford mirrors, I’ve been able to reconstruct a pseudo revision history of versions 0.1, 0.2, and 0.3. However, VM.hs—the most important file—from 0.1 was never archived. Do you have a copy of that version? Additionally, I’d be interested in any other Whitespace-related files and metadata you’ve got.

What were other contributers' roles in Whitespace? It seems like the website and reference interpreter in Haskell were written by you, the Fibonacci and ROT13 programs by Chris Morris, and the Debian packaging for 0.1 by Andrew Stribblehill. What were their contributions for the language design?

Perhaps Idris would have been a more productive language for me to pour my energy into. I certainly love dependent types with Coq and (usually) the laziness of Haskell, but the quirks with the Whitespace semantics are a puzzle that I find myself repeatedly drawn back to.

Thanks for any insight you can give and the fun language.

Thanks,  
Thalia Archibald

## 2023-03-28 21:08:50

From: Edwin Brady \<ecb10@st-andrews.ac.uk>  
To: Thalia Archibald \<thalia@archibald.dev>  
Subject: Re: Whitespace: 20th anniversary and PL theory  
Date: Tue, 28 Mar 2023 21:08:50 +0000

Hi Thalia,  
Thanks for your email, even with the slightly scary reminder of how old Whitespace is :).

It's great to hear that it's got you interested in PL! And it sounds like you've put far more thought into it than I ever did... I'm afraid the honest answer to most of your questions is that I can't remember, but I can at least say what I do remember.

What actually happened was that I went to the pub (the Victoria in Durham, because that was our favourite) with Chris Morris in late March 2003 (it must have been the 29th since that was a Saturday). Being the nerds that we are, we were talking about programming languages, and for whatever reason, we wondered what the most minimal syntax was. And that ended up with "three whitespace characters is enough to encode all the interesting operations on a stack machine, reasonably concisely, with reasonable semantics" and then, since I'm a night owl, when I got home I hacked something up in Haskell using, more or less, the first ideas that came into my head. Since at the time I was writing up my thesis, which involved a G-machine target for a dependently typed core language, much of the inspiration came from the G-machine. There are, nevertheless, no actual graphs in there. The most obvious relation is probably the way it lets you do tail recursion.

Pretty much everything about it beyond that is an accident due to its implementation being in Haskell, as you suspected. It was literally a couple of hours of late night hacking on a thing I thought would be amusing, after coming up with a rough idea with Chris in the pub! It was only when I showed people the next day and someone pointed out how close it was to April 1st that I thought it would be entertaining to release it then. And it's certainly given me a lot of entertainment since then for such a quick hack, and what's particularly pleasing (as your projects show) is that there's turned out to be a lot more depth than we first thought!

I've never actually written a Whitespace program myself. The examples I made were all written directly using the Haskell datatype then written out as Whitespace, using some code I never released but which probably wouldn't be so hard to reproduce. Chris did come up with quite a few examples (I'm not certain whether he wrote them directly or generated them, but I think it's mostly likely he wrote them directly.)

Anyway, that may be a bit of a disappointing answer, in that I don't have any more documents or details of that Saturday night hacking. As far as VM.hs goes, I doubt I kept it anywhere. It would have been in a darcs repository at one point, but I don't know where...

If anything else occurs to me, I'll let you know!

Edwin

## 2023-03-29 21:15:29

From: Thalia Archibald \<thalia@archibald.dev>  
To: Andrew Stribblehill \<ads@wompom.org>  
Subject: Whitespace: 20th anniversary and your Debian package  
Date: Wed, 29 Mar 2023 21:15:29 +0000

Hello Andrew,

On Saturday will be the 20th anniversary of Whitespace and I’m preparing a reconstructed revision history of Whitespace, that I think you might be able to help with.

Your Debian package at https://web.archive.org/web/20030608044924/http://www.dur.ac.uk:80/d.j.walrond/whitespace/ is the only source I’ve found in my research, that has parts of version 0.1 archived. The problem is, wspace.tgz (or equivalently, whitespace_0.1.orig.tar.gz), the original source distribution, was not archived when the site went down. I've been able to track down just about everything, except for VM.hs from 0.1—the most important file.

Additionally, Debian has only version 0.3 in its archive (http://archive.debian.org/debian/pool/main/w/whitespace/) and snapshots (https://snapshot.debian.org/package/whitespace/), and I don't think old unstable packages are still available. I'm fairly confident I have everything for 0.2, though.

Do you have any files from Whitespace still?

Thanks,  
Thalia Archibald

## 2023-03-30 09:28:53

From: Thalia Archibald \<thalia@archibald.dev>  
To: Edwin Brady \<ecb10@st-andrews.ac.uk>  
Subject: Re: Whitespace: 20th anniversary and PL theory  
Date: Thu, 30 Mar 2023 09:28:53 +0000

Edwin,

It's fun to hear how it all started. In my case, it started as a finals procrastination project in 2018. I was just finishing a systems programming class in my second semester and I felt empowered from learning x86 assembly. Assembly had been impenetrable to me, but if I could understand that, I could surely learn Whitespace. I had read about Whitespace before, but it didn't make sense to me, so I decided to give it another shot. I built an interpreter fairly quickly and also came up with a binary encoding for Whitespace tokens (S -> 0, T -> 10, L -> 11; where a trailing 0 in the final byte is followed by a 1), then spent the summer engrossed in literature on compilers. The next year, I learned about static single-assignment form and built my first compiler around the idea of abstractly interpreting stack operations, to use registers within basic blocks. I happened to have added the LLVM back-end, just before interviewing with a static analysis company, which I then showed off and got the internship. After some months of problem solving, I finished it while on a study abroad in Berlin, in time for the—unfortunately cancelled—2020 LLVM Developer's Conference in Paris. Since then, I've wanted to revisit building a compiler, with several ambitious, failed starts. Surprisingly, though, I got an entire middle-end, that's more complex than the previous, working in 24 hours at the hackathon (https://github.com/thaliaarchi/lazy-wspace). Its IR should hopefully be able to support more complex control- and data-flow analyses, once I clean up the currently hacked-in DAG.

With the G-machine, it turns out I was reading the spineless tagless G-machine paper, which is quite different from the original and doesn't have slide​. I had been very perplexed as to where slide​ could have come from, since it's not in any language in the Forth tradition, nor any other language I was aware of. Because of this, Whitespace may very well be the language that most directly exposes that G-machine operation. Perhaps a slide n m​, where m is the number of elements to keep on the top, instead of just 1, would have been better, as it would have generalized tail recursion to allow returning more than one value. As it is, it's impossible to juggle more than two induction variables on the stack without using the heap.

If you find your Whitespace files, I'd of course be interested. Maybe it would be as simple as a find ~ -name 'wspace*'​? I'd be surprised if the early Whitespace code was in a Darcs repo, though, unless you created migrated it later, because the initial release of Darcs was on 3 March 2003.

Thalia

## 2023-03-31 16:35:20

From: Andrew Stribblehill \<ads@wompom.org>  
To: Thalia Archibald \<thalia@archibald.dev>  
Cc: Dan Walrond \<dan.walrond@gmail.com>, Edwin Brady \<eb@dcs.st-and.ac.uk>  
Subject: Re: Whitespace: 20th anniversary and your Debian package  
Date: Thu, 30 Mar 2023 17:35:20 +0100

Hi Thalia,

What a lovely surprise - a Whitespace retrospective sounds amazing!

I'm afraid I don't have old versions of Whitespace. I recall announcing it on Slashdot, on April 1st 2003. Even then, (according to archive.org) the version was 0.2.

I'm cc'ing Edwin and Dan, to see if they have any input.

## 2023-03-31 16:38:00

From: Andrew Stribblehill \<ads@wompom.org>  
To: Thalia Archibald \<thalia@archibald.dev>  
Cc: Dan Walrond \<dan.walrond@gmail.com>, Edwin Brady \<edwin.brady@gmail.com>  
Subject: Re: Whitespace: 20th anniversary and your Debian package  
Date: Thu, 30 Mar 2023 17:38:00 +0100

Trying again with a different Edwin address.

## 2023-03-30 17:00:05

From: Edwin Brady \<edwin.brady@gmail.com>  
To: Andrew Stribblehill \<ads@wompom.org>, Thalia Archibald \<thalia@archibald.dev>  
Cc: Dan Walrond \<dan.walrond@gmail.com>  
Subject: Re: Whitespace: 20th anniversary and your Debian package  
Date: Thu, 30 Mar 2023 18:00:05 +0100

I really need to dig into any old machines I can find since back then I wasn't very good at archiving things sensibly! I did recently find an old TODO list from 2002 which had some things on it I still haven't done though. And I know someone took an archive of the old compsoc.dur.ac.uk site before it disappeared.

If I remember rightly, the 0.3 update added enough to allow encoding a minimal form of tail recursion. You'd think we'd have made to it 1.0 by now :).

(Anyway, if you're getting bounces from any address you have for me, it's probably because my old cs.st-andrews one doesn't work any more for uninteresting reasons. It's now ecb10@st-andrews.ac.uk).

Edwin

## 2023-03-30 17:04:55

From: Edwin Brady \<ecb10@st-andrews.ac.uk>  
To: Thalia Archibald \<thalia@archibald.dev>  
Subject: Re: Whitespace: 20th anniversary and PL theory  
Date: Thu, 30 Mar 2023 17:04:55 +0000

Well I was an early adopter of darcs but I doubt I was that early! I will have to do some digging...

As far as slide goes, if I remember rightly I was irritated that I couldn't easily encode tail recursion with the initial post-pub hack. And shortly after that I realised I ought to get on with writing my thesis :).

By the way, at one point I implemented a Whitespace interpreter in Idris, just to see how far Idris had come along. Whitespace is unfortunately a bit too limited to work as an Idris back end (at least, not without a lot of effort), but sometimes I wonder what extensions it would need to make it work, just to complete the loop, as it were.

Edwin

## 2023-04-01 03:00:26

From: Thalia Archibald \<thalia@archibald.dev>  
To: Edwin Brady \<ecb10@st-andrews.ac.uk>  
Subject: Re: Whitespace: 20th anniversary and PL theory  
Date: Sat, 01 Apr 2023 03:00:26 +0000

I had actually already seen your Whitespace interpreter in Idris and, last year, I updated it to work with modern Idris (1.3.4) at https://github.com/wspace/edwinb-ws-idr. I got stuck with migrating the deprecated Coq-style tactic proofs to the newer Agda-style elaborator reflection engine, but could probably figure it out, now that I have more experience with Coq. I remember trying to upgrade it to Idris 2, but probably ran into issues with the linear types or something else.

Thalia
