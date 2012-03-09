# -*- mode: Makefile; -*-

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

ifneq ($(shell uname -o),Cygwin)
default:
	@echo "This Makefile only works in Cygwin"
endif

all: $(FILES)

catalog:

$(PKG): $(TTGEXE) ttg.iss.tmpl
	sed -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g \
	  -e s/'<v>ProgramFiles<\/v>'/'$(PROGRAMFILES)'/g \
	  -e s:'<v>PkgBase</v>':'$(PKGBASE)':g \
	  -e s:'<v>BuildLabel</v>':'$(PKGBASE)':g \
	  -e s:'<v>BuildId</v>':'$(BuildId)':g ttg.iss.tmpl > $(ISS)
	$(INNOIDE) $(ISSWIN)

$(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

test:
	@echo PKG=$(PKG)
	@echo ISS=$(ISS)
	@echo BuildId=$(BuildId)
	@echo REVISION=$(REVISION)
	@echo TTGEXE=$(TTGEXE)

clean:
	$(RM) $(ISS) $(PKG)


