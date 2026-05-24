srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
VPATH := $(srcdir)

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
# TANGLE ?= more
# WEAVE ?= noweave
PLATFORM ?= "unix"

## INSTALL* is recommended by the GNU Coding Standards, and is extremely
## prevalent. It also enables a more maintainable Makefile.
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)
INSTALL_DATA ?= $(INSTALL) -m 644

NOCOND ?= ../tools/nocond

LUA_VERSION = 2


# Stop editing. No user-serviceable parts below.
.EXPORT_ALL_VARIABLES:
.PHONY: help all transfer builddirs installdirs tools cii lua-2.5.1 lua-3.2.2 code tex careful transfer checkclean checkdifferent checksame dvi install clean clobber



define help-helper
$(info ${1}: ${2})
$(info $(value ${1}))
endef
help :
	$(info Paths (Fedoran defaults))
	$(info ========================)
	$(call help-helper,PREFIX,The installation prefix to use.)
	$(call help-helper,BIN,The installation location for user programs.)
	$(call help-helper,LIBEXEC,The installation location for programs used only by user programs.)
	$(call help-helper,TEXINPUTS,The installation location for LaTeX and TeX style and class files.)
	$(call help-helper,SHELL,The shell to use when invoking recipe rules.)
	$(info  )
	$(info Compiler)
	$(info ========)
	$(call help-helper,CC,The command to invoke a C compiler.)
	$(call help-helper,CFLAGS,C compilation flags.)
	$(call help-helper,XCFLAGS,Additional C compilation flags specific to the compilation of 'no'.)
	$(call help-helper,CPPFLAGS,C preprocessor flags.)
	$(info  )
	$(info Linker-loader)
	$(info =============)
	$(call help-helper,LD,The command to invoke a C linker-loader.)
	$(call help-helper,LIBPROLOGUE,Anything that should precede LDFLAGS when invoking the linker-loader.)
	$(call help-helper,LDFLAGS,C linker-loader flags.)
	$(call help-helper,LIBEPILOGUE,Anything that should succeed LDFLAGS when invoking the linker-loader.)
	$(info  )
	$(info Archiver)
	$(info ========)
	$(call help-helper,AR,Archive-maintaining program.)
	$(call help-helper,ARFLAGS,Flags to give the archive-maintaining program.)
	$(call help-helper,RANLIB,The command to invoke ranlib.)
	$(info  )
	$(info 'no' Build Options)
	$(info ==================)
	$(call help-helper,PIPE,What system call should Rammel use?)
	$(call help-helper,XINCLUDES,Additional libraries to include when compiling.)
	$(call help-helper,LUA_VERSION,The Lua version to build, link, and embed.)
	$(call help-helper,CIIMAXALIGN,Affecting the linked CII library, the value for maximum alignment used when compiling CII; see CIIs index.html for more information.)
	$(info  )
	$(info Undocumented or Uncategorized Options)
	$(info =====================================)
	$(call help-helper,VPATH,A list of directories in which to search for make-target prerequisites.)
	$(call help-helper,BUILDDIR,The directory in which to build Rammel.)
	$(call help-helper,INSTALL,The program used to install programs or data.)
	$(call help-helper,INSTALL_PROGRAM,The options used with INSTALL to install programs.)
	$(call help-helper,INSTALL_DATA,The options used with INSTALL to install data.)
	$(call help-helper,PLATFORM,Either UNIX or NT.)
	$(call help-helper,POSIX,Whether or not this system is POSIX-compliant.)
	$(call help-helper,STRERROR,)
	$(call help-helper,POPEN,)
	$(call help-helper,TANGLE,A program used to tangle sources from web files.)
	$(call help-helper,TANGLEOPTS,Options passed to TANGLE.)
	$(call help-helper,WEAVE,A program used to weave web files into documents sources.)
	$(call help-helper,WEAVEOPTS,Options passed to WEAVE.)

Makefile:: ;
$(srcdir)/mkinstalldirs:: ;

all : code tex

tools lua cii lua-2.5.1 lua-3.2.2 lua-5.5.5:
	-$(srcdir)/mkinstalldirs $@
	$(MAKE) -C $@ -f "$(srcdir)/$@/Makefile"

tex : tools
	-$(srcdir)/mkinstalldirs $@
	$(MAKE) -C $@ -f "$(srcdir)/$@/Makefile" "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>"

TANGLEOPTS =  | ../tools/markup | ../tools/nt

code: TANGLEOPTS :=  | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)
code : tools cii lua-2.5.1
	-$(srcdir)/mkinstalldirs c
	$(info ==========================)
	$(info Building Rammel with Lua $(LUA_VERSION))
	$(info ==========================)
	$(MAKE) -C c -f "$(srcdir)/c/Makefile"        \
        "NOTANGLE=more"                         \
        "TANGLEOPTS=$(TANGLEOPTS)"              \
        "CPIF=>"                                \
        "LUA=../$(LUA_VERSION)"                 \
        "LUALIB=$(LUA_VERSION)"

