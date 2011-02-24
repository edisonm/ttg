# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

include ../../SETTINGS
include ../../COMMON

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

BASEDELFILES=$(addsuffix .pas,  $(FORMS) $(DSRCBASE) $(UNITS) $(ABOUT)) \
	  $(addsuffix .dfm, $(FORMS) $(DSRCBASE)) ttg.dpr

DELPHIFILES=$(BASEDELFILES)

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
