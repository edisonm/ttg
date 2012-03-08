# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .lpr .dpr

#.PRECIOUS: ttg.iss

all: $(FILES)

$(LAZRES): $(LAZBASE)/tools/lazres.lpi
	cd "$(LAZBASE)/tools" && $(LAZBUILD) "lazres.lpi"

# %.lrs: %.lfm $(LRSDEP)
# 	$(LAZRES) $@ $<

ttg.lrs: locale/ttg.es.po
	$(LAZRES) $@ $<

ttgsql.lrs: $(TTGSQL)
	$(LAZRES) $@ $<

$(ABOUT).pas: $(ABOUT).pas.tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGEXE): $(BASELAZFILES) $(TTGLPR) ttgsql.lrs ttg.lrs ttg.inc
	$(LAZBUILD) --build-mode=$(BuildMode) ttg.lpi
ifneq ($(BuildMode),debug)
	cp $(TTGEXE) $(TTGEXE).bak
	strip --strip-all $(TTGEXE)
	upx $(TTGEXE)
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
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(ABOUT).pas *.lrs

clean: cleanthis

test:
	@echo UNITS=$(UNITS)
	@echo REVISION=$(REVISION)
	@echo TTGEXE=$(TTGEXE)
	@echo BASELAZFILES=$(BASELAZFILES)
	@echo DSRCBASE=$(DSRCBASE)
	@echo DBCONVERT=$(DBCONVERT)
	@echo BuildId=$(BuildId)

	@echo $(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	@echo $(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGMYSQL) mysql

run:
	cd $(TTGDIR)/bin/$(BuildId) ; $(TTGEXE)

ex1:
	cd $(TTGDIR)/bin/$(BuildId) ; $(TTGEXE) $(TTGDIR)/demos/BritanicoInt2000.ttd

ex2:
	cd $(TTGDIR)/bin/$(BuildId) ; $(TTGEXE) $(TTGDIR)/demos/Salamanca1999.ttd

ex3:
	cd $(TTGDIR)/bin/$(BuildId) ; $(TTGEXE) $(TTGDIR)/demos/BritanicoInt2000_2.ttd

ex4:
	cd $(TTGDIR)/bin/$(BuildId) ; $(TTGEXE) $(TTGDIR)/demos/Salamanca1999_2.ttd

ide:
	$(LAZIDE) ttg.lpi &

getBuildId:
	@echo $(BuildId)

getTTGEXE:
	@echo $(TTGEXE)

getREVISION:
	@echo $(REVISION)

getAPPVERSION:
	@echo $(APPVERSION)

getAPPNAME:
	@echo $(APPNAME)
