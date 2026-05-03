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
ARFLAGS	= rvc

# Aplication modules
LUAOBJS = $(addprefix $(OUTPUT)/,$(addsuffix .o,parser lex opcode hash table inout tree fallback luamem func undump))

LIBOBJS = iolib.o mathlib.o strlib.o

lua : lua.o liblua.a liblualib.a
	$(CC) $(CFLAGS) -o $@ lua.o -L. -llua -llualib -lm

liblua.a : $(LUAOBJS)
	$(AR) $(ARFLAGS) $@  $?
	ranlib $@

liblualib.a : $(LIBOBJS)
	$(AR) $(ARFLAGS) $@  $?
	ranlib $@

liblua.so.1.0 : lua.o
	ld -o liblua.so.1.0 $(LUAOBJS)

y.tab.c y.tab.h  : lua.stx
	yacc -d lua.stx

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

# fallback.o : fallback.c luamem.h fallback.h lua.h opcode.h types.h tree.h func.h table.h
# func.o : func.c luadebug.h lua.h table.h tree.h types.h opcode.h func.h luamem.h
# hash.o : hash.c luamem.h opcode.h lua.h types.h tree.h func.h hash.h table.h
# inout.o : inout.c lex.h opcode.h lua.h types.h tree.h func.h inout.h table.h luamem.h
# iolib.o : iolib.c lua.h luadebug.h lualib.h
# lex.o : lex.c luamem.h tree.h types.h table.h opcode.h lua.h func.h lex.h inout.h luadebug.h parser.h
# lua.o : lua.c lua.h lualib.h
# mathlib.o : mathlib.c lualib.h lua.h
# luamem.o : luamem.c luamem.h lua.h
# opcode.o : opcode.c luadebug.h lua.h luamem.h opcode.h types.h tree.h func.h hash.h inout.h table.h fallback.h undump.h
# parser.o : parser.c luadebug.h lua.h luamem.h lex.h opcode.h types.h tree.h func.h hash.h inout.h table.h
# strlib.o : strlib.c lua.h lualib.h
# table.o : table.c luamem.h opcode.h lua.h types.h tree.h func.h hash.h table.h inout.h fallback.h luadebug.h
# tree.o : tree.c luamem.h lua.h tree.h types.h lex.h hash.h opcode.h func.h table.h
# undump.o : undump.c opcode.h lua.h types.h tree.h func.h luamem.h table.h undump.h
