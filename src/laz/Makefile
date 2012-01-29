# -*- mode: Makefile; -*-

# This makefile is used only to generate the lazarus project

RELDIR:=../..
TTGDIR:=$(shell cd $(RELDIR); pwd)

include SETTINGS

.PHONY: prjdel srcdel

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

#.PRECIOUS: ttg.iss

all: $(FILES)

ifeq ($(shell uname -o),Cygwin)
$(LAZRES): $(LAZBASE)/tools/lazres.lpi
	cd "$(LAZBASE)/tools" && $(LAZBUILD) "lazres.lpi"
endif

%.lrs: %.lfm $(LRSDEP)
	$(LAZRES) $@ $<

$(ABOUT).pp: $(ABOUT).pp.tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>Revision</v>':'$(REVISION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGSQLINC): $(TTGSQL)
	cat $< | dos2unix | sed -e s:"'":"''":g -e s:"\(.*\)":"add(\'\1\');":g > $@

uttgsql.pp: $(TTGSQLINC)

$(TTGEXE): $(BASELAZFILES) $(TTGLPR)
	$(LAZBUILD) --build-mode=$(BuildMode) ttg.lpi ; strip --strip-all $(TTGEXE)

ifeq ($(shell uname -o),Cygwin)

ttgsql: $(TTGSQL)

$(TTGSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGSQL) sqlite

$(TTGMYSQL): $(DBCONVERT) $(TTGMDB)
	$(DBCONVERT) /ACC2SQL $(TTGMDB) $(TTGMYSQL) mysql

$(DSRCBASE).pp $(DSRCBASE).lfm: $(DBCONVERT) $(TTGMDB) Makefile
	$(DBCONVERT) /ACC2DM $(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;lfm;U=ZConnection, ZDataset;DS=ZTable;DB=ZConnection;DP=Connection'
	dos2unix $(DSRCBASE).pp $(DSRCBASE).lfm

cleanthisw:
	$(RM) $(DSRCBASE).{lfm,lrs,pp} $(TTGSQLINC) \
	   $(TTGSQL) $(TTGMYSQL)

$(DBCONVERT):
	cd $(DBCONVERTSRC) ; $(MAKE) all

clean:
	cd $(DBCONVERTSRC) ; $(MAKE) clean

else

cleanthisw:

endif

cleanthis: cleanthisw
	$(RM) -r $(TTGEXE) $(TTGDIR)/bin/* $(ABOUT).pp

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
	cd $(TTGDIR)/bin ; $(TTGEXE)

ide:
	lazarus-ide ttg.lpi

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
