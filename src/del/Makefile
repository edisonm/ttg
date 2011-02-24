# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

include ../../SETTINGS
include ../../COMMON

.PHONY: prjlaz srclaz

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

BASELAZFILES=$(addsuffix .pp,  $(FORMS) $(DSRCBASE) $(UNITS) $(ABOUT)) \
	  $(addsuffix .lfm, $(FORMS) $(DSRCBASE)) \
	  $(addsuffix .lrs, $(FORMS) $(DSRCBASE)) ttg.lpr

LAZARUSFILES=$(BASELAZFILES)

%.lrs: %.lfm
	$(LAZRES) $@ $<

%.pp: %.pas
	sed \
	  -e s:"TWideStringField":"TStringField":g \
	  -e s:"TIntegerField":"TLongintField":g $< | dos2unix > $@

%.lfm: %.dfm
	sed \
	  -e s:"TWideStringField":"TStringField":g \
	  -e s:"TIntegerField":"TLongIntField":g \
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
