# Text editors

## Bingo

Bingo 2.01 added regular expression search. The Bingo 2.10a Reference Manual
(BINGO.DOC) states that “the regular expression subsystem is going to be
completely rewritten for the next release”.

Versions:
- Bingo 2.01 in [NightOwl 004 - 1991](http://annex.retroarchive.org/cdrom/nightowl-004/004A/BINGO201.ZIP)
- Bingo 2.10a in [NightOwl 005 - 1990/91](http://www.retroarchive.org/cdrom/nightowl-005/041A/BINGO21A.ZIP)
- Bingo 3.10 in [Shareware Overload Trio - 1993](http://annex.retroarchive.org/cdrom/chst-strio-93/DIR32/index.html)

From the Bingo 3.10 Reference Manual:

> ```
>                       Bingo 3.10 Reference Manual
>
>                                Searching
>                                ---------
>
>      There are two search algorithms present in Bingo.  One is very
> simple and very fast, and part of it is hand-coded in assembler for a
> bit more speed yet.  For 95% of what you want to do, it is just right.
>      However, with the advent of version 2.01, a second search
> algorithm was added; a regular-expression method.  Regular expressions
> are a mathematical way to describe strings of text, and are very
> powerful.  Bingo's algorithm is reliable but not overly speedy; I
> suggest you keep this in mind when using it.
>      If you are not familiar with regular expressions, I am not going
> to attempt to explain them to you here.  If, however, you have used
> them before, I will explain the notations I used in coding Bingo's
> algorithm.
>      To perform a regexp search, use the 'R' modifier on you search
> (or replace).  If you use this modifier, the string will be
> interpreted as follows:
>
>      -    classes, i.e. [0-9] and 'not' classes, i.e. [~0-9]
>      -    occurrences of once, once or none (?), one or more (+), none
>           or more (*)
>      -    grouping  {}
>      -    ORing of {} groups |
>      -    wild card character .
>      -    match begin and end of lines with ^ and $, respectively
>      -    support for debugging regular expression search
>           patterns
>      -    along with regular expression searches, you can specify the
>           replacement in terms of the matched text.  '@n' in the
>           replacement pattern places the text matching the nth group.
>           '@@' matches the entire matched text. This allows you to do
>           some nifty text manipulation.
>
>      For some simple examples, see below.
>
>      It is easy to limit the search area to a specific range by
> marking a range of text in any of Bingo's three modes.  Then use the
> 'M' modifier to say you wish to match text only within the Marked
> area.
>      The 'C' option in the 'search' function will count the number of
> occurrences of the target string in the rest of the search area.
>      The 'G'lobal option for search and replace operations starts from
> the current cursor position, not from the top of the file.
>      Try the Search and Macro capability -- it is sharp.
>
>
> Regular Expression Search and Replace Examples
> ----------------------------------------------
>      Here are some examples of regular example search and replace.
>
> Search for --> [a-z]+/.
>      would match any sequence of one or more letters between 'a' and
>      'z' followed by a single period.
>
> Search for --> help[a-z]+/.
>      would match a sequence of 'help' followed by one or more letters
>      then a single period.  It would match 'helpoooooo.' and 'helpp.'
>      but not 'help.'
>
> Search for --> 19{87}|{88}
>      would match '19' followed by one occurrence of either '87' or
>      '88'.
>
> Search for --> 19{87}*|{88}
>      would match '19' followed by none or more occurrences of '87' or
>      a single occurrence of '88'.  Thus it would match '19',
>      '1987878787', or '1988'.
>
> Search for --> .
>      matches any single character. (Note: /. would match a an actual
>      period.)
>
> Search for --> ^[a-z]+
>      matches a sequence of 1 or more letters, provided it starts a
>      line.
>
> Search for --> ^[a-z]+$
>      matches a sequence of 1 or more letters, provided it starts a
>      line and ends a line.
>
> Search for --> ^[a-z]+/.[a-z]+
>      basically matches file names made up of alpha characters, which
>      are found at the beginning of a line.
>
> Search for --> ^$
>      matches a blank line.
>
> Search for --> ^.
>      matches a non-blank line.
>
> These last two allow you to do some neat stuff using
> the macro capability, i.e., apply a macro to every
> non-blank line.
>
> Search for --> {[a-z]+}{/.}{[a-z]+}
> Replace with -->  @3.@1
>      This will match a sequence of one or more letters, followed by a
>      period, followed by one or more letters (a file name,
>      essentially).  The replace will put the text matching the 3rd
>      group first, then a period, then the text matching the 1st group.
>      On a file name, this will have the effect of reversing the order
>      of the name and the extension, i.e:
>
>           filename.txt
>
>      would become
>
>           txt.filename
>
>      since 'filename' would match the first group and 'txt' matches
>      the third group.
>
>
> Incremental Searching
> ---------------------
>      Version 3.10 adds an incremental search facility.  This searches
> forward, finding a match as you extend the string.  Hitting the <TAB>
> key will cause it to find the next match.  Pressing <Backspace> will
> backup one match.    Pressing <Return> will end the search and leave
> you at your current position; Pressing <Escape> will return to where
> the search began.
>
>                              Function List
> ----------------------------------------------------------------------
>
>                                                                  Again
> ----------------------------------------------------------------------
> Repeat the last search operation.  If none has yet been done, works
> just like search.  If the last search operation done was a search and
> replace, only the search portion is done.
>
>                                                                 Search
> ----------------------------------------------------------------------
> Search for text.  Will ask for the target text, and then the
> modifiers:
>                          A Accent
>                          B Backwards
>                          C Count
>                          D Debug
>                          F search through all Files
>                          I Ignore case
>                          M Marked
>                          R Regexp
>                          T start at the Top of the workspace
>      The 'A' option tells Bingo to highlight the 'found' text until
> the next keystroke arrives.
>      The 'B' modifier will search backwards.
>      The 'C' option simply counts the number of occurrences.
>      The 'D' option tells Bingo that, if you also specify regular
> expression searching, before searching display Bingo's interpretation
> of your regular expression.
>      The 'F' option tells Bingo to treat all the loaded files as the
> search space.  This allows Bingo to find the next occurrence, even if
> it is in another file.
>      The 'I' option tells Bingo to ignore case when searching.
>      The 'M' option tells Bingo to only matched text *completely*
> within marked text.
>      The 'R' option tells Bingo to interpret the input string as a
> regular expression.  See the section on searching for more details.
>      The 'T' option tells Bingo to start at the beginning of the
> search space.  If the 'I' option is also used, this is the bottom of
> the file; if not, the top of the file.  If the 'F' option is also
> used, it is the last/first file.
>
>                                                                Isearch
> ----------------------------------------------------------------------
> Incremental search.  Searches for a match to the target string
> interactively, as you type in each character, Bingo searches for a
> match and moves there.  Pressing <TAB> finds the next search; pressing
> <Backspace> backs up one match.  Pressing <Return> will end the search
> and leave you at your current position; Pressing <Escape> will return
> to where the search began.
>
>                                                          Isearch_files
> ----------------------------------------------------------------------
> Works just like Isearch, only it will search across files.  If a match
> is not found in the current file, it will look in the next, and so on.
>
>                                                                Replace
> ----------------------------------------------------------------------
> Search and replace text.  Will ask for target, replacement text, and
> three modifiers:
>                          B Backwards
>                          D Debug
>                          F search across Files
>                          G Global Search/Replace
>                          I Ignore Case
>                          M Marked
>                          P Preserve
>                          R Regexp
>                          T Top of search space
>      If Global is selected, Bingo will simply replace all matching
> occurrences with the replacement text.  If not, Bingo will stop at
> each match and ask:
>                     Yes:      replace and continue.
>                     No:       don't replace, but continue search.
>                     Only:     Replace this and stop
>                     Quit:     stop, no replacement.
>                     Global:   Continue with global replacement
>
>      'M', 'R', 'F', 'T' and 'A' options work as in the search case.
>      'P' tells Bingo to preserve the original cursor location and
> return to it when done with the replace operation.
>      'D' is useful for regular expression work.  It tells Bingo to
> display its conception of the target string (grouping, classes,
> occurrence, etc).
>
>                                                           Search_apply
> ----------------------------------------------------------------------
> Will act like the 'search' function, but will ask for either:
>      - a key to apply.
>      - a Bingo command line to execute (as if it were used with the
>      'cmd_line' function).
>      - a Chess command (as if it were used with the 'exec_chess'
>      function).
> when found.  It will work like the replace function, but instead of
> replacing, it will execute the given key.  DO NOT use this function
> while recording a macro.
>
>                                                        Mark_last_found
> ----------------------------------------------------------------------
> His will unmark the file and mark the last found text if you have not
> moved.
> ```

## Brief

Brief was first released in 1985. [texteditors.org](https://texteditors.org/cgi-bin/wiki.pl?BriefFamily)
has useful info on Brief and clones and emulators of it. [Wikipedia](https://en.wikipedia.org/wiki/Brief_(text_editor))
has similar lists. It is closed-source.

The changelog for [version 4.50](https://briefeditor.com/releases.htm)
states that it “Supports regular expression search and replace, both Brief and
Perl syntax”. It wouldn't make sense to invent a regexp syntax at the same
time as using Perl's, so I assume a version before 4.00 added Brief-syntax
regexps and is not listed. Only [Brief Professional](https://briefeditor.com/download.htm)
has “Find and replace using regular expressions”.

Versions:
- [Solutions Systems Brief 2.1](https://winworldpc.com/product/brief/2x)
- [Brief 3.1](https://archive.org/details/ibm-pc-brief-3.1-sn-br-225032) disk
  image (may have sources)
- [Brief 3.1 for DOS and OS2](https://winworldpc.com/product/brief/3x) manual
- [Brief 3.1 for OS2](https://winworldpc.com/product/brief/3x)
- [Solutions Systems Brief 3.1](https://winworldpc.com/product/brief/3x)
- [Brief 3.11](https://winworldpc.com/product/brief/3x)
- [Brief Basic 4.00](https://www.briefeditor.com/bin/brief400.msi) (msi)
- [Brief Basic 4.01](https://www.briefeditor.com/bin/brief401.msi) (msi)
- [Brief Basic 4.02](https://www.briefeditor.com/bin/brief402.msi) (msi)
- [Brief Basic 4.40](https://www.briefeditor.com/bin/brief440.msi) (msi)
- [Brief Basic 4.50](https://www.briefeditor.com/bin/brief450.msi) (msi)

## CRiSP

CRiSP [supports](https://crisp.com/core-features/) both Unix and Brief regular
expressions. It is closed-source.

Versions:
- [CRiSP 311399](https://archive.org/details/tucows_311399_CRiSP_Text_Editor) (exe)
- [CRiSP 311409](https://archive.org/details/tucows_311409_CRiSP_Text_Editor) (exe)
- [CRiSP 311411](https://archive.org/details/tucows_311411_CRiSP_Text_Editor) for OSX (dmg)

## ed

## Elvis

History: [[Wikipedia](https://en.wikipedia.org/wiki/Elvis_(text_editor))]

Elvis is an enhanced clone of vi. It has syntax highlighting, so should have
regular expressions.

## NED

Author: David L. Dight (1987-1993)

NED has regular expression search and replace.

Versions:
- NED v1.7a from [garbo.uwasi.fi](http://www.retroarchive.org/cdrom/garbo_dos/editor/nedit17a.zip)

From the NED v1.7a User's Guide (NED.DOC):

> ```
> NED v1.7a User's Guide
> Section 5.6    Regular Expression Reference
>
> Introduction
> This section  describes the  Regular Expression  Language
> used with  the SPECIFY  command. See section 5.1 for more
> details on this command. Regular expressions are a way of
> representing text  patterns in  a symbolic shorthand. The
> symbols used  to define  these expressions fall into five
> categories:
>
> Symbols that match a specific character
> Symbols that match any character
> Symbols that match a character's position on the line
> Symbols that match any of a set of characters or anything
> except a set of characters
> Symbols that let you match the previous symbol any number
> of times
>
> An expression  may be  made up of any or all of the above
> categories.
>
> CARAT (^)                                      Start line
>
> This symbol  matches any text at the beginning of a line.
> For example:
>
>      ^cat
>
> will match  the string "cat" only if it is located at the
> beginning of a line so that:
>
>      the cat
>
> would not be matched.
>
> DOLLAR ($)                                       End line
>
> This symbol  matches any  text at  the end of a line. For
> example:
>
>      cat$
>
> will match  the string "cat" only if it is located at the
> end of a line so that:
>
>      cat nap
>
> would not be matched.
>
> PERIOD (.)                                  Any character
>
> This symbol  matches any  one character.  Generally  this
> symbol by  itself will  always find  a match.  Its use is
> usually as a placeholder. For example:
>
>      c.t
>
> will match:
>
>      cat, cot, cut
>
> but will not match:
>
>      coot, coat or couch etc.
>
> ASTERISK (*)                        Match last expression
>
> This symbol matches zero or more matches of the preceding
> expression. For example:
>
>      c.*t
>
> will match:
>
>      cat, coat, chart, compliment
>
> Here the  preceding expression  is the  period. Therefore
> NED searches for any word starting with 'c' and ending in
> 't'.
>
> SQUARE BRACKETS ([])                      Character class
>
> The square brackets define a set of characters known as a
> character class.  NED will  then match  any character  in
> that  set.   Character  classes   are  usually   used  in
> conjunction with other language elements. For example:
>
>      c[aou]t
>
> will match:
>
>      cat, cot, cut
>
> but will not match:
>
>      cet, cit, cyt
>
> If the  first character  in the  brackets is  a carat (^)
> then  patterns  with  characters  not  appearing  in  the
> brackets will be searched for. For example:
>
>      c[^aou]t
>
> will not match:
>
>      cat, cot, cut
>
> but will match:
>
>      cit, cet, cft, czt
>
> The brackets  may also  be used  to specify ASCII ordered
> ranges by specifying the beginning and end of the range.
> For example:
>
>      c[a-z][A-Z]t
>
> matches any upper or lower case letter so that:
>
>      cat,cIt,crt,cGt
>
> will all be matched.
>
> SPECIAL CHARACTERS
>
> The regular  expression language allows you to search for
> the following special characters:
>
>      \t   tab
>      \s   space
>      \b   backspace
>
> The backslash  tells NED  that the character that follows
> is to  be treated  literally except  with the above three
> characters. Therefore  to search  for characters  used in
> the language, prefix them with the backslash as follows:
>
>      \\   backslash
>      \*   asterisk
>      \.   period
>      \^   carat
>      \[   left bracket
>      \]   right bracket
>      \$   dollar
>
> for example:
>
>      if\snot\s\[\*2\]
>
> will match:
>
>      if not [*2]
>
> EXAMPLES
>
> You can  form many  expressions using  the language. Here
> are a few examples:
>
>      [a-z][a-z]*ism
>
> Matches any  'ism' word e.g. 'prism'. In this example you
> must repeat  the character  class range twice to match it
> any number of times.
>
>      /\*.*\*/
>
> Matches any  comment line in a C program, for example: /*
> this is a comment */
>
> will be matched.
>
>      ^[\s\t]*REM.*$
>
> Matches any comment line in a BASIC program.
> The following expression:
>
>      ^[a-z][a-z]*[\s\t]*.*([^;]*)[^;]*$
>
> will find  any C function declaration with function body.
> The expression  searches for  beginning  of  a  line  (^)
> followed by  one or  more occurrences of any character in
> the range a to z ([a-z][a-z]*) followed by either a space
> or a  tab repeated zero or more times ([\s\t]*), followed
> by any  character  repeated  zero  or  more  times  (.*),
> followed by  an open  parenthesis  (()  followed  by  any
> character except a semi-colon repeated zero or more times
> ([^;]*), followed by a close parenthesis ()), followed by
> any character  except a  semi-colon repeated zero or more
> times ([^;]*)  followed  by  an  end  of  line  ($).  For
> example, the above expression would match:
>
>      WINDOW *get_window(int start,int finish,char *store)
>
> but not match:
>
>      WINDOW *get_window (int, int, char *);
>
> The above  example only  matches 'C'  function bodies and
> not function  prototypes. It  is useful  for compiling  a
> cross-reference of  all of  the functions in a module. As
> you can  see expressions  can  be  very  complicated  yet
> extremely powerful filters can be created.
> ```

## QED

## QEdit

## Zeus

[[site](https://www.zeusedit.com/index.html)]

Zeus has regexp search and replace, but [uses Unix-style](https://www.zeusedit.com/faq.html),
which is different from the original Brief. [Zeus Lite](https://www.zeusedit.com/lite/index.html)
still has search and replace with regexps.

Although is closed-source, the source for versions 1.04 and 2.15 is available.
CTAGS.C is taken from Elvis and changes to it are annotated.

Versions:
- [Zeus for Windows 1.04](https://archive.org/details/ZEUSV105_ZIP) (exe and source)
- [Zeus for Windows 2.15](https://archive.org/details/ZEUSV215_ZIP) (exe and source)
- [Zeus for WIN32 2.15](https://archive.org/details/ZE32V215_ZIP)
  [[alt](https://archive.org/details/ZE32V215.ZIP)] (exe and source):
  the two ZIPs have bit-identical contents, but are not bit-identical themselves
- [Zeus 3.00](https://archive.org/details/ze32v300_zip) (exe)
- [Zeus 3.20](https://archive.org/details/ze32v320_zip) (exe)
- [Zeus 3.30](https://archive.org/details/ze32v330_zip) (exe)
- [Zeus for Windows 3.40](https://archive.org/details/ze32v340_zip) (exe)
- [Zeus 3.99b](https://web.archive.org/web/20240427112542/https://www.zeusedit.com/z300/ze64v399b.zip)
  (exe, 64-bit installer)
- [Zeus 3.99b](https://web.archive.org/web/20240427112704/https://www.zeusedit.com/z300/ze32v399b.zip)
  (exe, 32-bit installer)
- [Zeus Lite (2024-04-27)](https://web.archive.org/web/20240427112627/https://www.zeusedit.com/lite/bin/zl.zip)
  (exe, full installer)
- [Zeus Lite (2024-04-27)](https://web.archive.org/web/20240427112643/https://www.zeusedit.com/lite/bin/zl-pe.zip)
  (exe, portable installer)

URLs for old versions on zeusedit.com redirect to the latest. As such, I link to
IA for stability.

Selected [changelog](https://www.zeusedit.com/whatsnew.html):
> - Zeus IDE - Version 3.97p
>   - New 'debug regular expression' feature
> - Zeus IDE - Version 3.97a
>   - Regular expression engine subexpression limit increased from 9 to 19

As of [2012-07-29](https://www.zeusedit.com/phpBB3/viewtopic.php?p=9833#p9833),
the latest beta “now does 0-9 and A-Z sub expressions”.

## TODO

Investigate whether these editors contained regular expression engines. They are
likely dead ends, but are among many editor search results in the
[DEMU Collection Unsorted](https://archive.org/search?query=subject%3A%22DEMU+Collection+Unsorted%22+editor),
which is what Zeus is archived in.

- [Hex-editor 1.02](https://archive.org/details/hdced102_zip)
- [Hex Workshop 3.02](https://archive.org/details/hw32v302_zip)
- [Maruo editor 3.01](https://archive.org/details/maruo301_zip)
- [Pc editor 2.5](https://archive.org/details/pcedi250_zip)
- [Personal Editor 32 1.0.5.0](https://archive.org/details/pe321050_zip),
  [v1.0.80](https://archive.org/details/pe321080_zip)
- [Quick Editor 1.8](https://archive.org/details/qiked18_zip),
  [v2.2c](https://archive.org/details/qiked22c_zip)
- [Roger's Postscript Text editor 4.4](https://archive.org/details/ROPS3244_ZIP)
- [The Hex Editor 1.5](https://archive.org/details/hexun15_zip)
