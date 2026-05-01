$(guile (load "options.scm"))

## These are built-in make variables, and may as well be overridden with noweb
## variants.
TANGLE=notangle
WEAVE=noweave

## INSTALL* is recommended by the GNU Coding Standards, and is extremely
## prevalent. It also enables a more maintainable Makefile.
INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
INSTALL_DATA=$(INSTALL) -m 644

## TODO: finish this!
## THE FOLLOWING SECTION IS FROM GROK, ANSWERING HOW TO SUPPORT OUT-OF-TREE BUILDS
BUILDDIR ?= ../build
VPATH = $(BUILDDIR)

# $(BUILDDIR)/%.o: %.c
# 	@mkdir -p $(BUILDDIR)
# 	$(CC) $(CFLAGS) -c $< -o $@

# target: $(BUILDDIR)/main.o
# 	$(CC) $^ -o $@
## THE ABOVE SECTION IS FROM GROK, ANSWERING HOW TO SUPPORT OUT-OF-TREE BUILDS




# Stop editing. No user-serviceable parts below.
.EXPORT_ALL_VARIABLES:

.PHONY: help

help:
	@echo "GNU Make should be allowing GNU Guile to report some help information."

all: code scripts styles

buildexec=$(BUILDDIR)$(LIBEXEC)
build= | $(buildexec)

tools: $(build)
	mkdir $(buildexec)/tools
	$(MAKE) -C tools "OUTPUT=$(buildexec)/tools"

ciilib: $(build)
	mkdir $(buildexec)/cii
	$(MAKE) -C cii "OUTPUT=$(buildexec)/cii"

lualib: $(build)
	mkdir $(buildexec)/lua-2.5.1
	$(MAKE) -C lua-2.5.1 $(LuaMakefile) "OUTPUT=$(buildexec)/lua-2.5.1"

lualib3: $(build)
	mkdir $(buildexec)/lua-3.2.2
	$(MAKE) -C lua-3.2.2 $(LuaMakefile) "OUTPUT=$(buildexec)/lua-3.2.2"

code: tools ciilib lualib
	mkdir $(buildexec)/c
	$(MAKE) -C c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(buildexec)/c"

scripts: tools
	mkdir $(buildexec)/lua
	$(MAKE) -C lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(buildexec)/lua"

styles: tools
	mkdir $(buildexec)/tex
	$(MAKE) -C tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(buildexec)/tex"

