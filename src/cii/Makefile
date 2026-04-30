I=include
MAXALIGN=-DMAXALIGN=$(CIIMAXALIGN)
CIIFLAGS=-I$I $(MAXALIGN)
BUILDDIR=$(OUTPUT)/

# $Id$
OBJS=	$(BUILDDIR)/arena.o \
	$(BUILDDIR)/array.o \
	$(BUILDDIR)/assert.o \
	$(BUILDDIR)/atom.o \
	$(BUILDDIR)/except.o \
	$(BUILDDIR)/fmt.o \
	$(BUILDDIR)/list.o \
	$(BUILDDIR)/mem.o \
	$(BUILDDIR)/seq.o \
	$(BUILDDIR)/str.o

all:: $(BUILDDIR)/libcii.so $(BUILDDIR)/memchk.o

$(BUILDDIR)libcii.so:: $(OBJS)
		$(AR)$@ $(OBJS) && $(RANLIB) $@

$(BUILDDIR)/arena.o	: src/arena.c 	; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/arena.c
$(BUILDDIR)/array.o	: src/array.c 	; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/array.c
$(BUILDDIR)/assert.o : src/assert.c 	; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/assert.c
$(BUILDDIR)/atom.o   : src/atom.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/atom.c
$(BUILDDIR)/except.o : src/except.c 	; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/except.c
$(BUILDDIR)/fmt.o		: src/fmt.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/fmt.c
$(BUILDDIR)/list.o	 	: src/list.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/list.c
$(BUILDDIR)/mem.o		: src/mem.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/mem.c
$(BUILDDIR)/memchk.o : src/memchk.c 	; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/memchk.c
$(BUILDDIR)/seq.o		: src/seq.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/seq.c
$(BUILDDIR)/str.o		: src/str.c 		; $(CC) $(CIIFLAGS) $(CFLAGS)$@ src/str.c



clean::
		-$(RM) $(OBJS)

clobber::	clean
		-$(RM) $(BUILDDIR)/libcii$A $(BUILDDIR)/*.o

# DO NOT DELETE THIS LINE -- make depend depends on it.

$(BUILDDIR)/arena.o:		$I/assert.h $I/except.h $I/arena.h
$(BUILDDIR)/array.o:		$I/assert.h $I/except.h $I/array.h	$I/arrayrep.h $I/mem.h
$(BUILDDIR)/assert.o:	$I/assert.h $I/except.h
$(BUILDDIR)/atom.o:		$I/atom.h		$I/assert.h $I/except.h $I/mem.h
$(BUILDDIR)/except.o:	$I/assert.h $I/except.h
$(BUILDDIR)/fmt.o:			$I/assert.h $I/except.h $I/fmt.h		$I/mem.h
$(BUILDDIR)/list.o:		$I/assert.h $I/except.h $I/mem.h		$I/list.h
$(BUILDDIR)/mem.o:			$I/assert.h $I/except.h $I/mem.h
$(BUILDDIR)/memchk.o:	$I/assert.h $I/except.h $I/mem.h
$(BUILDDIR)/seq.o:			$I/assert.h $I/except.h $I/seq.h		$I/array.h		$I/arrayrep.h $I/mem.h
$(BUILDDIR)/str.o:			$I/assert.h $I/except.h $I/fmt.h		$I/str.h			$I/mem.h
