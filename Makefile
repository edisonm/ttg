# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

DBCONVERTDPR=dbconvert.dpr
TTGMDB=dat/$(TTGMDBBASE)
TTGSQL=dat/ttg.sql
TTGMYSQL=dat/ttg.mysql
TTGSQLITE3=dat/ttg.s3fpc

all:
	cd src/laz ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode all ; \
	  done
	$(MAKE) $(FILES)

run:
	cd src/laz ; $(MAKE) run

ide:
	cd src/laz ; $(MAKE) ide

$(DBCONVERT):
	cd ../DBConvert ; $(MAKE) all BINDIR=$(TTGDIR)/bin

$(TTGSQLITE3): $(TTGSQL)
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

clean:
	cd src/laz; $(MAKE) clean
	$(RM) $(TTGSQLITE3) obj/* $(ISS) $(ABOUT).pas ../DBConvert/src/*.identcache

dbconvert: $(DBCONVERT)

test:
	@echo BUILDDATETIME="$(BUILDDATETIME)"
