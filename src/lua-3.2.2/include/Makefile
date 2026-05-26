override srcdir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
override VPATH := $(srcdir)
# makefile for lua distribution (includes)

LUA= ..

include $(srcdir)/../config

SRCS= lua.h lualib.h luadebug.h lauxlib.h

all:

clean:

co:
	co -q -f -M $(SRCS)

klean:	clean
	rm -f $(SRCS)
