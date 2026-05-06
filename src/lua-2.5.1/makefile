# CONFIGURATION
# define (undefine) POPEN if your system (does not) support piped I/O
# define (undefine) _POSIX_SOURCE if your system is (not) POSIX compliant
# define (undefine) NOSTRERROR if your system does NOT have function "strerror"
# (although this is ANSI, SunOS does not comply; so, add "-DNOSTRERROR" on SunOS)
CONFIG = -DPOPEN -D_POSIX_SOURCE
# Compilation parameters
CC = gcc
CFLAGS = $(CONFIG) -Wall -Wmissing-prototypes -Wshadow -ansi -O2 -pedantic

AR = ar
ARFLAGS = rsc

# Aplication modules
LUAOBJS = $(addprefix $(OUTPUT)/,$(addsuffix .o,parser lex opcode hash table inout tree fallback luamem func undump))

LIBOBJS = $(addprefix $(OUTPUT)/,iolib.o mathlib.o strlib.o)

all : $(OUTPUT)/lua

$(OUTPUT)/lua : $(OUTPUT)/lua.o $(OUTPUT)/liblua.so $(OUTPUT)/liblualib.so
	$(CC) $(CFLAGS) -o $@ -I. -lm $^

$(OUTPUT)/liblua.so : $(LUAOBJS)
	$(AR) $(ARFLAGS) $@ $?

$(OUTPUT)/liblualib.so : $(LIBOBJS)
	$(AR) $(ARFLAGS) $@ $?

$(OUTPUT)/liblua.so.1.0 : lua.o
	$(LD) -o liblua.so.1.0 $(LDFLAGS) $(LUAOBJS)

y.tab.c y.tab.h : lua.stx
	yacc -d lua.stx -o $@

parser.c : y.tab.c
	sed -e 's/yy/luaY_/g' -e 's/malloc\.h/stdlib\.h/g' y.tab.c > parser.c

parser.h : y.tab.h
	sed -e 's/yy/luaY_/g' y.tab.h > parser.h

clear	:
	rm -f *.o
	rm -f parser.c parser.h y.tab.c y.tab.h

$(OUTPUT)/parser.o : parser.c parser.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -I. -o $@ $<

$(OUTPUT)/%.o : %.c
	$(CC) -c $(CFLAGS) $(LDFLAGS) -I. -o $@ $<

$(OUTPUT)/mathlib.o : mathlib.c lualib.h lua.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -lm -I. -o $@ $<
