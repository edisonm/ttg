# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

INNOIDE="c:/archivos de programa/Inno Setup 5/ISCC.exe"
TTGDIR:=$(shell pwd)
ISS=$(TTGDIR)/install/TTG.iss
INSTALLER=$(TTGDIR)/bin/TTGSETUP.exe
TTGEXE=$(TTGDIR)/bin/TTG.exe
DBUTILS=$(TTGDIR)/bin/DBUTILS.exe
DCC32="c:/archivos de programa/CodeGear/RAD Studio/5.0/bin/dcc32"
DCC32OPTS= \
	-E'$(shell cygpath -w $(TTGDIR)/bin)' \
	-U'$(shell cygpath -w $(TTGDIR)/../kbmMemTable552/Source)' \
	-N0'$(shell cygpath -w $(TTGDIR)/obj)'
TTGDPR=TTG.dpr
DBUTILSDPR=DBUTILS.dpr
TTGMDB=dat/TTG.mdb
TTGSQL=dat/TTG.sql
TTGSQLITE3=dat/TTG.s3fpc

ifneq ($(shell uname -s),Linux)
DSRCBASE=DSrcBase
LAZRES="c:/lazarus/tools/lazres"
else
LAZRES=lazres
endif

ABOUTPAS=src/About.pas

UNITS=KerModel RelUtils HorColCm TTGUtls Rand SortAlgs About KerEvolE	\
	UConfig

FORMS=FCrsMMEd FSplash FSingEdt FMasDeEd FHorario FLogstic FCrsMME0	\
	FCrsMME1 FHorProf FProfesr FMain FEditor DMaster FHorPara	\
	DSource FSelPeIn FConfig FCrsMMER DBase FHorAulT FParalel	\
	FProgres FMateria


APPVERSION=1.2.1
APPNAME=Generador Automatico de Horarios
BUILDDATETIME=$(shell date +%a\ %b\ %e\ %H\\:%M\\:%S\ \ \ \ %Y)

all: $(INSTALLER) $(TTGSQLITE3)

dcchelp:
	$(DCC32)

$(INSTALLER): $(ISS) $(TTGEXE)
	$(INNOIDE) '$(shell cygpath -w $(ISS))'

iss: $(ISS)

$(ISS): $(ISS).tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(ABOUTPAS): $(ABOUTPAS).tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGEXE): src/$(TTGDPR) $(addprefix src/, $(addsuffix .pas, $(UNITS) $(FORMS) $(DSRCBASE))) $(ABOUTPAS)
	cd src; $(DCC32) $(DCC32OPTS) $(TTGDPR)

$(DBUTILS): DBUTILS/$(DBUTILSDPR)
	cd DBUTILS; $(DCC32) $(DCC32OPTS) $(DBUTILSDPR)

src/$(DSRCBASE).pas: $(DBUTILS) $(TTGMDB)
	cd src ; $(DBUTILS) /ACC2DM ../$(TTGMDB) SourceBaseDataModule $(DSRCBASE) 'csi;cfd;cdf;csr;cds;U=kbmMemTable;DS=kbmMemTable'

src/$(DSRCBASE).pp: $(DBUTILS) $(TTGMDB)
	cd src ; $(DBUTILS) /ACC2DM ../$(TTGMDB) SourceBaseDataModule $(DSRCBASE) 'cfd;cdf;cds;lfm;U=Sqlite3DS;DS=Sqlite3Dataset'

$(TTGSQL): $(DBUTILS) $(TTGMDB)
	$(DBUTILS) /ACC2SQL $(TTGMDB) $@

$(TTGSQLITE3): $(TTGSQL)
	$(RM) $@
	sqlite3 $@ ".read $(TTGSQL)"

clean:
	$(RM) $(INSTALLER) $(TTGEXE) $(DBUTILS) $(TTGSQL) \
	  $(TTGSQLITE3) obj/* \
	  src/$(DSRCBASE).{pas,dfm} \
	  $(ISS) $(ABOUTPAS)
	$(RM) -r src/__history DBUTILS/__history

.PHONY: srclaz

.SUFFIXES: .lrs .lfm .dfm .pas .pp .lpr .dpr

%.pp: %.pas
	sed \
	  -e s:"TkbmMemTable":"TSqlite3Dataset":g \
	  -e s:"kbmMemTable":"Sqlite3DS":g \
	  -e s:"TIntegerField":"TLongIntField":g \
	  -e s:"Windows,":"LResources,":g  $< > $@

%.lfm: %.dfm
	sed -e s:"TkbmMemTable":"TSqlite3Dataset":g \
	  -e s:"kbmMemTable":"Sqlite3DS":g \
	  -e s:"KbmMemTable":"Sqlite3DS":g \
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
	  -e s:"    FieldDefs = <>":"":g \
	  -e s:"    IndexDefs = .*":"":g \
	  -e s:"    SortOptions = .*":"":g \
	  -e s:"    PersistentBackup = .*":"":g \
	  -e s:"    ProgressFlags = .*":"":g \
	  -e s:"    LoadedCompletely = .*":"":g \
	  -e s:"    SavedCompletely = .*":"":g \
	  -e s:"    Version = .*":"":g \
	  -e s:"    LanguageID = .*":"":g \
	  -e s:"    SortID = .*":"":g \
	  -e s:"    SubLanguageID = .*":"":g \
	  -e s:"    LocaleID = .*":"":g \
	  -e s:"    FilterOptions = .*":"":g \
	  -e s:"      Lookup = .*":"":g \
	  -e s:"      ParentShowHint = .*":"":g \
	  -e s:"      Calculated = .*":"":g $< > $@

%.lrs: %.lfm
	$(LAZRES) $@ $<

%.lpr: %.dpr
	sed -e s:"\.pas":"\.pp":g $< > $@

BASELAZFILES=$(addsuffix .pp,  $(FORMS) $(DSRCBASE) $(UNITS)) \
	  $(addsuffix .lfm, $(FORMS) $(DSRCBASE)) \
	  $(addsuffix .lrs, $(FORMS) $(DSRCBASE)) TTG.lpr

LAZARUSFILES=$(addprefix src/, $(BASELAZFILES))

srclaz: $(LAZARUSFILES)

prjlaz: srclaz
	cp src/TTG.inc prjlaz/TTG.inc
	mv $(LAZARUSFILES) prjlaz/

srclazclean:
	$(RM) -r $(addprefix prjlaz/, $(LAZARUSFILES))

test:
	@echo TTGDIR=$(TTGDIR)
	@echo FILES=$(addprefix src/, $(addsuffix .pas, $(UNITS) $(FORMS) $(DSRCBASE)))
