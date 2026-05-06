CONFIG = $(addprefix $(OUTPUT)/,pipes.cfg sys.cfg noweb.cfg util.cfg list.nws set.nws)
FILTERS = $(addprefix $(OUTPUT)/,cat.nws stripconds.nws xchunks.nws lines.nws)
STAGES = $(addprefix $(OUTPUT)/,totex.nws tohtml.nws noidx.nws elide.nws unmarkup.nws) $(FILTERS)
SCRIPTS = $(addprefix $(OUTPUT)/,tangle weave)

.PHONY : all clean clobber install

all : $(CONFIG) $(STAGES) $(SCRIPTS)

clean :

clobber : clean
	-$(RM) $(CONFIG) $(FILTERS) $(STAGES) $(SCRIPTS)

install : $(SCRIPTS) $(CONFIG) $(STAGES)
	for i in $(CONFIG) $(STAGES); do                  \
      sed 's@|LIBDIR|@$(LIB2)@g' $$i > $(OUTPUT)/$$i; \
  done
	for i in $(SCRIPTS); do                       \
      cp $$i $(OUTPUT)/`basename $$i .nws`;       \
  done

$(OUTPUT)/%.cfg : config.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -R$(@F) $(CPIF) $@

$(OUTPUT)/%.nws : %.nw
	$(NOTANGLE) $< $(TANGLEOPTS) $(CPIF) $@

$(OUTPUT)/tangle : tangle.nw
	$(NOTANGLE) tangle.nw $(TANGLEOPTS) $(CPIF) $@

$(OUTPUT)/weave : weave.nw
	$(NOTANGLE) weave.nw $(TANGLEOPTS) $(CPIF) $@

$(OUTPUT)/noidx.tex: noidx.nw
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
