# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

TTGDIR:=$(shell cd ../..; pwd)

include ../../SETTINGS
include ../../COMMON

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

DELPHIFILES=$(BASEDELFILES)

all: $(TTGEXE)

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

$(TTGEXE): $(BASELAZFILES) ttg.lpi
	lazbuild ttg.lpi

$(DSRCBASE).pp $(DSRCBASE).lfm: dbutils $(TTGMDB) Makefile
	$(DBUTILS) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;lfm;U=ZConnection, ZDataset;DS=ZTable'
	dos2unix $(DSRCBASE).pp $(DSRCBASE).lfm

dbutils:
	cd ../.. ; $(MAKE) $(DBUTILS)

clean:
# 	$(DSRCBASE0).lfm $(DSRCBASE0).pp
	$(RM) $(TTGEXE) $(TTGDIR)/bin/*.o $(TTGDIR)/bin/*.lrs \
	  $(TTGDIR)/bin/*.ppu $(TTGDIR)/obj/*.o $(TTGDIR)/obj/*.ppu \
	  $(ABOUT).pp

test:
	@echo REVISION=$(REVISION)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo DSRCBASE=$(DSRCBASE)

run:
	cd $(TTGDIR)/bin ; $(TTGEXE)
