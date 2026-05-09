srcdir ?= .

## System calls
PIPE ?= fork

## Paths (defaulting to Fedora paths)
PREFIX ?= /usr
BIN ?= $(PREFIX)/bin
LIBEXEC ?= $(PREFIX)/libexec/rammel
TEXINPUTS ?= $(PREFIX)/share/texlive/texmf-local/tex/latex/rammel
SHELL ?= $(PREFIX)/bin/bash

## Compiler, linker-loader, and archiver options
## Compiler
CC ?= gcc
CFLAGS ?= -ansi -pedantic -std=c11 -c
XCFLAGS ?= 
## FIXME: these are fragile! Hack on all of these so a sigle definition can be
## used: POSIX; NWDEFAULTDIR is required on all systems, but POSIX alone should
## be sufficient compared to PLATFORM, POSIX, _POSIX_SOURCE, and nw_unix!
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

BUILDDIR ?= $(realpath $(srcdir)/../build)
VPATH  ?= $(BUILDDIR)

BUILD_EXEC ?= $(BUILDDIR)$(LIBEXEC)
$(srcdir)/mkinstalldirs:: ;
BUILD ?= $(srcdir)/mkinstalldirs | $(BUILD_EXEC)

NOCOND ?= $(BUILD_EXEC)/tools/nocond

LUA_VERSION = 2





# Stop editing. No user-serviceable parts below.
.EXPORT_ALL_VARIABLES:
Makefile:: ;
.PHONY: help all transfer installdirs tools ciilib lualib lualib3 code scripts styles careful transfer checkclean checkdifferent checksame dvi install clean clobber

# help-helper = @printf "%s: %s\n" $1 $2; printf "%s\n" "$(value ${1})";
help :
# 	$(call help-helper,PIPE,What system call should Rammel use?)

# 	@echo "==========================================================="
# 	@echo "Paths (defaults designed for a user-installation on Fedora)"
# 	@echo "==========================================================="
# 	$(call help-helper,PREFIX,The installation prefix to use.)
# 	$(call help-helper,BIN,The installation location for user programs.)
# 	$(call help-helper,LIBEXEC,The installation location for programs used only by user programs.)
# 	$(call help-helper,TEXINPUTS,The installation location for LaTeX and TeX style and class files.)
# 	$(call help-helper,SHELL,The shell to use when invoking recipe rules.)

# 	@echo "============================================="
# 	@echo "Compiler, linker-loader, and archiver options"
# 	@echo "============================================="
# 	@echo "Compiler"
# 	@echo "--------"
# 	$(call help-helper,CC,The command to invoke a C compiler.)
# 	$(call help-helper,CFLAGS,C compilation flags.)
# 	$(call help-helper,XCFLAGS,Additional C compilation flags specific to the compilation of 'no'.)
# 	$(call help-helper,CPPFLAGS,C preprocessor flags.)

# 	@echo "Linker-loader"
# 	@echo "-------------"
# 	$(call help-helper,LD,The command to invoke a C linker-loader.)
# 	$(call help-helper,LIBPROLOGUE,Anything that should precede LDFLAGS when invoking the linker-loader.)
# 	$(call help-helper,LDFLAGS,C linker-loader flags.)
# 	$(call help-helper,LIBEPILOGUE,Anything that should succeed LDFLAGS when invoking the linker-loader.)

# 	@echo "Archiver and its options"
# 	@echo "------------------------"
# 	$(call help-helper,AR,Archive-maintaining program.)
# 	$(call help-helper,ARFLAGS,Flags to give the archive-maintaining program.)
# 	$(call help-helper,RANLIB,The command to invoke ranlib.)

# 	$(call help-helper,CIIMAXALIGN,The value for maximum alignment used when compiling CII; see CIIs index.html for more information.)

# 	$(call help-helper,XINCLUDES,Additional libraries to include when compiling the 'no' command.)

# 	$(call help-helper,POPEN,document this option.)
# 	$(call help-helper,POSIX,Whether or not this system is POSIX-compliant.)
# 	$(call help-helper,STRERROR,document this option.)

# 	$(call help-helper,LUA_VERSION,The Lua version to use.)

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





