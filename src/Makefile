srcdir ?= .

## System calls
PIPE ?= fork

## Paths
BIN ?= /usr/bin
LIBEXEC ?= /usr/libexec/rammel
TEXINPUTS ?= /usr/share/texlive/texmf-local/tex/latex/rammel
SHELL ?= /usr/bin/bash

## Compiler, linker-loader, and archiver options
## Compiler
CC ?= gcc
CFLAGS ?= -ansi -pedantic -std=c11 -c
XCFLAGS ?= 
CPPFLAGS ?= -DNWDEFAULTDIR=\"'$(LIBEXEC)'\" -DPLATFORM='$(PLATFORM)' -DPOSIX -D_POSIX_SOURCE -Dnw_unix
## Linker-loader
LD ?= gcc
LIBPROLOGUE ?= 
LDFLAGS ?= -lc
LIBEPILOGUE ?= 

## Archiver
AR ?= ar
RANLIB ?= ranlib

CIIMAXALIGN ?= 

XINCLUDES ?= 

POPEN ?= 
POSIX ?= 
STRERROR ?= 

## These are built-in make variables, and may as well be overridden with noweb
## variants (when not initialized as more).
TANGLE ?= more
WEAVE ?= noweave
PLATFORM ?= "unix"

## INSTALL* is recommended by the GNU Coding Standards, and is extremely
## prevalent. It also enables a more maintainable Makefile.
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)
INSTALL_DATA ?= $(INSTALL) -m 644

BUILDDIR ?= $(srcdir)/../build
VPATH  ?= $(BUILDDIR)

BUILD_EXEC ?= $(BUILDDIR)$(LIBEXEC)
BUILD ?= $(srcdir)/mkinstalldirs | $(BUILD_EXEC)

NOCOND ?= $(BUILD_EXEC)/tools/nocond

LUA_VERSION = 2

# Stop editing. No user-serviceable parts below.
.EXPORT_ALL_VARIABLES :
.PHONY : help transfer install pdf

help :
	@echo "PIPE (by default, \"$(PIPE)\"): What system call should Rammel use? fork | pipe"
	@echo "BIN (by default, \"$(BIN)\"): The installation location for user programs."
	@echo "LIBEXEC (by default, \"$(LIBEXEC)\"): The installation location for programs used only by user programs."
	@echo "TEXINPUTS (by default, \"$(TEXINPUTS)\"): The installation location for LaTeX and TeX style and class files."
	@echo "SHELL (by default, \"$(SHELL)\"): The shell to use when invoking recipe rules."
	@echo "CC (by default, \"$(CC)\"): The command to invoke a C compiler."
	@echo "CFLAGS (by default, \"$(CFLAGS)\"): C compilation flags."
	@echo "XCFLAGS (by default, \"$(XCFLAGS)\"): Additional C compilation flags specific to the compilation of no''"
	@echo "LD (by default, \"$(LD)\"): The command to invoke a C linker-loader."
	@echo "LIBPROLOGUE (by default, \"$(LIBPROLOGUE)\"): Anything that should precede LDFLAGS when invoking the linker-loader."
	@echo "LDFLAGS (by default, \"$(LDFLAGS)\"): C linker-loader flags."
	@echo "LIBEPILOGUE (by default, \"$(LIBEPILOGUE)\"): Anything that should succeed LDFLAGS when invoking the linker-loader."
	@echo "AR (by default, \"$(AR)\"): The command to invoke a C archiver."
	@echo "RANLIB (by default, \"$(RANLIB)\"): The command to invoke ranlib."
	@echo "CIIMAXALIGN (by default, \"$(CIIMAXALIGN)\"): The value for maximum alignment used when compiling CII; see CIIs index.html for more information."
	@echo "XINCLUDES (by default, \"$(XINCLUDES)\"): Additional libraries to include when compiling the no' command.'"
	@echo "POPEN (by default, \"$(POPEN)\"): TODO: document this option."
	@echo "POSIX (by default, \"$(POSIX)\"): Whether or not this system is POSIX-compliant."
	@echo "STRERROR (by default, \"$(STRERROR)\"): TODO: document this option."

all : code scripts styles

installdirs : $(srcdir)/mkinstalldirs
	$(srcdir)/mkinstalldirs $(DESTDIR)$(LIBEXEC) $(TEXINPUTS)

