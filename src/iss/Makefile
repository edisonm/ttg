# -*- mode: Makefile; -*-

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

ifneq ($(shell uname -o),Cygwin)

default:
	@echo "This Makefile only works in Cygwin"

endif

all: $(INSTALLER)

$(INSTALLER): $(ISS) $(TTGEXE)
	$(INNOIDE) $(ISSWIN)

$(ISS): $(ISSTMPL) $(TTGEXE)
	sed  -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g \
	  -e s/'<v>ProgramFiles<\/v>'/'$(PROGRAMFILES)'/g \
	  -e s/'<v>BuildId<\/v>'/'$(BuildId)'/g $< > $@

$(TTGEXE):
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) all

test:
	@echo ISS=$(ISS)
	@echo BuildId=$(BuildId)
	@echo TTGEXE=$(TTGEXE)
	@echo REVISION=$(REVISION)
	cd $(TTGSRC) ; $(MAKE) BuildMode=$(BuildMode) test

cleanthis:
	$(RM) $(ISS) $(TTGEXE) $(INSTALLER)

clean: cleanthis
	cd $(TTGSRC) ; $(MAKE) clean
