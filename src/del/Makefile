# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

TTGDIR:=$(shell cd ../.. ; pwd)

include ../../SETTINGS
include ../../COMMON

.PHONY: prjlaz srclaz

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

LAZARUSFILES=$(BASELAZFILES)

all: $(TTGEXE)

##############################################################################
# Migration options (delphi-lazarus):
##############################################################################

%.pp: %.pas
	sed \
	  -e s:"TWideStringField":"TStringField":g \
	  -e s:"TIntegerField":"TLongintField":g $< | dos2unix > $@

%.lfm: %.dfm
	sed \
	  -e s:"TWideStringField":"TStringField":g \
	  -e s:"TIntegerField":"TLongintField":g \
	  -e s:"  OldCreateOrder = .*":"":g \
	  -e s:"  TextHeight = .*":"":g \
	  -e s:"  ExplicitWidth = .*":"":g \
	  -e s:"  ExplicitHeight = .*":"":g \
	  -e s:"    ExplicitTop = .*":"":g \
	  -e s:"    ExplicitLeft = .*":"":g \
	  -e s:"    DesignActivation = .*":"":g \
	  -e s:"    AttachedAutoRefresh = .*":"":g \
	  -e s:"    AttachMaxCount = .*":"":g \
	  -e s:"    FilterOptions = .*":"":g \
	  -e s:"    DoubleBuffered = .*":"":g \
	  -e s:"    ParentDoubleBuffered = .*":"":g \
	  -e s:"    Lookup = .*":"":g \
	  -e s:"    Calculated = .*":"":g \
	  -e s:"      ParentShowHint = .*":"":g $< | dos2unix > $@

%.lpr: %.dpr
	sed -e s:"\.pas":"\.pp":g $< | dos2unix > $@

# srclazclean:
# 	$(RM) -r $(addprefix prjlaz/, $(BASELAZFILES) $(DSRCBASE0).pp $(DSRCBASE0).lfm $(DSRCBASE0).lrs ttg.inc)

srclaz: $(LAZARUSFILES)

prjlaz: srclaz
	dos2unix < ttg.inc > ../../src/laz/ttg.inc
	mv $(LAZARUSFILES) ../../src/laz/

##############################################################################
# Compiling options (Delphi)
##############################################################################

dcchelp:
	$(DCC32)

$(ABOUT).pas: $(ABOUT).pas.tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGEXE): $(BASEDELFILES)
	$(DCC32) $(DCC32OPTS) $(TTGDPR)

$(DSRCBASE).pas: $(DBUTILS) $(TTGMDB) Makefile
	$(DBUTILS) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;U=ZConnection, ZDataset;DS=ZTable'

$(DBUTILS):
	cd ../.. ; $(MAKE) $(DBUTILS)

clean:
	$(RM) $(TTGEXE) $(TTGDIR)/obj/*.dcu \
	  $(DSRCBASE0).pas $(DSRCBASE0).dfm *.identcache
	$(RM) -r src/del/__history

test:
	@echo TTGDIR=$(TTGDIR)
	@echo FILES=$(addsuffix .pas, $(UNITS) $(FORMS) $(DSRCBASE) $(ABOUT))
