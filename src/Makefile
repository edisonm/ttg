# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

RELDIR:=..
TTGDIR:=$(shell cd $(RELDIR); pwd)

TTGSRC=.

include SETTINGS

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .lpr .dpr

#.PRECIOUS: ttg.iss

all: $(FILES)

ifeq ($(shell uname -o),Cygwin)
$(LAZRES): $(LAZBASE)/tools/lazres.lpi
	cd "$(LAZBASE)/tools" && $(LAZBUILD) "lazres.lpi"
endif

%.lrs: %.lfm $(LRSDEP)
	$(LAZRES) $@ $<

%.mo: %.po
	msgfmt $< -o $@

# LOCALEFILES=locale/ttg.es.po

ttg.lrs: $(LOCALEFILES) $(TTGDIR)/dat/default.ttd $(TTGSQL)
	$(LAZRES) $@ $(LOCALEFILES) $(TTGDIR)/dat/default.ttd $(TTGSQL)

$(ABOUT).pas: $(ABOUT).pas.tmpl
	sed -e s:'<v>Package</v>':'$(Package)':g \
	  -e s:'<v>BaseVersion</v>':'$(BaseVersion)':g \
	  -e s:'<v>BuildMode</v>':'$(BuildMode)':g \
	  -e s:'<v>Revision</v>':'$(BuildNr)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>Copyright</v>':'$(Copyright)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

buildnr:
	SvnVersion=`svnversion $(TTGDIR)` ; \
	  Revision=`svn info $(REPOSITORY)|grep Revision|sed -e s:'Revision\: ':'':g -` ; \
	  if [ x"$(BuildNr)"=x"$${SvnVersion}" ] ; then \
	    BuildNr0=$$(($${Revision}+1)) ; \
	  else \
	    BuildNr0=$${Revision} ; \
	  fi ; \
	  if [ x"$(BuildNr)"=x"$${BuildNr0}" ] ; then \
	    ( sed -e s:"^ *<BuildNr Value=\"[0-9]*\"/>":"      <BuildNr Value=\"$${BuildNr0}\"/>":g ttg.lpi > ttg_.lpi && \
	      mv ttg_.lpi ttg.lpi ) ; \
	  fi

$(TTGEXE): $(BASELAZFILES) $(TTGLPR) ttg.lrs ttg.inc Makefile SETTINGS COMMON
	$(LAZBUILD) --build-mode=$(BuildMode) ttg.lpi
ifneq ($(BuildMode),debug)
	strip --strip-all $(TTGEXE)
	upx $(TTGEXE)
endif

cleanthis:
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(TTGDIR)/obj/* $(ABOUT).pas *.lrs

clean: cleanthis

test:
	@echo APPNAME=$(APPNAME)
	@echo Copyright=$(Copyright)
	@echo UNITS=$(UNITS)
	@echo Version=$(Version)
	@echo BuildNr0="$(BuildNr0)"
	@echo BuildNr=$(BuildNr)
	@echo Revision=$(Revision)
	@echo SvnVersion=$(SvnVersion)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo BuildId=$(BuildId)

run:
	$(TTGEXE)

ex1:
	$(TTGEXE) $(RELDIR)/examples/Britanico2000.ttd

ex2:
	$(TTGEXE) $(RELDIR)/examples/Salamanca1999.ttd

ex3:
	$(TTGEXE) $(RELDIR)/examples/original/Britanico2000.ttd

ex4:
	$(TTGEXE) $(RELDIR)/examples/original/Salamanca1999.ttd

ide:
	$(LAZIDE) ttg.lpi &
