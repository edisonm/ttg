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

DBUNITS=Ac2DMUtl Ac2PxUtl Acc2DM Acc2Pdx Acc2SQL AccUtl DBPack PdxUtils

all: $(FILES)
	cd src/laz ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode all ; \
	  done

run:
	cd src/laz ; $(MAKE) run

$(DBCONVERT): ../DBConvert/src/$(DBCONVERTDPR) $(addprefix ../DBConvert/src/, $(addsuffix .pas, $(DBUNITS)))
	cd ../DBConvert/src; $(DCC32) $(DCC32OPTS) $(DBCONVERTDPR)

ifeq ($(shell uname -o),Cygwin)
$(TTGSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $@ sqlite

$(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $@ mysql

cleanwin:
	$(RM) $(TTGSQL) $(TTGMYSQL) $(DBCONVERT) $(INSTALLER)
#	$(RM) -r ../DBConvert/src/__history

else

cleanwin:

endif

$(TTGSQLITE3): $(TTGSQL) Makefile
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

clean: cleanwin
	cd src/laz; $(MAKE) clean
	$(RM) $(TTGSQLITE3) obj/* $(ISS) $(ABOUT).pas ../DBConvert/src/*.identcache

dbconvert: $(DBCONVERT)

test:
	@echo BUILDDATETIME="$(BUILDDATETIME)"
