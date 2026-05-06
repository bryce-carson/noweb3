CONFIG = pipes.cfg sys.cfg noweb.cfg util.cfg list.nws set.nws
FILTERS = cat.nws stripconds.nws xchunks.nws lines.nws
STAGES = totex.nws tohtml.nws noidx.nws elide.nws unmarkup.nws $(FILTERS)
SCRIPTS = tangle.nws weave.nws

all: $(CONFIG) $(STAGES) $(SCRIPTS)
	for i in $(CONFIG) $(STAGES); do sed 's@|LIBDIR|@$(LIB2)@g' $$i > $(OUTPUT)/$$i; done
	for i in $(SCRIPTS);          do cp                         $$i   $(OUTPUT)/$$i; done

test: $(CONFIG) $(STAGES) $(SCRIPTS)
	@echo 'write("Scripts load from .\n")' | NWPATH=. no
	@echo 'argv = {"-internaldefaults", "-n", "-html", "/dev/null"}; do_nwfile("weave.nws"); write("Null weave OK.\n")' | NWPATH=. no
	@echo 'argv = {"-internal", "test.nw"}; do_nwfile("tangle.nws"); write("Null tangle OK.\n")' | NWPATH=. no

htmltest: $(CONFIG) $(STAGES) $(SCRIPTS)
	@echo 'testfile("/home/nr/www/noweb/index.html")' | NWPATH=. no

clean:

clobber: clean
	-$(RM) $(CONFIG) $(FILTERS) $(STAGES) $(SCRIPTS)

%.c: %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -L"#line %L \"${$*}.nw\"%N" > $@

%.h: %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -Rheader -L"#line %L \"${$*}.nw\"%N" > $@

%.nws %.cfg: lua.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -R$(@F) > $@

noidx.tex: noidx.nw
	noweave -delay -x -filter 'elide hackers:*' noidx.nw > noidx.tex