$(BUILD_EXEC) : $(srcdir)/mkinstalldirs
	$(srcdir)/mkinstalldirs $(addprefix $(BUILD_EXEC)/,tools cii lua-2.5.1 lua-3.2.2 c lua tex)

tools : $(BUILD)
	$(MAKE) -C $(srcdir)/tools "OUTPUT=$(BUILD_EXEC)/tools"

ciilib : $(BUILD)
	$(MAKE) -C $(srcdir)/cii "OUTPUT=$(BUILD_EXEC)/cii"

lualib : $(BUILD)
	$(MAKE) -C $(srcdir)/lua-2.5.1 "OUTPUT=$(BUILD_EXEC)/lua-2.5.1"

lualib3 : $(BUILD)
	$(MAKE) -C $(srcdir)/lua-3.2.2 "OUTPUT=$(BUILD_EXEC)/lua-3.2.2"

TANGLEOPTS = " | $(addprefix $(BUILD_EXEC)/tools/,markup nt)"
code: TANGLEOPTS = " | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)"
code : tools ciilib lualib
	$(MAKE) -C $(srcdir)/c                      \
        "NOTANGLE=more"                       \
        "TANGLEOPTS= $(TANGLEOPTS)"           \
        "CPIF=>"                              \
        "TOOLS=$(BUILD_EXEC)/tools"           \
        "LUA=../$(LUA_VERSION)"               \
        "LUALIB=$(BUILD_EXEC)/$(LUA_VERSION)" \
        "OUTPUT=$(BUILD_EXEC)/c"

scripts: TANGLEOPTS = " | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)"
scripts : tools
	$(MAKE) -C $(srcdir)/lua "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"

styles : tools
	$(MAKE) -C $(srcdir)/../docs/tex "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"

