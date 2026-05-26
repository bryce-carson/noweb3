override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)

# makefile for lua hierarchy

all clean klean:
	$(foreach d,include src src/luac src/lib src/lua,mkdir -p ${d}; $(MAKE) -C ${d} -f $(srcdir)/${d}/Makefile $@; )

strip:
	strip bin/lua*
