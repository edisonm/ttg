# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

TTGMDB=dat/$(TTGMDBBASE)
TTGSQLITE3=dat/ttg.s3fpc

all:
	cd $(TTGSRC) ; $(MAKE) all
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

buildnr:
	cd $(TTGSRC) ; $(MAKE) buildnr

cleanthis:
	$(RM) -rf $(TTGSQLITE3) packages

clean: cleanthis

test:
	@echo TTGDIR=$(TTGDIR)
tgz:
	mkdir -p $(PKGDIR)
# svn export --force $(REPOSITORY) $(TGZSRC) ;
	rsync -av --exclude-from=Exclude --delete-excluded $(TTGDIR)/ $(PKGDIR)/$(TGZSRC)/
	cd $(PKGDIR) ; \
	  tar -c --owner=0 --group=0 --exclude-backups $(TGZSRC)/* | gzip  --best -c > $(TGZBASE).orig.tar.gz

install:
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/doc/$(PACKAGE)/examples
	mkdir -p $(DESTDIR)/usr/share/locale/es/LC_MESSAGES
	cp $(TTGEXE) $(DESTDIR)/usr/bin/
	cp $(TTGDIR)/examples/Britanico2000.ttd $(TTGDIR)/examples/Salamanca1999.ttd  $(DESTDIR)/usr/share/doc/$(PACKAGE)/examples/
	cp $(TTGSRC)/locale/ttg.es.po $(DESTDIR)/usr/share/locale/es/LC_MESSAGES/