careful :
	$(MAKE) clobber all clean
	-$(RMDIR) $(BUILD_EXEC)/first
	mkdir $(addprefix $(BUILD_EXEC)/,first first/c first/lua first/tex)
	cp -R $(BUILD_EXEC)/c/* $(BUILD_EXEC)/first/c
	cp -R $(BUILD_EXEC)/lua/* $(BUILD_EXEC)/first/lua
	cp -R $(BUILD_EXEC)/tex/* $(BUILD_EXEC)/first/tex

	$(MAKE) clobber tools ciilib lualib
	-mkdir $(BUILD_EXEC)/c
	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/first/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(BUILD_EXEC)/c"

	-mkdir $(LIBEXEC)/lua
	$(MAKE) -C $(srcdir)/lua "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"

	-mkdir $(LIBEXEC)/tex
	$(MAKE) -C $(srcdir)/tex "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"

	@echo "At this point we are attempting to BUILD the literate version."
	@echo "It may fail if you have not previously installed noweb.sty."

	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/first/lua" "OUTPUT=$(BUILD_EXEC)/c" doc
	-$(RMDIR) $(BUILD_EXEC)/first

	$(MAKE) all clean





define with_m_make_n
$(foreach t,clobber tools ciilib $(if $(findstring "2",${2}),"lualib","lualib3"),$(MAKE) ${t})
$(foreach d,$(addprefix $(BUILD_EXEC)/,c lua tex ${1}${2} ${1}${2}/c ${1}${2}/lua ${1}${2}/tex), mkdir ${d})
$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(NOCOND) $(PIPE) | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" $(if $(findstring "2",$2),"LUA=../lua-2.5","LUA=../lua-3.0") $(if $(findstring "2",$2),"LUALIB=$(LIBEXEC)/lua-2.5","LUALIB=$(LIBEXEC)/lua-3.0") "OUTPUT=$(BUILD_EXEC)/c"
$(MAKE) -C $(srcdir)/lua "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
$(MAKE) -C $(srcdir)/tex "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=$(LIBEXEC)/${1}b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
$(MAKE) -C $(srcdir)/c doc "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/${1}${2}/${d})
endef

transfer:
# noweb_2_11b->Rammel with Lua 2
	$(MAKE) clobber all
	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c" doc
	$(foreach d,$(addprefix $(BUILD_EXEC)/,2b 2b/c 2b/lua 2b/tex), mkdir ${d})
	$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/2b/${d})



# noweb_2_11b->Rammel with Lua 3
	$(foreach t,clobber tools ciilib lualib3,$(MAKE) ${t})
	$(foreach d,$(addprefix $(BUILD_EXEC)/,c lua tex 3b 3b/c 3b/lua 3b/tex), mkdir ${d})
	$(MAKE) -C $(srcdir)/c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(BUILD_EXEC)/c"
	$(MAKE) -C $(srcdir)/lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
	$(MAKE) -C $(srcdir)/tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
	$(MAKE) -C $(srcdir)/c doc "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
	$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/3b/${d})



	$(call with_m_make_n,2,2)# Rammel with Lua 2->Rammel with Lua 2
	$(call with_m_make_n,2,3)# Rammel with Lua 2->Rammel with Lua 3
	$(call with_m_make_n,3,2)# Rammel with Lua 3->Rammel with Lua 2
	$(call with_m_make_n,3,3)# Rammel with Lua 3->Rammel with Lua 3



# check differences
	$(MAKE) clean checkclean checkdifferent checksame





checkclean :
	@echo "Let's see how different it is..."
	$(foreach clean_target,2b 22 23 3b 32 33,$(RM) $(addprefix $(BUILD_EXEC)/${clean_target}/c/,$(wildcard *.exe *.log *.obj *.dvi)))

checkdifferent_fn=$(DIFF) $(foreach other,3b 32 33,$(BUILD_EXEC)/$1 $(BUILD_EXEC)/${other})
checkdifferent :
	$(foreach other,2b 22 23,$(call checkdifferent_fn, ${other}))

checksame :
	@echo "Let's see how similar it is..."
	$(DIFF) $(BUILD_EXEC)/2b $(BUILD_EXEC)/22
	$(DIFF) $(BUILD_EXEC)/22 $(BUILD_EXEC)/23
	$(foreach other,3b 32,$(call checkdifferent_fn, ${other}))

dvi :
	@echo "Building the PDF may fail if you don't have no installed properly."
	$(MAKE) -C $(srcdir)/c "OUTPUT=$(BUILD_EXEC)/c" dvi

install : installdirs code scripts styles | $(if $(strip $(DESTDIR)$(BIN)),$(DESTDIR)$(BIN),$(error "$(BIN) doesn't exist!"))
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(BIN) $(addprefix $(BUILD_EXEC)/c/,no nwmtime)
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(LIBEXEC) $(wildcard $(BUILD_EXEC)/lua/*)
	$(INSTALL_DATA) $(BUILD_EXEC)/tex/noweb.sty $(DESTDIR)$(TEXINPUTS)/noweb.sty
	$(INSTALL_DATA) $(BUILD_EXEC)/tex/nwmac.tex $(DESTDIR)$(TEXINPUTS)/nwmac.tex

clean :
	$(MAKE) -C $(srcdir)/tools "OUTPUT=$(BUILD_EXEC)/tools" clobber
	-$(RMDIR) $(BUILD_EXEC)/tools

	$(MAKE) -C $(srcdir)/cii "OUTPUT=$(BUILD_EXEC)/cii" clobber
	-$(RMDIR) $(BUILD_EXEC)/cii

	$(MAKE) -C $(srcdir)/lua-2.5 $(LuaMakefile) "OUTPUT=$(BUILD_EXEC)/lua-2.5" clobber
	-$(RMDIR) $(BUILD_EXEC)/lua-2.5

	$(MAKE) -C $(srcdir)/c "OUTPUT=$(BUILD_EXEC)/c" clean
	$(MAKE) -C $(srcdir)/lua "OUTPUT=$(BUILD_EXEC)/lua" clean
	$(MAKE) -C $(srcdir)/tex "OUTPUT=$(BUILD_EXEC)/tex" clean
	-$(RM) *~



clobber : clean
	$(MAKE) -C $(srcdir)/c "OUTPUT=$(BUILD_EXEC)/c" clobber
	-$(RMDIR) $(BUILD_EXEC)/c

	$(MAKE) -C $(srcdir)/lua "OUTPUT=$(BUILD_EXEC)/lua" clobber
	-$(RMDIR) $(BUILD_EXEC)/lua

	$(MAKE) -C $(srcdir)/tex "OUTPUT=$(BUILD_EXEC)/tex" clobber
	-$(RMDIR) $(BUILD_EXEC)/tex
