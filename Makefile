# -*- mode: Makefile; -*-

# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

TTGDIR:=$(shell pwd)

include SETTINGS
include COMMON

INNOIDE="c:/archivos de programa/Inno Setup 5/ISCC.exe"
ISS=$(TTGDIR)/src/iss/ttg.iss
INSTALLER=$(TTGDIR)/bin/ttgsetup.exe

DBUTILSDPR=dbutils.dpr
TTGMDB=dat/$(TTGMDBBASE)
TTGSQL=dat/ttg.sql
TTGSQLITE3=dat/ttg.s3fpc

DBUNITS=Ac2DMUtl Ac2PxUtl Acc2DM Acc2Pdx Acc2SQL AccUtl DBPack PdxUtils

APPVERSION=1.2.2
APPNAME=Generador Automatico de Horarios
BUILDDATETIME=$(shell date +%a\ %b\ %e\ %H\\:%M\\:%S\ %Y)

all: $(INSTALLER) $(TTGSQLITE3)

$(INSTALLER): $(ISS) $(TTGEXE)
	$(INNOIDE) '$(shell cygpath -w $(ISS))'

iss: $(ISS)

$(ISS): $(ISS).tmpl $(TTGSQL)
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

SRCTYPE=del
# SRCTYPE=laz

$(TTGEXE):
	cd src/$(SRCTYPE) ; $(MAKE) $(TTGEXE)

$(DBUTILS): src/dbutils/$(DBUTILSDPR) $(addprefix src/dbutils/, $(addsuffix .pas, $(DBUNITS)))
	cd src/dbutils; $(DCC32) $(DCC32OPTS) $(DBUTILSDPR)

$(TTGSQL): $(DBUTILS) $(TTGMDB)
	$(DBUTILS) /ACC2SQL $(TTGMDB) $@

$(TTGSQLITE3): $(TTGSQL) Makefile
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

clean:
	cd src/del; $(MAKE) clean
	cd src/laz; $(MAKE) clean
	$(RM) $(INSTALLER) $(DBUTILS) $(TTGSQL) \
	  $(TTGSQLITE3) obj/* $(ISS) $(ABOUT).pas src/dbutils/*.identcache
	$(RM) -r src/dbutils/__history

kbmtosq3:
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0) $(UNITS) $(ABOUT)) ; do \
	  sed \
	  -e s:"TkbmMemTable":"TSqlitePassDataset":g \
	  -e s:"kbmMemTable":"SqlitePassDbo":g \
	  -e s:"TIntegerField":"TLargeintField":g $$i.pas > $$i.pas.tmp && \
	  mv -f $$i.pas.tmp $$i.pas ; done
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0)) ; do \
	  sed -e s:"TkbmMemTable":"TSqlitePassDataset":g \
	  -e s:"kbmMemTable":"SqlitePassDbo":g \
	  -e s:"KbmMemTable":"SqlitePassDbo":g \
	  -e s:"TIntegerField":"TLargeintField":g \
	  -e s:"    DesignActivation = .*":"":g \
	  -e s:"    AttachedAutoRefresh = .*":"":g \
	  -e s:"    AttachMaxCount = .*":"":g \
	  -e s:"    FieldDefs = <>":"":g \
	  -e s:"    IndexFieldNames = .*":"":g \
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
	  $$i.dfm > $$i.dfm.tmp && \
	  mv -f $$i.dfm.tmp $$i.dfm ; done

sq3tozeos:
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0) $(UNITS) $(ABOUT)) ; do \
	  sed \
	  -e s:"TSqlitePassDataset":"TZTable":g \
	  -e s:"TSqlitePassDatabase":"TZConnection":g \
	  -e s:"IndexedBy":"IndexFieldNames":g \
	  -e s:"DatasetName":"TableName":g \
	  -e s:"SqlitePassDbo":"ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset":g \
	  -e s:"TLargeintField":"TIntegerField":g $$i.pas > $$i.pas.tmp && \
	  mv -f $$i.pas.tmp $$i.pas ; done
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0)) ; do \
	  sed -e s:"TSqlitePassDataset":"TZTable":g \
	  -e s:"TSqlitePassDatabase":"TZConnection":g \
	  -e s:"TLargeintField":"TIntegerField":g \
	  -e s:"    CalcDisplayedRecordsOnly = .*"::g \
	  -e s:"    MasterSourceAutoActivate = .*"::g \
	  -e s:"    FilterMode = .*"::g \
	  -e s:"    FilterRecordLowerLimit = .*"::g \
	  -e s:"    FilterRecordUpperLimit = .*"::g \
	  -e s:"    Indexed = .*"::g \
	  -e s:"    LocateSmartRefresh = .*"::g \
	  -e s:"    LookUpCache = .*"::g \
	  -e s:"    LookUpDisplayedRecordsOnly = .*"::g \
	  -e s:"    LookUpSmartRefresh = .*"::g \
	  -e s:"    Sorted = .*"::g \
	  -e s:"    RecordsCacheCapacity = .*"::g \
	  -e s:"    DatabaseAutoActivate = .*"::g \
	  -e s:"    VersionInfo.Component = .*"::g \
	  -e s:"    VersionInfo.Package = .*"::g \
	  -e s:"    ParamCheck = .*"::g \
	  -e s:"    WriteMode = .*"::g \
	  -e s:"    pParams = .*"::g \
	  -e s:"    DatatypeOptions\..*"::g \
	  -e s:"IndexedBy":"IndexFieldNames":g \
	  $$i.dfm > $$i.dfm.tmp && \
	  mv -f $$i.dfm.tmp $$i.dfm ; done

dbutils: $(DBUTILS)

test:
	@echo BUILDDATETIME="$(BUILDDATETIME)"
