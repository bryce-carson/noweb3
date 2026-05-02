$(if $(findstring "undefined",$(origin OUTPUT)), $(error "The variable OUTPUT was undefined!"))

TANGLEOBJS=$(addprefix $(OUTPUT)/,$(addsuffix .o,notangle getline match modules modtrees strsave main errors columns))
MARKUPOBJS=$(addprefix $(OUTPUT)/,$(addsuffix .o,markmain strsave markup errors getline columns))
OBJS=$(TANGLEOBJS) $(MARKUPOBJS) $(OUTPUT)/nocond.o $(OUTPUT)/tie.o

all: $(OUTPUT) $(addprefix $(OUTPUT)/,markup nocond nt tie)

$(OUTPUT)/markup: $(MARKUPOBJS)
	$(CC) -o$@ $(LDFLAGS) $^

$(OUTPUT)/nt: $(TANGLEOBJS)
	$(CC) -o$@ $(LDFLAGS) $^

$(OUTPUT)/nocond: $(OUTPUT)/nocond.o
	$(CC) -o$@ $(LDFLAGS) $^

$(OUTPUT)/tie: $(OUTPUT)/tie.o
	$(CC) -o$@ $(LDFLAGS) $^

clean:
	-$(RM) $(OBJS)

clobber: clean
	-$(RM) $(addprefix $(OUTPUT)/,markup nocond nt tie)

$(OUTPUT)/columns.o:	columns.c columns.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ columns.c
$(OUTPUT)/errors.o:	errors.c errors.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ errors.c
$(OUTPUT)/getline.o: getline.c columns.h errors.h getline.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ getline.c
$(OUTPUT)/main.o:	main.c columns.h errors.h modtrees.h modules.h notangle.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ main.c
$(OUTPUT)/markmain.o:	markmain.c columns.h errors.h getline.h markup.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ markmain.c
$(OUTPUT)/markup.o:	markup.c errors.h markup.h strsave.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ markup.c
$(OUTPUT)/match.o:	match.c match.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ match.c
$(OUTPUT)/modtrees.o:	modtrees.c errors.h modtrees.h modules.h strsave.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ modtrees.c
$(OUTPUT)/modules.o:	modules.c columns.h errors.h modtrees.h modules.h strsave.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ modules.c
$(OUTPUT)/nocond.o:	nocond.c
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ nocond.c
$(OUTPUT)/notangle.o:	notangle.c errors.h getline.h modtrees.h modules.h notangle.h strsave.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ notangle.c
$(OUTPUT)/strsave.o:	strsave.c errors.h strsave.h
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ strsave.c
$(OUTPUT)/tie.o:	tie.c
	$(CC) $(CFLAGS) -I$(OUTPUT) -o$@ tie.c
