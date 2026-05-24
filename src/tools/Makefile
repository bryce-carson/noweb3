override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)

TANGLEOBJS=$(addprefix ,$(addsuffix .o,notangle getline match modules modtrees strsave main errors columns))
MARKUPOBJS=$(addprefix ,$(addsuffix .o,markmain strsave markup errors getline columns))
OBJS=$(TANGLEOBJS) $(MARKUPOBJS) nocond.o tie.o

.PHONY: all clean clobber Makefile
all: markup nocond nt tie

clean:
	-rm -f $(OBJS)

clobber: clean
	-rm -f $(addprefix ,markup nocond nt tie)




markup: $(MARKUPOBJS)
	$(CC) -o $@ $(LDFLAGS) $^

nt: $(TANGLEOBJS)
	$(CC) -o $@ $(LDFLAGS) $^

nocond: nocond.o
	$(CC) -o $@ $(LDFLAGS) $^

tie: tie.o
	$(CC) -o $@ $(LDFLAGS) $^

%.o : %.c ; $(CC) $(CFLAGS) -I$(srcdir) -c $< -o $@

columns.o: columns.c columns.h
errors.o: errors.c errors.h
getline.o: getline.c columns.h errors.h getline.h
main.o: main.c columns.h errors.h modtrees.h modules.h notangle.h
markmain.o: markmain.c columns.h errors.h getline.h markup.h
markup.o: markup.c errors.h markup.h strsave.h
match.o: match.c match.h
modtrees.o: modtrees.c errors.h modtrees.h modules.h strsave.h
modules.o: modules.c columns.h errors.h modtrees.h modules.h strsave.h
nocond.o: nocond.c
notangle.o: notangle.c errors.h getline.h modtrees.h modules.h notangle.h strsave.h
strsave.o: strsave.c errors.h strsave.h
tie.o: tie.c
