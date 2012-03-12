# -*- mode: Makefile; -*-

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

all: $(FILES)

.PHONY:ttg

$(PKGTTG): ttg ttg_control.tmpl ttg_desktop.tmpl
	mkdir -p $(DEBIAN)/ttg.dir/DEBIAN
	mkdir -p $(DEBIAN)/ttg.dir/usr/bin
	mkdir -p $(DEBIAN)/ttg.dir/usr/share/applications
	mkdir -p $(PKGDIR)
	sed -e s:'<v>Version</v>':'$(VERSION)':g \
	  -e s:'<v>BuildLabel</v>':'$(BuildLabel)':g \
	  -e s:'<v>Architecture</v>':'$(ARCH)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_control.tmpl > $(DEBIAN)/ttg.dir/DEBIAN/control
	sed -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_desktop.tmpl > $(DEBIAN)/ttg.dir/usr/share/applications/ttg.desktop
	cp $(TTGEXE) $(DEBIAN)/ttg.dir/usr/bin/ttg$(BuildLabel)
	cd $(OBJDIR)/debian ; dpkg --build ttg.dir $(PKGDIR)

ifeq ($(BuildMode),release)
$(PKGTTG_DOC): ttg-doc_control.tmpl \
		$(TTGDIR)/examples/Britanico2000.ttd \
		$(TTGDIR)/examples/Salamanca1999.ttd
	mkdir -p $(DEBIAN)/ttg-doc.dir/DEBIAN
	mkdir -p $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/
	mkdir -p $(PKGDIR)
	sed -e s:'<v>Version</v>':'$(VERSION)':g \
	  -e s:'<v>BuildLabel</v>':'$(BuildLabel)':g \
	  -e s:'<v>Architecture</v>':'$(ARCH)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g ttg-doc_control.tmpl > $(DEBIAN)/ttg-doc.dir/DEBIAN/control
	cp $(TTGDIR)/examples/Britanico2000.ttd $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/Britanico2000.ttd
	cp $(TTGDIR)/examples/Salamanca1999.ttd $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/Salamanca1999.ttd
	cd $(OBJDIR)/debian ; dpkg --build ttg-doc.dir $(PKGDIR)
endif

ttg $(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

$(CATALOG): $(PACKAGES)
	cd $(PKGDIR) ; dpkg-scanpackages . | gzip > Packages.gz

clean:
	$(RM) -r $(DEBIAN) $(PKGDIR)/*.deb $(PKGDIR)/Packages.gz

test:
	@echo PKGTTG=$(PKGTTG)
	@echo PKGTTG_DOC=$(PKGTTG_DOC)
	@echo DEBIAN=$(DEBIAN)
	cd $(TTGSRC) ; $(MAKE) test
