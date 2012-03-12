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
	sed -e s:'<v>Revision</v>':'$(BuildNr)':g \
	  -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g \
	  -e s/'<v>ProgramFiles<\/v>'/'$(PROGRAMFILES)'/g \
	  -e s:'<v>PkgDir</v>':'$(shell cygpath -w $(PKGDIR))':g \
	  -e s:'<v>PkgBase</v>':'$(PKGBASE)':g \
	  -e s:'<v>BuildLabel</v>':'$(BuildLabel)':g \
	  -e s:'<v>BuildId</v>':'$(BuildId)':g ttg.iss.tmpl > $(ISS)
	$(INNOIDE) $(ISSWIN)

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


