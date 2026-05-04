all: $(OUTPUT)/nwmac.tex $(OUTPUT)/noweb.sty

source: nwmac.tex noweb.sty
touch: nwmac.tex noweb.sty
	touch nwmac.tex noweb.sty

$(OUTPUT)/nwmac.tex: support.nw
	$(NOTANGLE) support.nw $(TANGLEOPTS) -Rnwmac.tex $(CPIF) $@

$(OUTPUT)/noweb.sty: support.nw
	$(NOTANGLE) support.nw $(TANGLEOPTS) -Rnoweb.sty $(CPIF) $@

support.tex: support.nw
	noweave -delay -x support.nw > support.tex

clean: 
	-$(RM) *~ *.dvi *.aux *.log *.blg *.bbl *.toc 2>$(NUL)
	-$(RM) support.tex 2>$(NUL)

clobber:
	-$(RM) $(OUTPUT)/nwmac.tex 2>$(NUL)
	-$(RM) $(OUTPUT)/noweb.sty 2>$(NUL)
