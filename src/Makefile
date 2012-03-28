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
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
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
# upx $(TTGEXE)
endif

ifeq ($(shell uname -o),Cygwin)

dbfiles: $(TTGSQL) $(TTGMYSQL) $(DSRCBASE).pas $(DSRCBASE)consts.pas $(DSRCBASE).lfm

dbclean:
	$(RM) $(TTGSQL) $(TTGMYSQL) $(DSRCBASE).pas $(DSRCBASE)consts.pas $(DSRCBASE).lfm

ttgsql: $(TTGSQL)

$(TTGSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGSQL) sqlite
	dos2unix $(TTGSQL)

$(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGMYSQL) mysql
	dos2unix $(TTGSQL)

$(DSRCBASE).pas $(DSRCBASE)consts.pas $(DSRCBASE).lfm: $(DBCONVERT) $(TTGMDB) Makefile
	$(DBCONVERT) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;urt;lfm;U=ZConnection, ZDataset;DS=ZTable;DB=ZConnection;DP=Connection'
	dos2unix $(DSRCBASE).pas $(DSRCBASE)Consts.pas $(DSRCBASE).lfm

cleanthisw:
	$(RM) $(DSRCBASE).{lfm,lrs,pas} $(DSRCBASE)Consts.pas $(TTGSQL) $(TTGMYSQL)

$(DBCONVERT):
	cd $(DBCONVERTSRC) ; $(MAKE) all

clean:
	cd $(DBCONVERTSRC) ; $(MAKE) clean

else

cleanthisw:

endif

cleanthis: cleanthisw
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(TTGDIR)/obj/* $(ABOUT).pas *.lrs

clean: cleanthis

test:
	@echo APPNAME=$(APPNAME)
	@echo Copyright=$(Copyright)
	@echo UNITS=$(UNITS)
	@echo VERSION=$(VERSION)
	@echo BuildNr0="$(BuildNr0)"
	@echo BuildNr=$(BuildNr)
	@echo Revision=$(Revision)
	@echo SvnVersion=$(SvnVersion)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo DSRCBASE=$(DSRCBASE)
	@echo DBCONVERT=$(DBCONVERT)
	@echo BuildId=$(BuildId)
	@echo $(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	@echo $(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGMYSQL) mysql

run:
	$(TTGEXE)

ex1:
	$(TTGEXE) $(TTGDIR)/examples/Britanico2000.ttd

ex2:
	$(TTGEXE) $(TTGDIR)/examples/Salamanca1999.ttd

ex3:
	$(TTGEXE) $(TTGDIR)/examples/original/Britanico2000.ttd

ex4:
	$(TTGEXE) $(TTGDIR)/examples/original/Salamanca1999.ttd

ide:
	$(LAZIDE) ttg.lpi &
