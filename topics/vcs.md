# Tools for VCSes other than Git

[cvs2gitdump](https://github.com/yasuoka/cvs2gitdump) may be useful (code from
it is used by the Software Heritage archive to [load CVS repos](https://forge.softwareheritage.org/source/swh-loader-cvs/browse/master/docs/)),
but it doesn't convert any branches.

[cvs-fast-export](http://www.catb.org/~esr/cvs-fast-export/cvs-fast-export.html)
may be better (or something exporting the git fast-export format), but it is
listed in the alternatives section of cvs2gitdump, so may be worse.

[reposurgeon](http://www.catb.org/~esr/reposurgeon/reposurgeon.html) may be
useful for history editing.
