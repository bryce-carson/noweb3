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
export VPATH

# $(BUILDDIR)/%.o: %.c
# 	@mkdir -p $(BUILDDIR)
# 	$(CC) $(CFLAGS) -c $< -o $@

# target: $(BUILDDIR)/main.o
# 	$(CC) $^ -o $@
## THE ABOVE SECTION IS FROM GROK, ANSWERING HOW TO SUPPORT OUT-OF-TREE BUILDS








# Stop editing. No user-serviceable parts below.
all: code scripts styles

.PHONY: help

help:
	@echo "GNU Make should be allowing GNU Guile to report some help information."

tools: | $(BUILDDIR)$(LIBEXEC)/tools
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/tools
	$(MAKE) -C tools "OUTPUT=$(BUILDDIR)$(LIBEXEC)/tools"

ciilib:
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/cii
	$(MAKE) -C cii "OUTPUT=$(LIBEXEC)/cii"

lualib:
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/lua-2.5.1
	$(MAKE) -C lua-2.5.1 $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-2.5.1"

lualib3:
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/lua-3.2.2
	$(MAKE) -C lua-3.2.2 $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-3.2.2"

code: tools ciilib lualib
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/c
	$(MAKE) -C c "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c"

scripts: tools
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/lua
	$(MAKE) -C lua "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua"

styles: tools
	mkdir $(LIBEXEC)
	mkdir $(LIBEXEC)/tex
	$(MAKE) -C tex "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex"

careful:
	$(MAKE) clobber
	$(MAKE) all clean
	-$(RMDIR) $(LIBEXEC)/first
	mkdir $(LIBEXEC)/first
	mkdir $(LIBEXEC)/first/c
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/first/c
	mkdir $(LIBEXEC)/first/lua
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/first/lua
	mkdir $(LIBEXEC)/first/tex
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/first/tex
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib
	-mkdir $(LIBEXEC)/c
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/first/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c" && cd ..
	-mkdir $(LIBEXEC)/lua
	$(MAKE) -C lua && "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	-mkdir $(LIBEXEC)/tex
	$(MAKE) -C tex && "NWPATH=$(LIBEXEC)/first/lua" "NOTANGLE=$(LIBEXEC)/first/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	echo At this point we are attempting to build the literate version.
	echo It may fail if you have not previously installed noweb.sty.
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/first/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	-$(RMDIR) $(LIBEXEC)/first
	$(MAKE) all clean

transfer:
#	make 2 from tools
	$(MAKE) clobber
	$(MAKE) all
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	mkdir $(LIBEXEC)/2b
	mkdir $(LIBEXEC)/2b/c
	mkdir $(LIBEXEC)/2b/lua
	mkdir $(LIBEXEC)/2b/tex
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/2b/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/2b/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/2b/tex
	$(MAKE) clean
#	make 3 from tools
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib3
	mkdir $(LIBEXEC)/c
	mkdir $(LIBEXEC)/lua
	mkdir $(LIBEXEC)/tex
	$(MAKE) -C c && "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c" && cd ..
	$(MAKE) -C lua && "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	$(MAKE) -C tex && "NOTANGLE=more" "TANGLEOPTS= | $(LIBEXEC)/tools/markup | $(LIBEXEC)/tools/nt" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	mkdir $(LIBEXEC)/3b
	mkdir $(LIBEXEC)/3b/c
	mkdir $(LIBEXEC)/3b/lua
	mkdir $(LIBEXEC)/3b/tex
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/3b/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/3b/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/3b/tex
	$(MAKE) clean
#	make 2 from 2
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib
	mkdir $(LIBEXEC)/c
	mkdir $(LIBEXEC)/lua
	mkdir $(LIBEXEC)/tex
	mkdir $(LIBEXEC)/22
	mkdir $(LIBEXEC)/22/c
	mkdir $(LIBEXEC)/22/lua
	mkdir $(LIBEXEC)/22/tex
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c" && cd ..
	$(MAKE) -C lua && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	$(MAKE) -C tex && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=$(LIBEXEC)/2b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/22/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/22/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/22/tex
	$(MAKE) clean
#	make 3 from 2
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib3
	mkdir $(LIBEXEC)/c
	mkdir $(LIBEXEC)/lua
	mkdir $(LIBEXEC)/tex
	mkdir $(LIBEXEC)/32
	mkdir $(LIBEXEC)/32/c
	mkdir $(LIBEXEC)/32/lua
	mkdir $(LIBEXEC)/32/tex
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c" && cd ..
	$(MAKE) -C lua && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/2b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	$(MAKE) -C tex && "NWPATH=$(LIBEXEC)/2b/lua" "NOTANGLE=$(LIBEXEC)/2b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/32/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/32/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/32/tex
	$(MAKE) clean
#	make 2 from 3
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib
	mkdir $(LIBEXEC)/c
	mkdir $(LIBEXEC)/lua
	mkdir $(LIBEXEC)/tex
	mkdir $(LIBEXEC)/23
	mkdir $(LIBEXEC)/23/c
	mkdir $(LIBEXEC)/23/lua
	mkdir $(LIBEXEC)/23/tex
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(NOCOND) $(PIPE) | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-2.5" "LUALIB=$(LIBEXEC)/lua-2.5" "OUTPUT=$(LIBEXEC)/c" && cd ..
	$(MAKE) -C lua && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua2 | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	$(MAKE) -C tex && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=$(LIBEXEC)/3b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/23/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/23/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/23/tex
	$(MAKE) clean
