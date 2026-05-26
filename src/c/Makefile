override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)


INCS = $(foreach d,c cii/include, -I$(abspath $(srcdir)/../${d}))



ifeq ($(LUA_VERSION),2)
LUA_VERSION = lua-2.5.1
INCS += -I$(abspath $(srcdir)/../$(LUA_VERSION))

else ifeq ($(LUA_VERSION),3)
LUA_VERSION = lua-3.2.2
INCS += -I$(abspath $(srcdir)/../$(LUA_VERSION)/include)

else ifeq ($(LUA_VERSION),5)
LUA_VERSION = lua-5.5.0
INCS += -I$(abspath $(srcdir)/../$(LUA_VERSION)/src)

else
$(error "LUA_VERSION must be one of 2, 3, or 5 to select 2.5.1, 3.2.2, or 5.5.0 respectively.")

endif



NOOBJS = $(addsuffix .o,columns cpif env-lua errors finduses fromascii getline  \
ipipe ipipe-lua lua-help lua-main main markparse markup misc-lua modtrees       \
modules mpipe mpipe-lua notangle noweb-lua nwbuffer nwbuffer-lua nwprocess      \
nwtime recognize stages strsave sys util xpipe xpipe-lua)

NWMTIMEOBJS=$(addsuffix .o,columns errors getline nwmtime)



# Sources to build when distributing C code (add all generated .c and .h files
# to this list)
SRCS = cargs.h columns.c columns.h cpif.c cpif.h                                \
env-lua.c env-lua.h errors.c errors.h finduses.c fromascii.c fromascii.h        \
getline.c getline.h ipipe-lua.c ipipe-lua.h ipipe.c ipipe.h lua-help.c          \
lua-help.h lua-main.c lua-main.h main.c markparse.c markparse.h markup.c        \
markup.h match.c match.h misc-lua.c misc-lua.h modtrees.c modtrees.h modules.c  \
modules.h mpipe-lua.c mpipe-lua.h mpipe.c mpipe.h notangle.c notangle.h         \
noweb-lua.c noweb-lua.h nwbuffer-lua.c nwbuffer.c nwbuffer.h nwmtime.c          \
nwprocess.c nwprocess.h nwtime.c nwtime.h precompiled.h recognize.c recognize.h \
stages.c stages.h strsave.c strsave.h sys.c sys.h util.c util.h xpipe-lua.c     \
xpipe-lua.h xpipe.c xpipe.h


all : no nwmtime



CFLAGS += -g

dvi : doc.tex allcode.tex
	@echo "Building the literate program and user documentation..."
	@echo "Building the literate program will likey fail if you have not built and installed the installed the program already."
	@echo "Building the literate program and user documentation requires John Collins' latexmk."
	-latexmk -interaction=nonstopmode doc.tex

nwmtime : $(NWMTIMEOBJS)
	$(CC) $(filter-out -c,$(CFLAGS)) $(CPPFLAGS) $(LDFLAGS) $(NWMTIMEOBJS) -o $@

no: LIB = ../cii/libcii.so ../$(LUA_VERSION)/liblua.so ../$(LUA_VERSION)/liblualib.so
no : $(NOOBJS) $(LIB)
	$(CC) $(filter-out -c,$(CFLAGS)) $(XCFLAGS) $(CPPFLAGS) $(XINCLUDES) $(LDFLAGS) -lm $(NOOBJS) $(LIBPROLOGUE) $(LIB) $(LIBEPILOGUE) -o $@

touch : $(SRCS)
	touch $(SRCS)

clean :
	rm -f $(NOOBJS) $(NWMTIMEOBJS) $(SRCS) $(wildcard nwbuffer-lua* allcode.tex doc.tex)

clobber : clean
	rm -f no nwmtime doc.dvi

doc.tex : doc.nw
	cp $< $@

FILES = $(addsuffix .nw,columns cpif errors finduses getline ipipe ipipe-lua    \
lua-main main markparse markup match modtrees modules mpipe mpipe-lua notangle  \
nwbuffer nwmtime nwprocess nwtime recognize strsave xpipe                       \
xpipe-lua)

allcode.tex : $(FILES)
	$(NOWEAVE) -ifilter "Stages.elide, 'hackers:*'" -n -index $^ > $@

# Define a metarule so rules aren't needed for each object file.
.c.o : ;
	$(CC) $(INCS) $(CFLAGS) $(CPPFLAGS) -o $@ $*.c

LINEOPT = -L$(subst SUBST,$<,"#line %L \"SUBST\"%N")

%.h : %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(LINEOPT) -Rheader $(CPIF) $@

%.c : %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(LINEOPT) $(CPIF) $@

nwbuffer-lua.c : nwbuffer.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(LINEOPT) -Rnwbuffer-lua.c $(CPIF) $@





columns.o : cargs.h columns.h columns.c
cpif.o : cpif.h cpif.c errors.h strsave.h
env-lua.o : env-lua.h lua-help.h cargs.h
errors.o : errors.c errors.h
finduses.o : errors.h finduses.c getline.h match.h nwbuffer.h recognize.h
fromascii.o : errors.h fromascii.c fromascii.h getline.h nwbuffer.h
getline.o : columns.h errors.h getline.c getline.h
ipipe.o : ipipe.c ipipe.h nwbuffer.h nwtime.h
ipipe-lua.o : ipipe-lua.c ipipe-lua.h
lua-help.o : lua-help.c lua-help.h cargs.h
lua-main.o : env-lua.h ipipe-lua.h lua-main.c lua-main.h misc-lua.h mpipe-lua.h noweb-lua.h stages.h util.h xpipe-lua.h
main.o : cargs.h columns.h cpif.h errors.h main.c modtrees.h modules.h notangle.h nwbuffer.h
markparse.o : columns.h errors.h getline.h markparse.c markparse.h markup.h nwbuffer.h
markup.o : errors.h markup.c markup.h strsave.h
misc-lua.o : lua-help.h misc-lua.c misc-lua.h
modtrees.o : errors.h modtrees.c modtrees.h modules.h strsave.h
modules.o : columns.h errors.h modtrees.h modules.c modules.h strsave.h
mpipe.o : fromascii.h ipipe.h mpipe.c mpipe.h nwbuffer.h xpipe.h
mpipe-lua.o : lua-help.h mpipe.h mpipe-lua.c mpipe-lua.h
notangle.o : errors.h getline.h match.h modtrees.h modules.h notangle.c notangle.h nwbuffer.h strsave.h
noweb-lua.o : lua-help.h noweb-lua.c noweb-lua.h util.h
nwbuffer.o : nwbuffer.c nwbuffer.h
nwbuffer-lua.o : lua-help.h nwbuffer.h nwbuffer-lua.c
nwmtime.o : getline.h nwmtime.c
nwprocess.o : nwprocess.c nwprocess.h
nwtime.o : nwtime.c nwtime.h
recognize.o : recognize.c
stages.o : cargs.h fromascii.h lua-help.h markparse.h notangle.h nwbuffer.h stages.c stages.h
strsave.o : errors.h strsave.c strsave.h
sys.o : sys.c sys.h
util.o : precompiled.h sys.h util.c util.h
xpipe.o : errors.h nwprocess.h sys.h util.h xpipe.c xpipe.h
xpipe-lua.o : cargs.h lua-help.h xpipe.h xpipe-lua.c xpipe-lua.h
