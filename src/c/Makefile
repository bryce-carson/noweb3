CII=../cii
INCS=-I$(CII)/include -I$(LUA)/include



NOOBJS=$(addprefix $(OUTPUT)/,$(addsuffix .o,columns cpif env-lua errors       \
finduses fromascii getline ipipe ipipe-lua lua-help lua-main main markparse    \
markup misc-lua modtrees modules mpipe mpipe-lua notangle noweb-lua nwbuffer   \
nwbuffer-lua nwprocess nwtime recognize stages strsave sys util xpipe          \
xpipe-lua))



NWMTIMEOBJS=$(addprefix $(OUTPUT)/,$(addsuffix .o,columns errors getline nwmtime))



FILES = $(addsuffix .nw,columns cpif errors finduses getline ipipe ipipe-lua   \
lua-main main markparse markup match modtrees modules mpipe mpipe-lua notangle \
nwbuffer nwbuffer-lua nwmtime nwprocess nwtime recognize strsave xpipe         \
xpipe-lua)

# Sources to build when distributing C code (add all generated .c and .h files
# to this list)
SRCS = $(addprefix $(OUTPUT)/,cargs.h columns.c columns.h cpif.c cpif.h        \
env-lua.c env-lua.h errors.c errors.h finduses.c fromascii.c fromascii.h       \
getline.c getline.h ipipe-lua.c ipipe-lua.h ipipe.c ipipe.h lua-help.c         \
lua-help.h lua-main.c lua-main.h main.c markparse.c markparse.h markup.c       \
markup.h match.c match.h misc-lua.c misc-lua.h modtrees.c modtrees.h modules.c \
modules.h mpipe-lua.c mpipe-lua.h mpipe.c mpipe.h notangle.c notangle.h        \
noweb-lua.c noweb-lua.h nwbuffer-lua.c nwbuffer.c nwbuffer.h nwmtime.c         \
nwprocess.c nwprocess.h nwtime.c nwtime.h precompiled.h recognize.c recognize.h\
stages.c stages.h strsave.c strsave.h sys.c sys.h util.c util.h xpipe-lua.c    \
xpipe-lua.h xpipe.c xpipe.h)

# Define a metarule so rules aren't needed for each object file.
.c.o: ;
	$(CC) $(INCS) $(XCFLAGS) $(CFLAGS)$@ $*.c

all: $(OUTPUT)/no $(OUTPUT)/nwmtime

doc: $(OUTPUT)/doc.tex $(OUTPUT)/allcode.tex
	pdflatex -output-directory=$(OUTPUT) doc.tex >$(NUL)
	pdflatex -output-directory=$(OUTPUT) doc.tex >$(NUL)
	pdflatex -output-directory=$(OUTPUT) doc.tex

$(OUTPUT)/nwmtime$(E): $(NWMTIMEOBJS)
	$(LD) $(LFLAGS)$@ $(NWMTIMEOBJS)

$(OUTPUT)/no$(E): $(NOOBJS) $(LIBEXEC)/cii/memchk$(O) $(LIBEXEC)/cii/libcii$(A) $(LUALIB)/liblua$(A) $(LUALIB)/liblualib$(A)
	$(LD) $(LFLAGS)$@ $(NOOBJS) $(LIBPROLOG) $(LIBEXEC)/cii/libcii$(A) $(LUALIB)/liblua$(A) $(LUALIB)/liblualib$(A) $(LIBEPILOG)

touch: $(SRCS)
	touch $(SRCS)

clean:
	-$(RM) $(NOOBJS) 2>$(NUL)
	-$(RM) $(NWMTIMEOBJS) 2>$(NUL)
	-$(RM) $(SRCS) 2>$(NUL)
	-$(RM) $(OUTPUT)/nwbuffer-lua.0 2>$(NUL)
	-$(RM) $(OUTPUT)/nwbuffer-lua.1 2>$(NUL)
	-$(RM) $(OUTPUT)/nwbuffer-lua.2 2>$(NUL)
	-$(RM) $(OUTPUT)/nwbuffer-lua.3 2>$(NUL)
	-$(RM) $(OUTPUT)/allcode.tex 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.aux 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.log 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.out 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.tex 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.toc 2>$(NUL)

clobber:	clean
	-$(RM) $(OUTPUT)/nwmtime$(E) $(OUTPUT)/no$(E) 2>$(NUL)
	-$(RM) $(OUTPUT)/doc.pdf 2>$(NUL)

$(OUTPUT)/doc.tex:	doc.nw
	$(CP) doc.nw $@

$(OUTPUT)/allcode.tex:	$(FILES)
	$(OUTPUT)/no weave -ifilter "Stages.elide, 'hackers:*'" -n -index $(FILES) > $@





$(OUTPUT)/%.h: %.nw;
	$(TANGLE) $< $(TANGLEOPTS) -L$(subst SUBST,$<,"#line %L \"SUBST\"%N") -Rheader $(CPIF) $@

$(OUTPUT)/%.c: %.nw;
	$(TANGLE) $< $(TANGLEOPTS) -L$(subst SUBST,$<,"#line %L \"SUBST\"%N") $(CPIF) $@

