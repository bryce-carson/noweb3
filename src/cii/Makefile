OBJS = $(addprefix $(OUTPUT)/,$(addsuffix .o,arena array assert atom except fmt list mem seq str))

.PHONY: Makefile all clean clobber

all: $(OUTPUT)/libcii.so $(OUTPUT)/memchk.o

$(OUTPUT)/libcii.so: $(OBJS)
	$(AR) -rsc $@ $(OBJS)

$(srcdir)/cii/src/%.c:: ;
$(OUTPUT)/%.o: $(srcdir)/cii/src/%.c
	$(CC) $(CFLAGS) -Iinclude -DMAXALIGN=${CIIMAXALIGN} $< -o $@

clean:
	-$(RM) $(OBJS)

clobber:	clean
	-$(RM) $(OUTPUT)/libcii.so $(OUTPUT)/*.o
