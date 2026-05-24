<!-- -*- mode: markdown; -*- -->
Rammel is:

> *Noweb version 3* with a lot of changes; and
>
> © 2026 Bryce Carson.

Rammel is a copyrighten work ultimately derived from [Norman Ramsey's *noweb* version 3](https://github.com/nrnrnr/noweb3), a copyrighten work. Noweb is available free of charge. Reports of software bugs in Rammel are welcomed using the GitHub Issues feature.

Rammel is available free of charge for any use in any field of endeavor. The *original `COPYRIGHT` file **contents*** of Norman Ramsey's noweb version 3 are quoted below; Rammel is a derivative work with its own name, so the COPYRIGHT file needn't be retained, only the notice below.

> Noweb is copyright 1989-2015 by Norman Ramsey.  All rights reserved.
>
> Noweb is protected by copyright.  It is not public-domain
> software or shareware, and it is not protected by a ``copyleft''
> agreement like the one used by the Free Software Foundation.
>
> Noweb is available free for any use in any field of endeavor.  You may
> redistribute noweb in whole or in part provided you acknowledge its
> source and include this COPYRIGHT file.  You may modify noweb and
> create derived works, provided you retain this copyright notice, but
> the result may not be called noweb without my written consent.
>
> You may sell noweb if you wish.  For example, you may sell a CD-ROM
> including noweb.
>
> You may sell a derived work, provided that all source code for your
> derived work is available, at no additional charge, to anyone who buys
> your derived work in any form.  You must give permisson for said
> source code to be used and modified under the terms of this license.
> You must state clearly that your work uses or is based on noweb and
> that noweb is available free of change.  You must also request that
> bug reports on your work be reported to you.
>
> If this license does not meet your needs, write to nr@cs.tufts.edu
> to discuss terms.
>
> Noweb version 3 incorporates elements of Lua version 2.5 and CII
> version 1.11, both used by permission.

You are given permission to use Rammel similarly.

# Components
Rammel uses:

- any of [**PUC Rio's** *Lua 2.5.1*, *Lua 3.2.2*, or *Lua 5.5.0*](https://www.lua.org/);
- the same subselection of interfaces and implementations from [**Dave Hanson's** *C Interfaces and Implementations*](https://drh.github.io/cii/) as used in the original noweb version 3;
- [***GNU** Make*](https://www.gnu.org/software/make/) for building Rammel from sources;
- mkinstalldirs, a public domain script available in [*Gnulib*](https://www.gnu.org/software/gnulib/).

Rammel is derived from [David Zitzelsberger's modified version of noweb version 3](https://github.com/dazitzel/noweb3), and David deserves all credit for the work of converting the filters and stages written in Ramseys's custom *lua2.5+nw* to standard *Lua 2.5* an standard *Lua 3* syntax.

# Building Rammel from Sources
## UNIX or GNU
Requirements: GNU Make; Rammel sources. The Makefiles for each component of the software have been written with features of GNU Make not available in other implementations of Make.

First, configure the build by modifying the variables in `src/Makefile`.

Second, call `make all`, using `src/Makefile` as the makefile, set the variable `srcdir` to `src`, and set `BUILDDIR` to a build directory.

I use the following BASH script to build the software, install it, and generate the documentation. The current usage of a `BUILDDIR` and `srcdir` variable is really clunky and on my TODO list to improve. For now, it works.

```bash
rammel=~/src/rammel
function make-rammel () {
    test "build" = $(basename $(pwd)) || exit 1
    make -f ${rammel}/src/Makefile srcdir=${rammel}/src $1
}
cd $rammel
test -d build
rm -rf build
mkdir build
cd build
make-rammel all && sudo make-rammel install && make-rammel dvi
cd $rammel
```

## Windows
Utilize WSL 2 and install any Linux distribution you prefer, then install the packages required for GNU Make and the GNU Compiler Collection (GCC).

I won't take the time to make the GNU Makefile compatible with MSYS2 UCRT so that native EXEs and DLLs can be produced; if you'd like to contribute towards this you're welcome to, but instead I highly recommend pursuing use of WSL 2.

# Documentation
Rammel's documentation is a work in progress, and is, of course, derived from the documentation of noweb version 3. Contributions and suggestions are welcome.