$(OUTPUT)/nwbuffer-lua.c: nwbuffer.nw;
	$(TANGLE) $< $(TANGLEOPTS) -L$(subst SUBST,$<,"#line %L \"SUBST\"%N") -Rnwbuffer-lua.c $(CPIF) $@





$(OUTPUT)/columns.o: $(addprefix $(OUTPUT)/,cargs.h columns.h columns.c)
$(OUTPUT)/cpif.o: $(addprefix $(OUTPUT)/,cpif.h cpif.c errors.h strsave.h)
$(OUTPUT)/env-lua.o: $(addprefix $(OUTPUT)/,env-lua.h lua-help.h)
$(OUTPUT)/errors.o: $(addprefix $(OUTPUT)/,errors.c errors.h)
$(OUTPUT)/finduses.o: $(addprefix $(OUTPUT)/,errors.h finduses.c getline.h match.h nwbuffer.h recognize.h)
$(OUTPUT)/fromascii.o: $(addprefix $(OUTPUT)/,errors.h fromascii.c fromascii.h getline.h nwbuffer.h)
$(OUTPUT)/getline.o: $(addprefix $(OUTPUT)/,columns.h errors.h getline.c getline.h)
$(OUTPUT)/ipipe.o: $(addprefix $(OUTPUT)/,ipipe.c ipipe.h nwbuffer.h nwtime.h)
$(OUTPUT)/ipipe-lua.o: $(addprefix $(OUTPUT)/,ipipe-lua.c ipipe-lua.h)
$(OUTPUT)/lua-help.o: $(addprefix $(OUTPUT)/,lua-help.c lua-help.h)
$(OUTPUT)/lua-main.o: $(addprefix $(OUTPUT)/,env-lua.h ipipe-lua.h lua-main.c lua-main.h misc-lua.h mpipe-lua.h noweb-lua.h stages.h util.h xpipe-lua.h)
$(OUTPUT)/main.o: $(addprefix $(OUTPUT)/,cargs.h columns.h cpif.h errors.h main.c modtrees.h modules.h notangle.h nwbuffer.h)
$(OUTPUT)/markparse.o: $(addprefix $(OUTPUT)/,columns.h errors.h getline.h markparse.c markparse.h markup.h nwbuffer.h)
$(OUTPUT)/markup.o: $(addprefix $(OUTPUT)/,errors.h markup.c markup.h strsave.h)
$(OUTPUT)/misc-lua.o: $(addprefix $(OUTPUT)/,lua-help.h misc-lua.c misc-lua.h)
$(OUTPUT)/modtrees.o: $(addprefix $(OUTPUT)/,errors.h modtrees.c modtrees.h modules.h strsave.h)
$(OUTPUT)/modules.o: $(addprefix $(OUTPUT)/,columns.h errors.h modtrees.h modules.c modules.h strsave.h)
$(OUTPUT)/mpipe.o: $(addprefix $(OUTPUT)/,fromascii.h ipipe.h mpipe.c mpipe.h nwbuffer.h xpipe.h)
$(OUTPUT)/mpipe-lua.o: $(addprefix $(OUTPUT)/,lua-help.h mpipe.h mpipe-lua.c mpipe-lua.h)
$(OUTPUT)/notangle.o: $(addprefix $(OUTPUT)/,errors.h getline.h match.h modtrees.h modules.h notangle.c notangle.h nwbuffer.h strsave.h)
$(OUTPUT)/noweb-lua.o: $(addprefix $(OUTPUT)/,lua-help.h noweb-lua.c noweb-lua.h util.h)
$(OUTPUT)/nwbuffer.o: $(addprefix $(OUTPUT)/,nwbuffer.c nwbuffer.h)
$(OUTPUT)/nwbuffer-lua.o: $(addprefix $(OUTPUT)/,lua-help.h nwbuffer.h nwbuffer-lua.c)
$(OUTPUT)/nwmtime.o: $(addprefix $(OUTPUT)/,getline.h nwmtime.c)
$(OUTPUT)/nwprocess.o: $(addprefix $(OUTPUT)/,nwprocess.c nwprocess.h)
$(OUTPUT)/nwtime.o: $(addprefix $(OUTPUT)/,nwtime.c nwtime.h)
$(OUTPUT)/recognize.o: $(addprefix $(OUTPUT)/,recognize.c)
$(OUTPUT)/stages.o: $(addprefix $(OUTPUT)/,cargs.h fromascii.h lua-help.h markparse.h notangle.h nwbuffer.h stages.c stages.h)
$(OUTPUT)/strsave.o: $(addprefix $(OUTPUT)/,errors.h strsave.c strsave.h)
$(OUTPUT)/sys.o: $(addprefix $(OUTPUT)/,sys.c sys.h)
$(OUTPUT)/util.o: $(addprefix $(OUTPUT)/,precompiled.h sys.h util.c util.h)
$(OUTPUT)/xpipe.o: $(addprefix $(OUTPUT)/,errors.h nwprocess.h sys.h util.h xpipe.c xpipe.h)
$(OUTPUT)/xpipe-lua.o: $(addprefix $(OUTPUT)/,cargs.h lua-help.h xpipe.h xpipe-lua.c xpipe-lua.h)