# FIXME: what was this previously building? There is no scripts directory with a Makefile!
# scripts: TANGLEOPTS :=  | $(NOCOND) lua2 | $(NOCOND) $(PIPE) $(TANGLEOPTS)
# scripts : tools
# 	$(srcdir)/mkinstalldirs $@
# 	$(MAKE) -C $@ "NOTANGLE=more" "TANGLEOPTS=$(TANGLEOPTS)" "CPIF=>"

# Bootstrap Rammel with the tools, then build Rammel with Rammel.
careful : tools
	$(MAKE) clobber all clean
	-rm -rf $(BUILD_EXEC)/first
	# mkdir $(addprefix $(BUILD_EXEC)/,first first/c first/lua first/tex)
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/first/{c,lua,tex}
	cp -R $(BUILD_EXEC)/c/* $(BUILD_EXEC)/first/c
	cp -R $(BUILD_EXEC)/lua/* $(BUILD_EXEC)/first/lua
	cp -R $(BUILD_EXEC)/tex/* $(BUILD_EXEC)/first/tex

	$(MAKE) clobber tools cii lua-2.5.1
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
$(MAKE) -C $(srcdir) clobber tools cii $(if $(findstring "2",${2}),lua-2.5.1,lua-3.2.2)
$(srcdir)/mkinstalldirs $(BUILD_EXEC)/{,${1}${2}/}{c,lua,tex}
$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(NOCOND) $(PIPE) | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" $(if $(findstring "2",$2),"LUA=../lua-2.5","LUA=../lua-3.0") $(if $(findstring "2",$2),"LUALIB=$(LIBEXEC)/lua-2.5","LUALIB=$(LIBEXEC)/lua-3.0") "OUTPUT=$(BUILD_EXEC)/c"
$(MAKE) -C $(srcdir)/lua "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
$(MAKE) -C $(srcdir)/tex "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=$(LIBEXEC)/${1}b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
$(MAKE) -C $(srcdir)/c dvi "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
$(foreach d,c lua tex,cp $(wildcard -t $(BUILD_EXEC)/${1}${2}/${d} $(BUILD_EXEC)/${d}/*); )
endef


transfer:
	@echo "With noweb 2.11b, making Rammel with embeded Lua 2.5.1..."
	$(MAKE) -C $(srcdir) clobber all
	$(MAKE) -C $(srcdir)/c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c" dvi
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/2b/{c,lua,tex}
	$(foreach d,c lua tex,cp -t $(BUILD_EXEC)/2b/${d} $(wildcard $(BUILD_EXEC)/${d}/*); )



	@printf "\n\n\n\n\nWith noweb 2.11b, making Rammel with embeded Lua 3.2.2..."
	$(MAKE) -C $(srcdir) clobber tools cii lua-3.2.2
	$(srcdir)/mkinstalldirs $(BUILD_EXEC)/{,3b/}{c,lua,tex}
# TODO: understand the intended use of LUALIB; this vexes me.
	$(MAKE) -C $(srcdir)/c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "TOOLS=$(BUILD_EXEC)/tools" "LUA=${srcdir}/lua-3.2.2" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(BUILD_EXEC)/c"
	$(MAKE) -C $(srcdir)/lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/lua"
	$(MAKE) -C $(srcdir)/tex "NOTANGLE=more" "TANGLEOPTS= | $(BUILD_EXEC)/tools/markup | $(BUILD_EXEC)/tools/nt" "CPIF=>" "OUTPUT=$(BUILD_EXEC)/tex"
	$(MAKE) -C $(srcdir)/c dvi "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(BUILD_EXEC)/c"
	$(foreach d,c lua tex,cp -t $(BUILD_EXEC)/3b/${d} $(wildcard $(BUILD_EXEC)/${d}/*); )



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
	$(MAKE) -C $(srcdir)/c dvi

install : code tex | $(if $(strip $(DESTDIR)$(BIN)),$(DESTDIR)$(BIN),$(error "$(BIN) doesn't exist!")) $(srcdir)/mkinstalldirs
	$(srcdir)/mkinstalldirs $(DESTDIR)$(LIBEXEC) $(TEXINPUTS)
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(BIN) c/no c/nwmtime
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(LIBEXEC) $(wildcard lua/*)
	$(INSTALL_DATA) tex/noweb.sty $(DESTDIR)$(TEXINPUTS)/noweb.sty
	$(INSTALL_DATA) tex/nwmac.tex $(DESTDIR)$(TEXINPUTS)/nwmac.tex




soap = $(MAKE) --silent -C $(srcdir)/$(1) "OUTPUT=${BUILD_EXEC}/${1}" $(2);
clean :
	$(foreach d,c lua tools cii,$(call soap,$(d),clean))

clobber : clean
	$(foreach d,c lua tools cii,$(call soap,$(d),clobber))
	rm -f *~