careful:
	$(MAKE) clobber
	$(MAKE) all
	$(MAKE) clean
	-$(RMDIR) $(buildexec)/first
	mkdir $(addprefix $(buildexec)/,first first/c first/lua first/tex)
	cp -R $(buildexec)/c/* $(buildexec)/first/c
	cp -R $(buildexec)/lua/* $(buildexec)/first/lua
	cp -R $(buildexec)/tex/* $(buildexec)/first/tex

	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib
	-mkdir $(buildexec)/c
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/first/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(buildexec)/c"

	-mkdir $(LIBEXEC)/lua
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(buildexec)/lua"

	-mkdir $(LIBEXEC)/tex
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(buildexec)/tex"

	@echo "At this point we are attempting to build the literate version."
	@echo "It may fail if you have not previously installed noweb.sty."

	$(MAKE) -C c "NWPATH=$(LIBEXEC)/first/lua" "OUTPUT=$(buildexec)/c" doc
	-$(RMDIR) $(buildexec)/first

	$(MAKE) all clean





define with_m_make_n
$(foreach t,clobber tools ciilib $(if $(findstring "2",${2}),"lualib","lualib3"),$(MAKE) ${t})
$(foreach d,$(addprefix $(buildexec)/,c lua tex ${1}${2} ${1}${2}/c ${1}${2}/lua ${1}${2}/tex), mkdir ${d})
$(MAKE) -C c "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(NOCOND) $(PIPE) | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" $(if $(findstring "2",$2),"LUA=../lua-2.5","LUA=../lua-3.0") $(if $(findstring "2",$2),"LUALIB=$(LIBEXEC)/lua-2.5","LUALIB=$(LIBEXEC)/lua-3.0") "OUTPUT=$(buildexec)/c"
$(MAKE) -C lua "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua${2} | $(LIBEXEC)/${1}b/c/no tangle" "CPIF=>" "OUTPUT=$(buildexec)/lua"
$(MAKE) -C tex "NWPATH=$(LIBEXEC)/${1}b/lua" "NOTANGLE=$(LIBEXEC)/${1}b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(buildexec)/tex"
$(MAKE) -C c doc "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(buildexec)/c"
$(foreach d,c lua tex,cp -R $(wildcard $(buildexec)/${d}/*) $(buildexec)/${1}${2}/${d})
endef

transfer:
# noweb_2_11b->Rammel with Lua 2
	$(MAKE) clobber
	$(MAKE) all
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(buildexec)/c" doc
	$(foreach d,$(addprefix $(buildexec)/,2b 2b/c 2b/lua 2b/tex), mkdir ${d})
	$(foreach d,c lua tex,cp -R $(wildcard $(buildexec)/${d}/*) $(buildexec)/2b/${d})



# noweb_2_11b->Rammel with Lua 3
	$(foreach t,clobber tools ciilib lualib3,$(MAKE) ${t})
	$(foreach d,$(addprefix $(buildexec)/,c lua tex 3b 3b/c 3b/lua 3b/tex), mkdir ${d})
	$(MAKE) -C c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(buildexec)/c"
	$(MAKE) -C lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(buildexec)/lua"
	$(MAKE) -C tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(buildexec)/tex"
	$(MAKE) -C c doc "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(buildexec)/c"
	$(foreach d,c lua tex,cp -R $(wildcard $(buildexec)/${d}/*) $(buildexec)/3b/${d})



	$(call with_m_make_n,2,2)# Rammel with Lua 2->Rammel with Lua 2
	$(call with_m_make_n,2,3)# Rammel with Lua 2->Rammel with Lua 3
	$(call with_m_make_n,3,2)# Rammel with Lua 3->Rammel with Lua 2
	$(call with_m_make_n,3,3)# Rammel with Lua 3->Rammel with Lua 3



# check differences
	$(MAKE) clean
	$(MAKE) checkclean
	@echo "Let's see how different it is..."
	$(MAKE) checkdifferent
	@echo "Let's see how similar it is..."
	$(MAKE) checksame





checkclean:
	$(foreach clean_target,2b 22 23 3b 32 33,$(RM) $(addprefix $(buildexec)/${clean_target}/c/,$(wildcard *.exe *.log *.obj *.pdf)))

checkdifferent_fn=$(DIFF) $(foreach other,3b 32 33,$(buildexec)/$1 $(buildexec)/${other})
checkdifferent:
	$(foreach other,2b 22 23,$(call checkdifferent_fn, ${other}))

checksame:
	$(DIFF) $(buildexec)/2b $(buildexec)/22
	$(DIFF) $(buildexec)/22 $(buildexec)/23
	$(foreach other,3b 32,$(call checkdifferent_fn, ${other}))

pdf: install
	-mkdir $(buildexec)/c
	$(MAKE) -C c "OUTPUT=$(buildexec)/c" doc

install: code scripts styles
	$(INSTALL_PROGRAM) $(buildexec)/c/no $(buildexec)/c/nwmtime $(DESTDIR)$(BINDIR)
	$(INSTALL_PROGRAM) $(buildexec)/lua/* $(DESTDIR)$(BINDIR)
	$(INSTALL_DATA) $(buildexec)/tex/noweb.sty $(DESTDIR)$(TEXINPUTS)/latex/misc/noweb.sty
	$(INSTALL_DATA) $(buildexec)/tex/nwmac.tex $(DESTDIR)$(TEXINPUTS)/generic/misc/nwmac.tex

clean:
	$(MAKE) -C tools "OUTPUT=$(buildexec)/tools" clobber
	-$(RMDIR) $(LIBEXEC)/tools

	$(MAKE) -C cii "OUTPUT=$(buildexec)/cii" clobber
	-$(RMDIR) $(LIBEXEC)/cii

	$(MAKE) -C lua-2.5 $(LuaMakefile) "OUTPUT=$(buildexec)/lua-2.5" clobber
	-$(RMDIR) $(LIBEXEC)/lua-2.5

	$(MAKE) -C c "OUTPUT=$(buildexec)/c" clean
	$(MAKE) -C lua "OUTPUT=$(buildexec)/lua" clean
	$(MAKE) -C tex "OUTPUT=$(buildexec)/tex" clean
	-$(RM) *~



clobber: clean
	$(MAKE) -C c "OUTPUT=$(buildexec)/c" clobber
	-$(RMDIR) $(buildexec)/c

	$(MAKE) -C lua "OUTPUT=$(buildexec)/lua" clobber
	-$(RMDIR) $(buildexec)/lua

	$(MAKE) -C tex "OUTPUT=$(buildexec)/tex" clobber
	-$(RMDIR) $(buildexec)/tex
