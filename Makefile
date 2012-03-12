# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

TTGMDB=dat/$(TTGMDBBASE)
TTGSQLITE3=dat/ttg.s3fpc

all:
	cd $(PKGSRC) ; $(MAKE) all
ifneq ($(FILES),)
	$(MAKE) $(FILES)
endif

allmodes:
	cd $(PKGSRC) ; for BuildMode in $(BUILDMODES); do \
	  $(MAKE) BuildMode=$$BuildMode all ; \
	  done
ifneq ($(FILES),)
	$(MAKE) $(FILES)
endif

$(BUILDMODES):
	cd $(PKGSRC) ; $(MAKE) BuildMode=$@ ;

run ex1 ex2 ex3 ex4 ide clean:
	cd $(TTGSRC) ; $(MAKE) $@

$(TTGSQLITE3): $(TTGSQL)
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

ifeq ($(shell uname -o),Cygwin)
$(TTGSQL):
	cd $(TTGSRC) ; $(MAKE) ttgsql
endif

cleanthis:
	$(RM) -rf $(TTGSQLITE3) packages

clean: cleanthis

tbz:
	mkdir -p $(PKGDIR)
	cd $(PKGDIR) ; svn export --force $(REPOSITORY) $(TGZBASE) ; \
	  tar -cf --owner=0 --group=0 $(TGZBASE)/* --exclude-from=../Exclude --exclude-backups | bzip2 --best -c > $(TGZBASE).tar.bz2

tgz:
	mkdir -p $(PKGDIR)
	cd $(PKGDIR) ; svn export --force $(REPOSITORY) $(TGZBASE) ; \
	  tar -cf --owner=0 --group=0 $(TGZBASE)/* --exclude-from=../Exclude --exclude-backups | gzip  --best -c > $(TGZBASE).tar.gz
