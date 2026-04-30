$(guile (load "tangle.scm"))

CONFIG="$(guile (path-expand '(pipes.cfg sys.cfg noweb.cfg util.cfg list.nws set.nws) output))"
FILTERS="$(guile (path-expand '(cat.nws stripconds.nws xchunks.nws lines.nws) output))"
STAGES="$(guile (path-expand '(totex.nws tohtml.nws noidx.nws elide.nws unmarkup.nws) output)) $(FILTERS)"
SCRIPTS="$(guile (path-expand '(tangle weave) output))"

all: $(CONFIG) $(STAGES) $(SCRIPTS)

test: $(CONFIG) $(STAGES) $(SCRIPTS)
	@echo 'write("Scripts load from .\n")' | NWPATH=. no
	@echo 'argv = {"-internaldefaults", "-n", "-html", "/dev/null"}; do_nwfile("weave.nws"); write("Null weave OK.\n")' | NWPATH=. no
	@echo 'argv = {"-internal", "test.nw"}; do_nwfile("tangle.nws"); write("Null tangle OK.\n")' | NWPATH=. no

htmltest: $(CONFIG) $(STAGES) $(SCRIPTS)
	@echo 'testfile("/home/nr/www/noweb/index.html")' | NWPATH=. no

clean:

clobber: clean
	-$(RM) $(CONFIG) $(FILTERS) $(STAGES) $(SCRIPTS) 2>$(NULL)

install: $(SCRIPTS) $(CONFIG) $(STAGES)
	for i in $(CONFIG) $(STAGES); do sed 's@|LIBDIR|@$(LIB2)@g' $$i > $(LIBEXEC)/$$i;                 done
	for i in $(SCRIPTS);          do cp                         $$i   $(LIBEXEC)/`basename $$i .nws`; done

# Produce rules
"$(guile (map (lambda (w) (path-expand (cpif (notangle tangle-options w) w) output)) '(list.nw set.nw totex.nw tohtml.nw noidx.nw elide.nw unmarkup.nw cat.nw stripconds.nw xchunks.nw lines.nw tangle.nw weave.nw)))"


TANGLE=notangle
$(OUTPUT)/%.c: %.nw
	$(TANGLE) $(TANGLEOPTS) -L"#line %L \"${$*}.nw\"%N" > $@
$(OUTPUT)/%.h: %.nw
	$(TANGLE) $(TANGLEOPTS) -Rheader -L"#line %L \"${$*}.nw\"%N" > $@
$(OUTPUT)/pipes.cfg:
	$(TANGLE) $(TANGLEOPTS) -Rpipes.cfg config.nw > $@
$(OUTPUT)/sys.cfg:
	$(TANGLE) $(TANGLEOPTS) -Rsys.cfg config.nw > $@
$(OUTPUT)/pipes.cfg:
	$(TANGLE) $(TANGLEOPTS) -Rnoweb.cfg config.nw > $@
$(OUTPUT)/pipes.cfg:
	$(TANGLE) $(TANGLEOPTS) -Rutil.cfg config.nw > $@

noidx.tex: noidx.nw
	noweave -delay -x -filter 'elide hackers:*' noidx.nw > noidx.tex
