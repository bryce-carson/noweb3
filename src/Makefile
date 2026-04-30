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

tools:
	mkdir $(LIBEXEC) $(LIBEXEC)/tools
	$(MAKE) -C tools "OUTPUT=$(BUILDDIR)$(LIBEXEC)/tools"

ciilib:
	mkdir $(LIBEXEC) $(LIBEXEC)/cii
	$(MAKE) -C cii "OUTPUT=$(LIBEXEC)/cii"

lualib:
	mkdir $(LIBEXEC) $(LIBEXEC)/lua-2.5.1
	$(MAKE) -C lua-2.5.1 $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-2.5.1"

lualib3:
	mkdir $(LIBEXEC) $(LIBEXEC)/lua-3.2.2
	$(MAKE) -C lua-3.2.2 $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-3.2.2"

code: tools ciilib lualib
	mkdir $(LIBEXEC) $(LIBEXEC)/c
	$(MAKE) -C c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c"

scripts: tools
	mkdir $(LIBEXEC) $(LIBEXEC)/lua
	$(MAKE) -C lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"

styles: tools
	mkdir $(LIBEXEC) $(LIBEXEC)/tex
	$(MAKE) -C tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"

careful:
	$(MAKE) clobber
	$(MAKE) all
	$(MAKE) clean
	-$(RMDIR) $(LIBEXEC)/first
	mkdir $(addprefix $(LIBEXEC)/,first first/c first/lua first/tex)
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/first/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/first/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/first/tex

	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib
	-mkdir $(LIBEXEC)/c
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/first/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c"

	-mkdir $(LIBEXEC)/lua
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"

	-mkdir $(LIBEXEC)/tex
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"

	echo At this point we are attempting to build the literate version.
	echo It may fail if you have not previously installed noweb.sty.

	$(MAKE) -C c "NWPATH=$(LIBEXEC)/first/lua" "OUTPUT=$(LIBEXEC)/c" doc
	-$(RMDIR) $(LIBEXEC)/first

	$(MAKE) all clean





transfer:
#	make 2 from tools
	$(MAKE) clobber
	$(MAKE) all
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,$(addprefix $(LIBEXEC)/,2b 2b/c 2b/lua 2b/tex), mkdir ${d})
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/2b/${d})


#	make 3 from tools
	$(foreach t,clobber tools ciilib lualib3,$(MAKE) ${t})
	$(foreach d,$(addprefix $(LIBEXEC)/,c lua tex 3b 3b/c 3b/lua 3b/tex), mkdir ${d})
	$(MAKE) -C c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c"
	$(MAKE) -C lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"
	$(MAKE) -C tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/3b/${d})


#	make 2 from 2
	$(foreach t,clobber tools ciilib lualib,$(MAKE) ${t})
	$(foreach d,$(addprefix $(LIBEXEC)/,c lua tex 22 22/c 22/lua 22/tex), mkdir ${d})
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c"
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=$(LIBEXEC)/2b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/22/${d})


#	make 3 from 2
	$(foreach t,clobber tools ciilib lualib3,$(MAKE) ${t})
	$(foreach d,$(addprefix $(LIBEXEC)/,c lua tex 32 32/c 32/lua 32/tex), mkdir ${d})
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c"
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=$(LIBEXEC)/2b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/32/${d})


#	make 2 from 3
	$(foreach t,clobber tools ciilib lualib,$(MAKE) ${t})
	$(foreach d,$(addprefix $(LIBEXEC)/,c lua tex 23 23/c 23/lua 23/tex), mkdir ${d})
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c"
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=$(LIBEXEC)/3b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/23/${d})


#	make 3 from 3
	$(foreach t,clobber tools ciilib lualib3,$(MAKE) ${t})
	$(foreach d,$(addprefix $(LIBEXEC)/,c lua tex 33 33/c 33/lua 33/tex), mkdir ${d})
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c"
	$(MAKE) -C lua "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"
	$(MAKE) -C tex "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=$(LIBEXEC)/3b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"
	$(MAKE) -C c "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc
	$(foreach d,c lua tex,cp -R $(wildcard $(LIBEXEC)/${d}/*) $(LIBEXEC)/33/${d})


# check differences
	$(MAKE) clean
	$(MAKE) checkclean
	@echo "Let's see how different it is..."
	sleep 1
	$(MAKE) checkdifferent
	@echo "Let's see how similar it is..."
	sleep 1
	$(MAKE) checksame
	sleep 1





checkclean:
	$(foreach clean_target,2b 22 23 3b 32 33,$(RM) $(addprefix $(LIBEXEC)/${clean_target}/c/,$(wildcard *.exe *.log *.obj *.pdf)))

checkdifferent_fn=$(DIFF) $(foreach other,3b 32 33,$(LIBEXEC)/$1 $(LIBEXEC)/${other})
checkdifferent:
	$(foreach other,2b 22 23,$(call checkdifferent_fn, ${other}))

checksame:
	$(DIFF) $(LIBEXEC)/2b $(LIBEXEC)/22
	$(DIFF) $(LIBEXEC)/22 $(LIBEXEC)/23
	$(foreach other,3b 32,$(call checkdifferent_fn, ${other}))

pdf: install
	-mkdir $(LIBEXEC)/c
	$(MAKE) -C c "OUTPUT=$(LIBEXEC)/c" doc

install: install-code install-scripts install-styles

install-code: code
	$(INSTALL_PROGRAM) $(LIBEXEC)/c/no$(E) $(LIBEXEC)/c/nwmtime$(E) $(DESTDIR)$(BINDIR)

install-scripts: scripts
	$(INSTALL_PROGRAM) $(LIBEXEC)/lua/* $(DESTDIR)$(BINDIR)

install-styles: styles
	$(CP) $(LIBEXEC)/tex/noweb.sty $(TEXINPUTS)/latex/misc/noweb.sty
	$(CP) $(LIBEXEC)/tex/nwmac.tex $(TEXINPUTS)/generic/misc/nwmac.tex



clean:
	$(MAKE) -C tools "OUTPUT=$(LIBEXEC)/tools" clobber
	-$(RMDIR) $(LIBEXEC)/tools

	$(MAKE) -C cii "OUTPUT=$(LIBEXEC)/cii" clobber
	-$(RMDIR) $(LIBEXEC)/cii

	$(MAKE) -C lua-2.5 $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-2.5" clobber
	-$(RMDIR) $(LIBEXEC)/lua-2.5

	$(MAKE) -C c "OUTPUT=$(LIBEXEC)/c" clean
	$(MAKE) -C lua "OUTPUT=$(LIBEXEC)/lua" clean
	$(MAKE) -C tex "OUTPUT=$(LIBEXEC)/tex" clean
	-$(RM) *~



clobber: clean
	$(MAKE) -C c "OUTPUT=$(LIBEXEC)/c" clobber
	-$(RMDIR) $(LIBEXEC)/c

	$(MAKE) -C lua "OUTPUT=$(LIBEXEC)/lua" clobber
	-$(RMDIR) $(LIBEXEC)/lua

	$(MAKE) -C tex "OUTPUT=$(LIBEXEC)/tex" clobber
	-$(RMDIR) $(LIBEXEC)/tex
