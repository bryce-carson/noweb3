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

PLATFORM ?= "unix"

## INSTALL* is recommended by the GNU Coding Standards, and is extremely
## prevalent. It also enables a more maintainable Makefile.
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)
INSTALL_DATA ?= $(INSTALL) -m 644

TOOLS ?= $(srcdir)/../build/tools
NOCOND ?= $(TOOLS)/nocond
MARKUP ?= $(TOOLS)/markup
NT ?= $(TOOLS)/nt
NOTANGLE=more
TANGLEOPTS= | $(MARKUP) | $(NT)
CPIF=>

LUA_VERSION = 2

LATEXMK_OPTS = -latex -dvi
TEXMF_DIR = /usr/share/texlive/texmf-dist


# Stop editing. No user-serviceable parts below.
.EXPORT_ALL_VARIABLES:
.PHONY: help all transfer builddirs installdirs tools cii lua lua-2.5.1 lua-3.2.2 code tex careful checkclean checkdifferent checksame dvi install clean clobber



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
	@$(srcdir)/mkinstalldirs $@
	@$(MAKE) -C $@ -f $(srcdir)/$@/Makefile

# To tangle is to fight, especially when there are no options.
# I was tired of fighting, so I created this function with these options:
# fight ${1} ${2}: 1 is either $(NT) or "no tangle", 2 is 2 or 3.
# $(call fight,$(MARKUP) | $(NT),2)
# $(call fight,$(MARKUP) | $(NT),3)
# $(call fight,$(LIBEXEC)/${1}b/c/no tangle,2)
# $(call fight,$(LIBEXEC)/${1}b/c/no tangle,3)
fight =  | $(NOCOND) lua${2} | $(NOCOND) $(PIPE) | ${1}

tex : tools
	-@$(srcdir)/mkinstalldirs $@
	-@$(MAKE) -C $@ -f "$(srcdir)/$@/Makefile" "TANGLEOPTS=$(TANGLEOPTS)"

CP_C_LUA_TEX = $(foreach d,c lua tex, $(intcmp $(words $(wildcard ${d}/*)),0,,,cp -t ${1}${2}/${d} $(wildcard ${d}/*); ))
# Cf: GNU make options -C and -f
Cf = -C $(if $(findstring b,${1}),,${1}${2}/)${3} -f $(srcdir)/${3}/Makefile

MAKE_DVI = $(MAKE) $(call Cf,${1},${2},c) dvi "NWPATH=../lua" "NOWEAVE=../c/no weave" "NOTANGLE=../c/no tangle"

define with_m_make_n
@printf "=========================================================================\n"
@printf "With %s, making Rammel with embeded Lua %s...\n" "$(if $(findstring b,${1}),noweb 2.11b,Rammel with embedded Lua $(if $(findstring 2,$(1)),2.5.1,3.2.2))" "$(if $(findstring 2,${2}),2.5.1,3.2.2)"
@printf "=========================================================================\n"
$(MAKE) -f $(srcdir)/Makefile clobber tools cii $(if $(findstring 2,${2}),"lua-2.5.1","lua-3.2.2")
$(srcdir)/mkinstalldirs $(if $(findstring b,${1}),,${1}${2}/){c,lua,tex}
# Cf: GNU make options -C and -f
$(MAKE) $(call Cf,${1},${2},c) "NWPATH=../lua" "TANGLEOPTS=$(call fight,$(if $(findstring b,${1}),$(MARKUP) | $(NT),$(srcdir)/../../${1}${2}/c/no tangle),$(if $(findstring b,${1}),2,${2}))" $(if $(findstring 2,$2),"LUA=../lua-2.5.1","LUA=../lua-3.2.2") $(if $(findstring 2,${2}),"LUALIB=$(LIBEXEC)/lua-2.5.1","LUALIB=$(LIBEXEC)/lua-3.2.2")
$(MAKE) $(call Cf,${1},${2},lua) "NWPATH=../lua" "TANGLEOPTS=$(call fight,$(if $(findstring b,${1}),$(MARKUP) | $(NT),$(srcdir)/../../${1}${2}/c/no tangle),$(if $(findstring b,${1}),2,${2}))"
$(MAKE) $(call Cf,${1},${2},tex) "NWPATH=../lua" "NOWEAVE=../c/no weave" "NOTANGLE=../c/no tangle" "TANGLEOPTS=$(if $(findstring "b",${1}),$(call fight,$(MARKUP) | $(NT),2),)"
$(call MAKE_DVI,${1},${2})
$(call CP_C_LUA_TEX,${1},${2})
endef

code :
	$(call with_m_make_n,b,2)

transfer : code
	$(call with_m_make_n,b,3)
	$(call with_m_make_n,2,2)
	$(call with_m_make_n,2,3)
	$(call with_m_make_n,3,2)
	$(call with_m_make_n,3,3)

# check differences
	$(MAKE) clean checkclean checkdifferent checksame

checkclean :
	@echo "Let's see how different it is..."
	$(foreach clean_target,2b 22 23 3b 32 33,$(RM) $(addprefix ${clean_target}/c/,$(wildcard *.exe *.log *.obj *.dvi)))

checkdifferent_fn=$(DIFF) $(foreach other,3b 32 33,$1 ${other})
checkdifferent :
	$(foreach other,2b 22 23,$(call checkdifferent_fn, ${other}))

checksame :
	@echo "Let's see how similar it is..."
	$(DIFF) 2b 22
	$(DIFF) 22 23
	$(foreach other,3b 32,$(call checkdifferent_fn, ${other}))

dvi :
	$(MAKE) -f $(srcdir)/c/Makefile dvi

install : code tex | $(if $(strip $(DESTDIR)$(BIN)),$(DESTDIR)$(BIN),$(error "$(BIN) doesn't exist!")) $(srcdir)/mkinstalldirs
	$(srcdir)/mkinstalldirs $(DESTDIR)$(LIBEXEC) $(TEXINPUTS)
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(BIN) c/no c/nwmtime
	$(INSTALL_PROGRAM) --target-directory $(DESTDIR)$(LIBEXEC) $(wildcard lua/*)
	$(INSTALL_DATA) tex/noweb.sty $(DESTDIR)$(TEXINPUTS)/noweb.sty
	$(INSTALL_DATA) tex/nwmac.tex $(DESTDIR)$(TEXINPUTS)/nwmac.tex

uninstall :
	rm -f $(DESTDIR)$(BIN)/{no,nwmtime}
	rm -f $(DESTDIR)$(TEXINPUTS)/{noweb.sty,nwmac.tex}
	rm -rf $(DESTDIR)$(LIBEXEC)

soap = $(MAKE) --silent -C $(srcdir)/$(1) $(2);
clean :
	$(foreach d,c lua tools cii,$(call soap,$(d),clean))

clobber : clean
	$(foreach d,c lua tools cii,$(call soap,$(d),clobber))
	rm -f *~
