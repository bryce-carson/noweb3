# makefile for lua hierarchy

all clean klean:
	$(MAKE) -C include $@
	$(MAKE) -C src $@
	$(MAKE) -C src/luac $@
	$(MAKE) -C src/lib $@
	$(MAKE) -C src/lua $@

strip:
	strip bin/lua*
