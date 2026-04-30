srcdir = .
VPATH = $(srcdir)

TANGLEOBJS=$(OUTPUT)/notangle$(O) \
	$(OUTPUT)/getline$(O) \
	$(OUTPUT)/match$(O) \
	$(OUTPUT)/modules$(O) \
	$(OUTPUT)/modtrees$(O) \
	$(OUTPUT)/strsave$(O) \
	$(OUTPUT)/main$(O) \
	$(OUTPUT)/errors$(O) \
	$(OUTPUT)/columns$(O)

MARKUPOBJS=$(OUTPUT)/markmain$(O) \
	$(OUTPUT)/strsave$(O) \
	$(OUTPUT)/markup$(O) \
	$(OUTPUT)/errors$(O) \
	$(OUTPUT)/getline$(O) \
	$(OUTPUT)/columns$(O)

OBJS=$(TANGLEOBJS) $(MARKUPOBJS) $(OUTPUT)/nocond$(O) $(OUTPUT)/tie$(O)

TARGETS=$(OUTPUT)/markup$(E) \
	$(OUTPUT)/nocond$(E) \
	$(OUTPUT)/nt$(E) \
	$(OUTPUT)/tie$(E)

all: $(OUTPUT) $(TARGETS)

$(OUTPUT)/markup$(E): $(MARKUPOBJS)
	$(LD) $(LFLAGS)$@ $(MARKUPOBJS)

$(OUTPUT)/nocond$(E): $(OUTPUT)/nocond$(O)
	$(LD) $(LFLAGS)$@ $(OUTPUT)/nocond$(O)

$(OUTPUT)/nt$(E): $(TANGLEOBJS)
	$(LD) $(LFLAGS)$@ $(TANGLEOBJS)

$(OUTPUT)/tie$(E): $(OUTPUT)/tie$(O)
	$(LD) $(LFLAGS)$@ $(OUTPUT)/tie$(O)

clean:
	-$(RM) $(OBJS) 2>$(NUL)

clobber: clean
	-$(RM) $(TARGETS) 2>$(NUL)

$(OUTPUT)/columns$(O):	columns.c columns.h
	$(CC) $(CFLAGS)$@ columns.c
$(OUTPUT)/errors$(O):	errors.c errors.h
	$(CC) $(CFLAGS)$@ errors.c
$(OUTPUT)/getline$(O): getline.c columns.h errors.h getline.h
	$(CC) $(CFLAGS)$@ getline.c
$(OUTPUT)/main$(O):	main.c columns.h errors.h modtrees.h modules.h notangle.h
	$(CC) $(CFLAGS)$@ main.c
$(OUTPUT)/markmain$(O):	markmain.c columns.h errors.h getline.h markup.h
	$(CC) $(CFLAGS)$@ markmain.c
$(OUTPUT)/markup$(O):	markup.c errors.h markup.h strsave.h
	$(CC) $(CFLAGS)$@ markup.c
$(OUTPUT)/match$(O):	match.c match.h
	$(CC) $(CFLAGS)$@ match.c
$(OUTPUT)/modtrees$(O):	modtrees.c errors.h modtrees.h modules.h strsave.h
	$(CC) $(CFLAGS)$@ modtrees.c
$(OUTPUT)/modules$(O):	modules.c columns.h errors.h modtrees.h modules.h strsave.h
	$(CC) $(CFLAGS)$@ modules.c
$(OUTPUT)/nocond$(O):	nocond.c
	$(CC) $(CFLAGS)$@ nocond.c
$(OUTPUT)/notangle$(O):	notangle.c errors.h getline.h modtrees.h modules.h notangle.h strsave.h
	$(CC) $(CFLAGS)$@ notangle.c
$(OUTPUT)/strsave$(O):	strsave.c errors.h strsave.h
	$(CC) $(CFLAGS)$@ strsave.c
$(OUTPUT)/tie$(O):	tie.c
	$(CC) $(CFLAGS)$@ tie.c
