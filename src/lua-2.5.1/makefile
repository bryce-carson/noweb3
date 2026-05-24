override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)


# CONFIGURATION
# define (undefine) POPEN if your system (does not) support piped I/O
# define (undefine) _POSIX_SOURCE if your system is (not) POSIX compliant
# define (undefine) NOSTRERROR if your system does NOT have function "strerror"
# (although this is ANSI, SunOS does not comply; so, add "-DNOSTRERROR" on SunOS)
# Compilation parameters
CC = gcc
CFLAGS = -DPOPEN -D_POSIX_SOURCE -Wall -Wmissing-prototypes -Wshadow -ansi -O2 -pedantic -I$(srcdir)

AR = ar
ARFLAGS = rsc

# Aplication modules
LUAOBJS = $(addsuffix .o,parser lex opcode hash table inout tree fallback luamem func undump)

LIBOBJS = iolib.o mathlib.o strlib.o

.PHONY: clear clobber
lua : lua.o liblua.so liblualib.so
	$(CC) $(CFLAGS) -lm -o $@ $^

liblua.so : $(LUAOBJS)
	$(AR) $(ARFLAGS) $@ $?

liblualib.so : $(LIBOBJS)
	$(AR) $(ARFLAGS) $@ $?

liblua.so.1.0 : lua.o
	$(LD) -o liblua.so.1.0 $(LDFLAGS) $(LUAOBJS)

y.tab.c y.tab.h : lua.stx
	yacc -d lua.stx -o $@

parser.c : y.tab.c
	sed -e 's/yy/luaY_/g' -e 's/malloc\.h/stdlib\.h/g' y.tab.c > parser.c

parser.h : y.tab.h
	sed -e 's/yy/luaY_/g' y.tab.h > parser.h

parser.o : parser.c parser.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -o $@ $<

%.o : %.c
	$(info $(srcdir))
	$(info $(VPATH))
	$(CC) -c $(CFLAGS) $(LDFLAGS) -o $@ $<

mathlib.o : mathlib.c lualib.h lua.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -lm -o $@ $<





clear :
	rm -f *.o
	rm -f parser.c parser.h y.tab.c y.tab.h
