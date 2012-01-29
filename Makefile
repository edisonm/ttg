# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

TTGMDB=dat/$(TTGMDBBASE)
TTGSQLITE3=dat/ttg.s3fpc

all: $(FILES)
	cd $(CHAINSRC) ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode all ; \
	  done

run:
	cd $(TTGSRC) ; $(MAKE) run

ide:
	cd $(TTGSRC) ; $(MAKE) ide

$(TTGSQLITE3): $(TTGSQL)
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

ifeq ($(shell uname -o),Cygwin)
$(TTGSQL):
	cd $(TTGSRC) ; $(MAKE) ttgsql
endif

cleanthis:
	$(RM) $(TTGSQLITE3) obj/*

clean: cleanthis
	cd $(CHAINSRC); $(MAKE) clean

test:
	cd $(CHAINSRC) ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode test ; \
	  done
