# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

RELDIR=.
TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

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

run ex1 ex2 ex3 ex4 ex5 ide clean:
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

install:
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/doc/$(Package)/examples
	mkdir -p $(DESTDIR)/usr/share/locale/es/LC_MESSAGES
	mkdir -p $(DESTDIR)/usr/share/applications
	cp $(TTGEXE) $(DESTDIR)/usr/bin/
	cp $(TTGDIR)/examples/Herradura2013.ttd \
	   $(TTGDIR)/examples/Britanico2000.ttd \
	   $(TTGDIR)/examples/Salamanca1999.ttd \
	   $(DESTDIR)/usr/share/doc/$(Package)/examples/
	cp $(TTGSRC)/locale/ttg.es.po $(DESTDIR)/usr/share/locale/es/LC_MESSAGES/ttg.po
	sed -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_desktop.tmpl > $(DESTDIR)/usr/share/applications/ttg.desktop

winsetup:
	cd iss ; $(MAKE) all

runsetup:
	cd iss ; $(MAKE) run

ci:
	$(MAKE) buildnr
	svn ci -m MSG="$(MSG)"

test:
	@echo TTGDIR=$(TTGDIR)
	@echo APPNAME=$(APPNAME)
	@echo ARCH=$(ARCH)
	@echo OSBITS=$(OSBITS)
	cd $(TTGSRC) ; $(MAKE) test
