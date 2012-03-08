# -*- mode: Makefile; -*-

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

all: $(INSTALLER)

$(INSTALLER): $(CONTROL) $(TTGDESKTOP) $(TTGEXE)
	mkdir -p $(DEBIAN)/usr/bin
	mkdir -p $(DEBIAN)/usr/share/doc/ttg/examples/
	cp $(TTGEXE) $(DEBIAN)/usr/bin
	cp $(TTGDIR)/examples/Britanico2000.ttd $(DEBIAN)/usr/share/doc/ttg/examples/Britanico2000.ttd
	cp $(TTGDIR)/examples/Salamanca1999.ttd $(DEBIAN)/usr/share/doc/ttg/examples/Salamanca1999.ttd
	cd $(TTGDIR)/bin/$(BuildId) ; dpkg --build debian .

$(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

$(CONTROL): control.tmpl
	mkdir -p $(DEBIAN)/DEBIAN
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>Architecture</v>':'$(ARCHITECTURE)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGDESKTOP): ttg.desktop.tmpl
	mkdir -p $(DEBIAN)/usr/share/applications
	sed -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGTARGET): $(TTGEXE)
	mkdir -p $(DEBIAN)/usr/bin
	cp $< $@

test:
	 @echo INSTALLER=$(INSTALLER)
