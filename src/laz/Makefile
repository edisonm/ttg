# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

TTGDIR:=$(shell cd ../..; pwd)

include ../../SETTINGS
include ../../COMMON
include SETTINGS

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

DELPHIFILES=$(BASEDELFILES)

all: $(FILES)

iss: $(ISS)

ifeq ($(shell uname -o),Cygwin)
$(LAZRES):
	cd "$(LAZBASE)/tools" && $(LAZBUILD) "lazres.lpi"
endif

$(INSTALLER): $(ISS) $(TTGEXE) $(TTGSQL)
	$(INNOIDE) $(ISSWIN)

$(ISS): $(ISSTMPL) $(TTGEXE)
	sed  -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g \
	  -e s/'<v>ProgramFiles<\/v>'/'$(PROGRAMFILES)'/g \
	  -e s:'<v>BuildID</v>':'$(BuildID)':g $< > $@

##############################################################################
# Migration options (lazarus-delphi): !!! WARNING VERY BUGGLY
# NOT COMPATIBLE AT ALL !!!
##############################################################################

%.pas: %.pp
	sed \
	  -e s:"TStringField":"TWideStringField":g \
	  -e s:"TLongintField":"TIntegerField":g $< | unix2dos > $@

%.dfm: %.lfm
	sed \
	  -e s:"TStringField":"TWideStringField":g \
	  -e s:"TLongIntField":"TIntegerField":g \
	  -e s:"  LCLVersion = .*":"":g \
	  -e s:"    BkColor = .*":"":g \
	  -e s:"      ResizeAnchor = .*":"":g \
	$< | unix2dos > $@

%.dpr: %.lpr
	sed -e s:"\.pp":"\.pas":g $< | dos2unix > $@

# srclazclean:
# 	$(RM) -r $(addprefix prjlaz/, $(BASEDELFILES) $(DSRCBASE0).pp $(DSRCBASE0).lfm $(DSRCBASE0).lrs ttg.inc)

srcdel: $(DELPHIFILES)

prjdel: srcdel
	unix2dos < ttg.inc > ../../src/del/ttg.inc
	mv $(DELPHIFILES) ../../src/del/

$(ABOUT).pp: $(ABOUT).pp.tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGSQLINC): $(TTGSQL)
	cat $< | dos2unix | sed -e s:"'":"''":g -e s:"\(.*\)":"add(\'\1\');":g > $@

uttgsql.pp: $(TTGSQLINC)

$(TTGEXE): $(BASELAZFILES) ttg.lpi
	$(LAZBUILD) --build-mode=$(BuildMode) ttg.lpi ; strip --strip-all $(TTGEXE)

$(DSRCBASE).pp $(DSRCBASE).lfm: $(DBCONVERT) $(TTGMDB) Makefile
	$(DBCONVERT) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;lfm;U=ZConnection, ZDataset;DS=ZTable'
	dos2unix $(DSRCBASE).pp $(DSRCBASE).lfm

$(DBCONVERT):
	cd ../.. ; $(MAKE) $(DBCONVERT)

ifeq ($(shell uname -o),Cygwin)

cleanlfm:
	$(RM) $(DSRCBASE0).{lfm,lrs,pp} $(TTGSQLINC)

else

cleanlfm:

endif

clean: cleanlfm
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(ABOUT).pp

test:
	@echo REVISION=$(REVISION)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo DSRCBASE=$(DSRCBASE)

run:
	cd $(TTGDIR)/bin ; $(TTGEXE)
