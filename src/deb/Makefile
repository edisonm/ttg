# -*- mode: Makefile; -*-

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

all: $(FILES)

catalog: $(TTGDIR)/packages/Packages.gz

$(PKGTTG): $(TTGEXE) ttg_control.tmpl ttg_desktop.tmpl
	mkdir -p $(DEBIAN)/ttg.dir/DEBIAN
	mkdir -p $(DEBIAN)/ttg.dir/usr/bin
	mkdir -p $(DEBIAN)/ttg.dir/usr/share/applications
	mkdir -p $(TTGDIR)/packages
	sed -e s:'<v>AppVersion</v>':'$(VERSION)':g \
	  -e s:'<v>BuildLabel</v>':'$(BuildLabel)':g \
	  -e s:'<v>Architecture</v>':'$(ARCH)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_control.tmpl > $(DEBIAN)/ttg.dir/DEBIAN/control
	sed -e s:'<v>AppName</v>':'$(APPNAME)':g ttg_desktop.tmpl > $(DEBIAN)/ttg.dir/usr/share/applications/ttg.desktop
	cp $(TTGEXE) $(DEBIAN)/ttg.dir/usr/bin/ttg$(BuildLabel)
	cd $(OBJDIR)/debian ; dpkg --build ttg.dir $(TTGDIR)/packages

ifeq ($(BuildMode),release)
$(PKGTTG_DOC): ttg-doc_control.tmpl \
		$(TTGDIR)/examples/Britanico2000.ttd \
		$(TTGDIR)/examples/Salamanca1999.ttd
	mkdir -p $(DEBIAN)/ttg-doc.dir/DEBIAN
	mkdir -p $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/
	mkdir -p $(TTGDIR)/packages
	sed -e s:'<v>AppVersion</v>':'$(VERSION)':g \
	  -e s:'<v>BuildLabel</v>':'$(BuildLabel)':g \
	  -e s:'<v>Architecture</v>':'$(ARCH)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g ttg-doc_control.tmpl > $(DEBIAN)/ttg-doc.dir/DEBIAN/control
	cp $(TTGDIR)/examples/Britanico2000.ttd $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/Britanico2000.ttd
	cp $(TTGDIR)/examples/Salamanca1999.ttd $(DEBIAN)/ttg-doc.dir/usr/share/doc/ttg/examples/Salamanca1999.ttd
	cd $(OBJDIR)/debian ; dpkg --build ttg-doc.dir $(TTGDIR)/packages
endif

$(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

$(CATALOG): $(PACKAGES)
	cd $(TTGDIR)/packages/ ; dpkg-scanpackages . | gzip > Packages.gz

clean:
	$(RM) -r $(DEBIAN) $(TTGDIR)/packages/*.deb $(TTGDIR)/packages/Packages.gz

test:
	@echo PKGTTG=$(PKGTTG)
	@echo PKGTTG_DOC=$(PKGTTG_DOC)
	@echo DEBIAN=$(DEBIAN)
