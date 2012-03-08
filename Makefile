# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

TTGMDB=dat/$(TTGMDBBASE)
TTGSQLITE3=dat/ttg.s3fpc


all test:
	cd $(CHAINSRC) ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode $@ ; \
	  done

run ex1 ex2 ex3 ex4 ide clean:
	cd $(TTGSRC) ; $(MAKE) $@

debug:
	cd $(TTGSRC) ; $(MAKE) BuildMode=debug ex3

all: $(FILES)

$(TTGSQLITE3): $(TTGSQL)
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

ifeq ($(shell uname -o),Cygwin)
$(TTGSQL):
	cd $(TTGSRC) ; $(MAKE) ttgsql
endif

cleanthis:
	$(RM) $(TTGSQLITE3)

clean: cleanthis
