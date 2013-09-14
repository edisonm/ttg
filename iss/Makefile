# -*- mode: Makefile; -*-

RELDIR:=..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

ifneq ($(shell uname -o),Cygwin)
default:
	@echo "This Makefile only works in Cygwin"
endif

all:
	$(MAKE) ttg
	$(MAKE) $(FILES)

catalog:

$(PKG): ttg.iss.tmpl
	sed -e s:'@Revision@':'$(BuildNr)':g \
	  -e s:'@BaseVersion@':'$(BaseVersion)':g \
	  -e s:'@AppName@':'$(APPNAME)':g \
	  -e s/'@ProgramFiles@'/'$(PROGRAMFILES)'/g \
	  -e s/'@Copyright@'/'$(Copyright)'/g \
	  -e s:'@PkgBase@':'$(PKGBASE)':g \
	  -e s:'@BuildId@':'$(BuildId)':g ttg.iss.tmpl > $(ISS)
	mkdir -p $(PKGDIR)
	$(INNOIDE) $(ISSWIN)
# -e s/'@BuildMode@'/'$(BuildMode)'/g
# -e s/'@PkgDir@'/'..\$(shell cygpath -w $(PKGDIR))'/g

ttg $(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

test:
	@echo PKG=$(PKG)
	@echo ISS=$(ISS)
	@echo BuildId=$(BuildId)
	@echo BuildNr=$(BuildNr)
	@echo TTGEXE=$(TTGEXE)

clean:
	$(RM) $(ISS) $(PKG)

run:
	$(PKG)
