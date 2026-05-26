override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)

all: nwmac.tex noweb.sty

# source: nwmac.tex noweb.sty
# touch: nwmac.tex noweb.sty
# 	touch nwmac.tex noweb.sty

noweb.sty nwmac.tex: $(srcdir)/support.nw
	$(NOTANGLE) $< $(TANGLEOPTS) -R$@ $(CPIF) $@

support.tex: $(srcdir)/support.nw
	$(NOWEAVE) -delay -x $< $(CPIF) $@

clean:
	-rm -f *~ *.dvi *.aux *.log *.blg *.bbl *.toc
	-rm -f support.tex

clobber: clean
	-rm -f nwmac.tex noweb.sty