TANGLEOPTS =  | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt
code: TANGLEOPTS :=  | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)
code : tools ciilib lualib
	$(MAKE) -C $(srcdir)/c                      \
        "NOTANGLE=more"                       \
        "TANGLEOPTS= $(TANGLEOPTS)"           \
        "CPIF=>"                              \
        "TOOLS=$(BUILD_EXEC)/tools"           \
        "LUA=../$(LUA_VERSION)"               \
        "LUALIB=$(BUILD_EXEC)/$(LUA_VERSION)" \
        "OUTPUT=$(BUILD_EXEC)/c"
scripts: TANGLEOPTS :=  | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)
scripts : tools
	$(MAKE) -C $(srcdir)/lua "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
styles : tools
	$(MAKE) -C $(srcdir)/../docs/tex "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"





careful :
	$(MAKE) clobber all clean
	-rm -rf $(BUILD_EXEC)/first
	# mkdir $(addprefix $(BUILD_EXEC)/,first first/c first/lua first/tex)
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/first/{c,lua,tex}
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

	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/first/lua" "OUTPUT=$(BUILD_EXEC)/c" doc
	-$(RMDIR) $(BUILD_EXEC)/first

	$(MAKE) all clean





define with_m_make_n
@printf "With Rammel with embedded Lua %s, making Rammel with embeded Lua %s...\n" $(if $(findstring "2",$(1)),"2.5.1","3.2.2") $(if $(findstring "2",${1}),"2.5.1","3.2.2")
$(MAKE) -C $(srcdir) clobber tools ciilib $(if $(findstring "2",${2}),lualib,lualib3)
$(srcdir)/mkinstalldirs $(BUILD_EXEC)/{,${1}${2}/}{c,lua,tex}
$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(NOCOND) $(PIPE) | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" $(if $(findstring "2",$2),"LUA=../lua-2.5","LUA=../lua-3.0") $(if $(findstring "2",$2),"LUALIB=$(LIBEXEC)/lua-2.5","LUALIB=$(LIBEXEC)/lua-3.0") "OUTPUT=$(BUILD_EXEC)/c"
$(MAKE) -C $(srcdir)/lua "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
$(MAKE) -C $(srcdir)/tex "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=$(LIBEXEC)/${1}b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
$(MAKE) -C $(srcdir)/c dvi "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/${1}${2}/${d}; )
endef


transfer:
	@echo "With noweb 2.11b, making Rammel with embeded Lua 2.5.1..."
	$(MAKE) -C $(srcdir) clobber all
	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c" dvi
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/2b/{c,lua,tex}
	$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/2b/${d}; )



	@echo "With noweb 2.11b, making Rammel with embeded Lua 3.2.2..."
	$(MAKE) -C $(srcdir) clobber tools ciilib lualib3
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/{,3b/}{c,lua,tex}
# TODO: understand the intended use of LUALIB; this vexes me.
	$(MAKE) -C $(srcdir)/c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "TOOLS=$(BUILD_EXEC)/tools" "LUA=${srcdir}/lua-3.2.2" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(BUILD_EXEC)/c"
	$(MAKE) -C $(srcdir)/lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
	$(MAKE) -C $(srcdir)/tex "NOTANGLE=more" "TANGLEOPTS= | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
	$(MAKE) -C $(srcdir)/c dvi "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
	$(foreach d,c lua tex,cp -R $(wildcard $(BUILD_EXEC)/${d}/*) $(BUILD_EXEC)/3b/${d}; )



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
	$(MAKE) -C $(srcdir)/c "OUTPUT=$(BUILD_EXEC)/c" dvi

install : installdirs code scripts styles | $(if $(strip $(DESTDIR)$(BIN)),$(DESTDIR)$(BIN),$(error "$(BIN) doesn't exist!"))
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(BIN) $(addprefix $(BUILD_EXEC)/c/,no nwmtime)
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(LIBEXEC) $(wildcard $(BUILD_EXEC)/lua/*)
	$(INSTALL_DATA) $(BUILD_EXEC)/tex/noweb.sty $(DESTDIR)$(TEXINPUTS)/noweb.sty
	$(INSTALL_DATA) $(BUILD_EXEC)/tex/nwmac.tex $(DESTDIR)$(TEXINPUTS)/nwmac.tex




soap = $(MAKE) --silent -C $(srcdir)/$(1) "OUTPUT=${BUILD_EXEC}/${1}" $(2);
clean :
	$(foreach d,c lua tools cii,$(call soap,$(d),clean))

clobber : clean
	$(foreach d,c lua tools cii,$(call soap,$(d),clobber))
	rm -f *~
