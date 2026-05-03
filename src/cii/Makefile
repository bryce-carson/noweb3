MAXALIGN=-DMAXALIGN=$(CIIMAXALIGN)

OBJS=$(addprefix $(OUTPUT)/,$(addsuffix .o,arena array assert atom except fmt list mem seq str))

all: $(OUTPUT)/libcii.so $(OUTPUT)/memchk.o

$(OUTPUT)/libcii.so: $(OBJS)
	$(AR) -rsc $@ $(OBJS)

$(OUTPUT)/%.o: $(srcdir)/cii/src/%.c
	$(CC) $(CFLAGS) -Iinclude $(MAXALIGN) $< -o $@

clean:
	-$(RM) $(OBJS)

clobber:	clean
	-$(RM) $(OUTPUT)/libcii$A $(OUTPUT)/*.o
