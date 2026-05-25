override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)

# NOTANGLE = $(TOOLS)/nt

CONFIG = pipes.cfg sys.cfg noweb.cfg util.cfg list.nws set.nws
FILTERS = cat.nws stripconds.nws xchunks.nws lines.nws
STAGES = totex.nws tohtml.nws noidx.nws elide.nws unmarkup.nws $(FILTERS)
SCRIPTS = tangle weave

.PHONY : all clean clobber install

all : $(CONFIG) $(STAGES) $(SCRIPTS)

clean :

clobber : clean
	-rm -f $(CONFIG) $(FILTERS) $(STAGES) $(SCRIPTS)

## LIB2 is the directory where external stanges from Noweb 2 are located; LIB3
## is where stages of Noweb 3 are located. LIB2 and LIB3 do not relate to Lua 2
## or Lua 3.
install : $(SCRIPTS) $(CONFIG) $(STAGES)
	for i in $(CONFIG) $(STAGES); do                    \
      sed 's@|LIBDIR|@$(LIB2)@g' $$i > $$i; \
  done
	for i in $(SCRIPTS); do                       \
      cp $$i $(OUTPUT)/`basename $$i .nws`;     \
  done

%.cfg : config.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -R$(@F) $(CPIF) $@

%.nws : %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(CPIF) $@

tangle : tangle.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(CPIF) $@

weave : weave.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(CPIF) $@

noidx.tex: noidx.nw
	which no
	no weave -delay -x -filter 'elide hackers:*' noidx.nw > $@

# # TODO: requires tangling to the current directory; which I'm not doing right now.
# test: $(CONFIG) $(STAGES) $(SCRIPTS)
# 	@echo 'write("Scripts load from .\n")' | NWPATH=. no
# 	@echo 'argv = {"-internaldefaults", "-n", "-html", "/dev/null"}; do_nwfile("weave.nws"); write("Null weave OK.\n")' | NWPATH=. no
# 	@echo 'argv = {"-internal", "test.nw"}; do_nwfile("tangle.nws"); write("Null tangle OK.\n")' | NWPATH=. no
# 
# # TODO: requires an HTML file of unknown structure.
# htmltest: $(CONFIG) $(STAGES) $(SCRIPTS)
# 	@echo 'testfile("/home/nr/www/noweb/index.html")' | NWPATH=. no
