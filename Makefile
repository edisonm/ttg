# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

RELDIR=.
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

tgz:
	mkdir -p $(PKGDIR)
# svn export --force $(REPOSITORY) $(TGZSRC) ;
	rsync -a --exclude-from=Exclude --delete-excluded $(TTGDIR)/ $(PKGDIR)/$(TGZSRC)/
	mkdir -p $(PKGDIR)/$(TGZSRC)/images
	cp  $(TTGDIR)/images/ttg-icon.png $(PKGDIR)/$(TGZSRC)/images
	mkdir -p $(PKGDIR)/$(TGZSRC)/src/dbcshared
	sed -e s:'../../multithreadprocs':'/usr/share/multithreadprocs/src':g $(TTGSRC)/ttg.lpi \
	  -e s:'../../zeosdbo/':'/usr/share/zeosdbo/':g > $(PKGDIR)/$(TGZSRC)/src/ttg.lpi
	cd $(PKGDIR) ; tar -c --owner=0 --group=0 --exclude-backups $(TGZSRC)/* | gzip  --best -c > $(TGZBASE).orig.tar.gz

install:
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/doc/$(PACKAGE)/examples
	mkdir -p $(DESTDIR)/usr/share/locale/es/LC_MESSAGES
	mkdir -p $(DESTDIR)/usr/share/applications
	cp $(TTGEXE) $(DESTDIR)/usr/bin/
	cp $(TTGDIR)/examples/Britanico2000.ttd $(TTGDIR)/examples/Salamanca1999.ttd  $(DESTDIR)/usr/share/doc/$(PACKAGE)/examples/
	msgfmt $(TTGSRC)/locale/ttg.es.po $(DESTDIR)/usr/share/locale/es/LC_MESSAGES/ttg.mo
	sed -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_desktop.tmpl > $(DESTDIR)/usr/share/applications/ttg.desktop

debiansrc: tgz
	cd $(PKGDIR)/$(TGZSRC) ; debuild -S

debianbin: debiansrc
	cd $(PKGDIR)/$(TGZSRC) ; debuild

winsetup:
	cd iss ; $(MAKE) all

ci:
	$(MAKE) buildnr
	svn ci -m MSG="$(MSG)"

test:
	@echo TTGDIR=$(TTGDIR)
	@echo APPNAME=$(APPNAME)
