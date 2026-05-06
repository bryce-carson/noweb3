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

.PHONY: clear all

all : $(addprefix $(OUTPUT)/,lua liblua.so liblualib.so liblua.so.1.0)

clear	:
	rm -f *.o
	rm -f parser.c parser.h y.tab.c y.tab.h

$(OUTPUT)/lua : $(OUTPUT)/lua.o $(OUTPUT)/liblua.so $(OUTPUT)/liblualib.so
	$(CC) $(CFLAGS) -o $@ lua.o -L. -llua -llualib -lm

$(OUTPUT)/liblua.so : $(LUAOBJS)
	$(AR) $(ARFLAGS) $@ $?

$(OUTPUT)/liblualib.so : $(LIBOBJS)
	$(AR) $(ARFLAGS) $@ $?

$(OUTPUT)/liblua.so.1.0 : lua.o
	$(LD) -o liblua.so.1.0 $(LDFLAGS) $(LUAOBJS)

$(OUTPUT)/y.tab.c $(OUTPUT)/y.tab.h  : lua.stx
	yacc -d lua.stx -o $@

$(OUTPUT)/parser.c : $(OUTPUT)/y.tab.c
	sed -e 's/yy/luaY_/g' -e 's/malloc\.h/stdlib\.h/g' $(OUTPUT)/y.tab.c > $(OUTPUT)/parser.c

$(OUTPUT)/parser.h : $(OUTPUT)/y.tab.h
	sed -e 's/yy/luaY_/g' $(OUTPUT)/y.tab.h > $(OUTPUT)/parser.h

$(OUTPUT)/parser.o : $(OUTPUT)/parser.c $(OUTPUT)/parser.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -I. -o $@ $<

$(OUTPUT)/%.o : %.c
	$(CC) -c $(CFLAGS) $(LDFLAGS) -I. -o $@ $<

$(OUTPUT)/mathlib.o : mathlib.c lualib.h lua.h
	$(CC) -c $(CFLAGS) $(LDFLAGS) -lm -I. -o $@ $<