#	make 3 from 3
	$(MAKE) clobber
	$(MAKE) tools
	$(MAKE) ciilib
	$(MAKE) lualib3
	mkdir $(LIBEXEC)/c
	mkdir $(LIBEXEC)/lua
	mkdir $(LIBEXEC)/tex
	mkdir $(LIBEXEC)/33
	mkdir $(LIBEXEC)/33/c
	mkdir $(LIBEXEC)/33/lua
	mkdir $(LIBEXEC)/33/tex
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(NOCOND) $(PIPE) | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "TOOLS=$(LIBEXEC)/tools" "LUA=../lua-3.0" "LUALIB=$(LIBEXEC)/lua-3.0" "OUTPUT=$(LIBEXEC)/c" && cd ..
	$(MAKE) -C lua && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=more" "TANGLEOPTS= | $(NOCOND) lua3 | $(LIBEXEC)/3b/c/no tangle" "CPIF=>" "OUTPUT=$(LIBEXEC)/lua" && cd ..
	$(MAKE) -C tex && "NWPATH=$(LIBEXEC)/3b/lua" "NOTANGLE=$(LIBEXEC)/3b/c/no tangle" "TANGLEOPTS=" "CPIF=>" "OUTPUT=$(LIBEXEC)/tex" && cd ..
	$(MAKE) -C c && "NWPATH=$(LIBEXEC)/lua" "OUTPUT=$(LIBEXEC)/c" doc && cd ..
	cp -R $(LIBEXEC)/c/* $(LIBEXEC)/33/c
	cp -R $(LIBEXEC)/lua/* $(LIBEXEC)/33/lua
	cp -R $(LIBEXEC)/tex/* $(LIBEXEC)/33/tex
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
	$(RM) $(LIBEXEC)/2b\c\*.exe $(LIBEXEC)/2b\c\*.log $(LIBEXEC)/2b\c\*.obj $(LIBEXEC)/2b\c\*.pdf
	$(RM) $(LIBEXEC)/22\c\*.exe $(LIBEXEC)/22\c\*.log $(LIBEXEC)/22\c\*.obj $(LIBEXEC)/22\c\*.pdf
	$(RM) $(LIBEXEC)/23\c\*.exe $(LIBEXEC)/23\c\*.log $(LIBEXEC)/23\c\*.obj $(LIBEXEC)/23\c\*.pdf
	$(RM) $(LIBEXEC)/3b\c\*.exe $(LIBEXEC)/3b\c\*.log $(LIBEXEC)/3b\c\*.obj $(LIBEXEC)/3b\c\*.pdf
	$(RM) $(LIBEXEC)/32\c\*.exe $(LIBEXEC)/32\c\*.log $(LIBEXEC)/32\c\*.obj $(LIBEXEC)/32\c\*.pdf
	$(RM) $(LIBEXEC)/33\c\*.exe $(LIBEXEC)/33\c\*.log $(LIBEXEC)/33\c\*.obj $(LIBEXEC)/33\c\*.pdf

checkdifferent:
	windiff $(LIBEXEC)/2b $(LIBEXEC)/3b
	windiff $(LIBEXEC)/2b $(LIBEXEC)/32
	windiff $(LIBEXEC)/2b $(LIBEXEC)/33
	windiff $(LIBEXEC)/22 $(LIBEXEC)/3b
	windiff $(LIBEXEC)/22 $(LIBEXEC)/32
	windiff $(LIBEXEC)/22 $(LIBEXEC)/33
	windiff $(LIBEXEC)/23 $(LIBEXEC)/3b
	windiff $(LIBEXEC)/23 $(LIBEXEC)/32
	windiff $(LIBEXEC)/23 $(LIBEXEC)/33

checksame:
	windiff $(LIBEXEC)/2b $(LIBEXEC)/22
	windiff $(LIBEXEC)/22 $(LIBEXEC)/23
	windiff $(LIBEXEC)/3b $(LIBEXEC)/32
	windiff $(LIBEXEC)/32 $(LIBEXEC)/33

pdf: install
	-mkdir $(LIBEXEC)/c
	$(MAKE) -C c && "OUTPUT=$(LIBEXEC)/c" doc && cd ..

install: install-code install-scripts install-styles

install-code: code
	$(INSTALL_PROGRAM) $(LIBEXEC)/c/no$(E) $(LIBEXEC)/c/nwmtime$(E) $(DESTDIR)$(BINDIR)

install-scripts: scripts
	$(INSTALL_PROGRAM) $(LIBEXEC)/lua/* $(DESTDIR)$(BINDIR)

install-styles: styles
	$(CP) $(LIBEXEC)/tex/noweb.sty $(TEXINPUTS)/latex/misc/noweb.sty
	$(CP) $(LIBEXEC)/tex/nwmac.tex $(TEXINPUTS)/generic/misc/nwmac.tex

clean:
	$(MAKE) -C tools && "OUTPUT=$(LIBEXEC)/tools" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/tools
	$(MAKE) -C cii && "OUTPUT=$(LIBEXEC)/cii" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/cii
	$(MAKE) -C lua-2.5 && $(LuaMakefile) "OUTPUT=$(LIBEXEC)/lua-2.5" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/lua-2.5
	$(MAKE) -C c && "OUTPUT=$(LIBEXEC)/c" clean && cd ..
	$(MAKE) -C lua && "OUTPUT=$(LIBEXEC)/lua" clean && cd ..
	$(MAKE) -C tex && "OUTPUT=$(LIBEXEC)/tex" clean && cd ..
	-$(RM) *~

clobber: clean
	$(MAKE) -C c && "OUTPUT=$(LIBEXEC)/c" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/c
	$(MAKE) -C lua && "OUTPUT=$(LIBEXEC)/lua" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/lua
	$(MAKE) -C tex && "OUTPUT=$(LIBEXEC)/tex" clobber && cd ..
	-$(RMDIR) $(LIBEXEC)/tex
	-$(RM) *.html
