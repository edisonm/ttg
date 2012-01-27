# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

RELDIR:=../..

TTGDIR:=$(shell cd $(RELDIR); pwd)

include $(RELDIR)/SETTINGS
include $(RELDIR)/COMMON
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

$(TTGEXE): $(BASELAZFILES)
	$(LAZBUILD) --build-mode=$(BuildMode) ttg.lpi ; strip --strip-all $(TTGEXE)

ifeq ($(shell uname -o),Cygwin)

$(TTGSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGSQL) sqlite

$(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGMYSQL) mysql

$(DSRCBASE).pp $(DSRCBASE).lfm: $(DBCONVERT) $(TTGMDB) Makefile
	$(DBCONVERT) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;lfm;U=ZConnection, ZDataset;DS=ZTable'
	dos2unix $(DSRCBASE).pp $(DSRCBASE).lfm

$(DBCONVERT):
	cd ../.. ; $(MAKE) $(DBCONVERT)

cleanwin:
	$(RM) $(DSRCBASE).{lfm,lrs,pp} $(TTGSQLINC) \
	   $(TTGSQL) $(TTGMYSQL) $(DBCONVERT) $(INSTALLER)

else

cleanwin:


endif

clean: cleanwin
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(ABOUT).pp

test:
	@echo UNITS=$(UNITS)
	@echo REVISION=$(REVISION)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo DSRCBASE=$(DSRCBASE)

run:
	cd $(TTGDIR)/bin ; $(TTGEXE)

ide:
	lazarus-ide ttg.lpi
