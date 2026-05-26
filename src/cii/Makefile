override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))/src
override VPATH := $(srcdir)


OBJS = $(addsuffix .o,arena array assert atom except fmt list mem seq str)

.PHONY: Makefile all clean clobber

all: libcii.so memchk.o

libcii.so: $(OBJS)
	$(AR) -rsc $@ $(OBJS)

%.o : %.c
	$(CC) $(CFLAGS) -I$(srcdir)/../include -DMAXALIGN=${CIIMAXALIGN} $< -o $@

clean :
	$(RM) $(OBJS)

clobber :	clean
	$(RM) libcii.so *.o
