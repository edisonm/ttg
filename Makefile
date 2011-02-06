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
TTGSQLITE3=dat/TTG.db
DSRCBASE=src/DSrcBase
ABOUTPAS=src/About.pas

UNITS=KerModel RelUtils HorColCm TTGUtls Rand SortAlgs About KerEvolE	\
	BaseUtls UConfig

FORMS=FCrsMMEd FSplash FSingEdt FMasDeEd FHorario FLogstic FCrsMME0	\
	FCrsMME1 FHorProf FProfesr DSrcBase FMain FEditor DMaster	\
	FHorPara DSource FSelPeIn FConfig FCrsMMER DBase FHorAulT	\
	FParalel FProgres FMateria


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

$(TTGEXE): src/$(TTGDPR) $(DSRCBASE).pas $(ABOUTPAS)
	cd src; $(DCC32) $(DCC32OPTS) $(TTGDPR)

$(DBUTILS): DBUTILS/$(DBUTILSDPR)
	cd DBUTILS; $(DCC32) $(DCC32OPTS) $(DBUTILSDPR)

$(DSRCBASE).pas: $(DBUTILS) $(TTGMDB)
	$(DBUTILS) /ACC2DM $(TTGMDB) SourceBaseDataModule '$(shell cygpath -w $(DSRCBASE))' /DS

$(TTGSQL): $(DBUTILS) $(TTGMDB)
	$(DBUTILS) /ACC2SQL $(TTGMDB) '$(shell cygpath -w $@)'

$(TTGSQLITE3): $(TTGSQL)
	sqlite3 $(TTGSQLITE3) ".read $(TTGSQL)"

clean:
	$(RM) $(INSTALLER) $(TTGEXE) $(DBUTILS) $(TTGSQL) \
	  $(TTGSQLITE3) obj/* \
	  src/DSrcBase.{pas,dfm} \
	  $(ISS) $(ABOUTPAS)
	$(RM) -r src/__history DBUTILS/__history

.PHONY: srclaz

srclaz:
	for i in $(UNITS) $(FORMS) ; do \
	  cp src/$$i.pas srclaz/$$i.pas ; \
	done
	for i in $(FORMS) ; do \
	  cp src/$$i.dfm srclaz/$$i.lfm ; \
	  lazres srclaz/$$i.lrs srclaz/$$i.lfm ; \
	done
	cp src/TTG.dpr srclaz/TTG.lpr ; \
	cd srclaz ; find . -name "*.pas" -exec str_replace "TkbmMemTable"    "TSqlite3Dataset" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "TkbmMemTable"    "TSqlite3Dataset" {} \;
	cd srclaz ; find . -name "*.pas" -exec str_replace "kbmMemTable"     "Sqlite3DS" {} \;
	cd srclaz ; find . -name "*.pas" -exec str_replace "KbmMemTable"     "Sqlite3DS" {} \;
	cd srclaz ; find . -name "*.pas" -exec str_replace "TIntegerField"   "TLongIntField" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "TIntegerField"   "TLongIntField" {} \;
	cd srclaz ; find . -name "*.pas" -exec str_replace "Windows,"        "LResources," {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "  OldCreateOrder = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "  TextHeight = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "  ExplicitWidth = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "  ExplicitHeight = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    ExplicitTop = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    ExplicitLeft = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    DesignActivation = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    AttachedAutoRefresh = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    AttachMaxCount = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    FieldDefs = <>" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    IndexDefs = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    SortOptions = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    PersistentBackup = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    ProgressFlags = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    LoadedCompletely = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    SavedCompletely = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    Version = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    LanguageID = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    SortID = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    SubLanguageID = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    LocaleID = .*" "" {} \;
	cd srclaz ; find . -name "*.lfm" -exec str_replace "    FilterOptions = .*" "" {} \;

srclazclean:
	for i in $(UNITS) $(FORMS) ; do \
	  $(RM) srclaz/$$i.pas ; \
	done
	for i in $(FORMS) ; do \
	  $(RM) srclaz/$$i.lfm srclaz/$$i.lrs ; \
	done
	$(RM) -r srclaz/TTG.lpr

test:
	@echo TTGDIR=$(TTGDIR)
