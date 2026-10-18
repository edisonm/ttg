# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

RELDIR:=..
TTGDIR:=$(shell cd $(RELDIR); pwd)

TTGSRC=.

include SETTINGS

VPATH:=$(OBJDIR)

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .lpr .dpr

#.PRECIOUS: ttg.iss

all: $(FILES) $(TTGSOLVE)

ifeq ($(shell uname -o),Cygwin)
$(LAZRES): $(LAZBASE)/tools/lazres.lpi
	cd "$(LAZBASE)/tools" && $(LAZBUILD) "lazres.lpi"
endif

# %.lrs: %.lfm $(LRSDEP)
# 	$(LAZRES) $(OBJDIR)/$@ $<

%.mo: %.po
	msgfmt $< -o $@

# LOCALEFILES=locale/ttg.es.po

ttg.lrs: $(LOCALEFILES) $(RELDIR)/dat/default.ttd $(TTGSQL)
	$(LAZRES) $(OBJDIR)/$@ $(LOCALEFILES) $(RELDIR)/dat/default.ttd $(TTGSQL)

$(ABOUT).pas: $(ABOUT).pas.tmpl
	mkdir -p $(OBJDIR)
	sed -e s:'@Package@':'$(Package)':g \
	  -e s:'@BaseVersion@':'$(BaseVersion)':g \
	  -e s:'@BuildMode@':'$(BuildMode)':g \
	  -e s:'@Revision@':'$(BuildNr)':g \
	  -e s:'@BuildDateTime@':"$(BUILDDATETIME)":g \
	  -e s:'@Copyright@':'$(Copyright)':g \
	  -e s:'@BuildId@':'$(BuildId)':g \
	  -e s:'@AppName@':'$(APPNAME)':g $< > $(OBJDIR)/$@

buildnr:
#	Revision=`svn info $(TTGDIR)|grep 'Last Changed Rev'|sed -e s/'Last Changed Rev: '//g -` ;
	Revision=`svn info $(REVISION)|grep Revision|sed -e s:'Revision\: ':'':g -` ; \
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
ifneq ($(TargetSYS),x86_64-win64)
	upx $(TTGEXE)
endif
endif

$(TTGSOLVE): $(BASELAZFILES) ttgsolve.lpr ttgsolve.lpi ttg.lrs ttg.inc Makefile SETTINGS COMMON
	$(LAZBUILD) --build-mode=$(BuildMode) --ws=nogui ttgsolve.lpi
ifneq ($(BuildMode),debug)
	strip --strip-all $(TTGSOLVE)
endif

cleanthis:
	$(RM) -r $(TTGDIR)/bin $(TTGDIR)/obj $(ABOUT).pas *.lrs

clean: cleanthis

test: $(TTGSOLVE)
	sh $(RELDIR)/tests/run-tests.sh $(TTGSOLVE) $(RELDIR)/examples

run:
	$(TTGEXE)

EX?=Britanico2000.ttd

solve:
	$(TTGSOLVE) --solve $(RELDIR)/examples/$(EX)

ex1:
	$(TTGEXE) $(RELDIR)/examples/Britanico2000.ttd

ex2:
	$(TTGEXE) $(RELDIR)/examples/Salamanca1999.ttd

ex3:
	$(TTGEXE) $(RELDIR)/examples/original/Britanico2000.ttd

ex4:
	$(TTGEXE) $(RELDIR)/examples/original/Salamanca1999.ttd

ex5:
	$(TTGEXE) $(RELDIR)/examples/Herradura2013.ttd

ide:
	$(LAZIDE) ttg.lpi &
