# Extension instructions

The instruction prefix tree is not full, so extended instructions may be defined
that are prefixed with STT, TSTL, TSL, TTL, TLSL, TLTL, TLL, LLS, or LLT. As
these are non-standard, few implementations support them and the syntax is
conflicting.

- STT: `Invert` (STT), `Shuffle` (STTS)
- TTL: `x-dump` (TTL)
- TLSS: `printc` (TLSS), `OutputStack` (TLSSS)
- TLSL: `x-args` (TLSL)
- TLTLS: `x-readfile` (TLTLS)
- TLTLT: `x-closefile` (TLTLT)
- TLTLL: `x-writefile` (TLTLL)
- TLL: `shell` (TLL)
- LLS: `PYFN` (LLS), `debug_printstack` (LLSSS), `debug_printheap` (LLSST)
- LLT: `Trace` (LLT), `eval` (LLT)

## Burghard

[wsintercpp](https://github.com/wspace/burghard-wsintercpp), [wsinterws](https://github.com/wspace/burghard-wsinterws),
and [wsa](https://github.com/wspace/burghard-wsa) by Oliver Burghard define the
following instructions:

| Mnemonic           | Syntax | Arg | Stack | Description |
| ------------------ | ------ | --- | ----- | ----------- |
| `debug_printstack` | LLSSS  |     | --    | Dump stack  |
| `debug_printheap`  | LLSST  |     | --    | Dump heap   |

## whitespace-nd

[whitespace-nd](https://github.com/haroldl/whitespace-nd) by Harold Lee defines
the following instruction:

| Mnemonic  | Syntax | Arg | Stack                | Description                                           |
| --------- | ------ | --- | -------------------- | ----------------------------------------------------- |
| `Shuffle` | STTS   |     | a0 .. an -- s0 .. sn | Randomly permute the order of all values on the stack |

## JBanana

[Whitespace](https://codeberg.org/JBanana/whitespace) by JBanana defines the
following instructions:

| Mnemonic      | Syntax | Arg | Stack            | Description                     |
| ------------- | ------ | --- | ---------------- | ------------------------------- |
| `x-dump`      | TTL    |     | --               | XDump                           |
| `x-args`      | TLSL   |     | -- arg           | Read from the program arguments |
| `x-readfile`  | TLTLS  |     | file -- ptr code | Read from a file                |
| `x-writefile` | TLTLL  |     | ch file -- code  | Write to a file                 |
| `x-closefile` | TLTLT  |     | file --          | Close a file                    |

## pywhitespace

[pywhitespace](https://github.com/wspace/phlip-pywhitespace) by Phillip Bradbury
defines the following instruction:

| Mnemonic | Syntax | Arg | Stack | Description        |
| -------- | ------ | --- | ----- | ------------------ |
| `Trace`  | LLT    |     | --    | Dump program state |

## whitespacesdk

[whitespacesdk](https://github.com/wspace/mash-whitespacesdk) by MArtin SHerratt
defines the following instructions:

| Mnemonic      | Syntax            | Arg | Stack                | Description                           |
| ------------- | ----------------- | --- | -------------------- | ------------------------------------- |
| `Invert`      | STT               |     | a0 .. an -- an .. a0 | Invert the stack                      |
| `OutputStack` | TLSSS (conflicts) |     | .. --                | Output the entire stack as characters |

## PYWS

[PYWS](https://github.com/EizoAssik/pyws) by Eizo Assik defines the following
instruction:

| Mnemonic | Syntax | Arg | Stack                       | Description                                                   |
| -------- | ------ | --- | --------------------------- | ------------------------------------------------------------- |
| `PYFN`   | LLS    | l   | a1 .. an -- a1 .. an retval | Call the Python function registered as *l* with *n* arguments |

## Spiceweight

[Spiceweight](https://github.com/collidedscope/spiceweight) by Collided Scope
defines the following instructions:

| Mnemonic | Syntax | Arg | Stack         | Description                                                                                                                                   |
| -------- | ------ | --- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `shell`  | TLL    |     | cmd -- output | Execute shell command *cmd* and push its output (stdout and stderr), where *cmd* and *output* are base-128 numbers representing ASCII strings |

## Spitewaste

[Spitewaste](https://github.com/collidedscope/spitewaste) by Collided Scope
defines the following instructions:

| Mnemonic | Syntax | Arg | Stack | Description                           |
| -------- | ------ | --- | ----- | ------------------------------------- |
| `shell`  | TLL    | s   | ?     | Execute shell command (unimplemented) |
| `eval`   | LLT    | s   | ?     | (unimplemented)                       |
