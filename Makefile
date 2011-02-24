# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux.

include SETTINGS

INNOIDE="c:/archivos de programa/Inno Setup 5/ISCC.exe"
TTGDIR:=$(shell pwd)
ISS=$(TTGDIR)/src/iss/ttg.iss
INSTALLER=$(TTGDIR)/bin/ttgsetup.exe
TTGEXE=$(TTGDIR)/bin/ttg.exe
DBUTILS=$(TTGDIR)/bin/dbutils.exe
DCC32="c:/archivos de programa/Embarcadero/RAD Studio/7.0/bin/dcc32"
# DCC32="c:/archivos de programa/CodeGear/RAD Studio/5.0/bin/dcc32"
DCC32OPTS= \
	-E'$(shell cygpath -w $(TTGDIR)/bin)' \
	-U'$(shell cygpath -w $(TTGDIR)/../ZEOSDBO-7.0.0-alpha/src/component)' \
	-U'$(shell cygpath -w $(TTGDIR)/../ZEOSDBO-7.0.0-alpha/src/dbc)' \
	-U'$(shell cygpath -w $(TTGDIR)/../ZEOSDBO-7.0.0-alpha/src/core)' \
	-U'$(shell cygpath -w $(TTGDIR)/../ZEOSDBO-7.0.0-alpha/src/parsesql)' \
	-U'$(shell cygpath -w $(TTGDIR)/../ZEOSDBO-7.0.0-alpha/src/plain)' \
	-N0'$(shell cygpath -w $(TTGDIR)/obj)'
TTGDPR=ttg.dpr
DBUTILSDPR=dbutils.dpr
TTGMDB=dat/ttg.mdb
TTGSQL=dat/ttg.sql
TTGSQLITE3=dat/ttg.s3fpc

DBUNITS=Ac2DMUtl Ac2PxUtl Acc2DM Acc2Pdx Acc2SQL AccUtl DBPack PdxUtils

APPVERSION=1.2.2
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

src/del/$(ABOUT).pas: src/del/$(ABOUT).pas.tmpl
	sed -e s:'<v>AppVersion</v>':'$(APPVERSION)':g \
	  -e s:'<v>BuildDateTime</v>':"$(BUILDDATETIME)":g \
	  -e s:'<v>AppName</v>':'$(APPNAME)':g $< > $@

$(TTGEXE): src/del/$(TTGDPR) $(addprefix src/del/, $(addsuffix .pas, $(UNITS) $(FORMS) $(DSRCBASE) $(ABOUT)))
	cd src/del ; $(DCC32) $(DCC32OPTS) $(TTGDPR)

$(DBUTILS): src/dbutils/$(DBUTILSDPR) $(addprefix src/dbutils/, $(addsuffix .pas, $(DBUNITS)))
	cd src/dbutils; $(DCC32) $(DCC32OPTS) $(DBUTILSDPR)

src/del/$(DSRCBASE).pas: $(DBUTILS) $(TTGMDB) Makefile
	cd src/del ; $(DBUTILS) /ACC2DM ../../$(TTGMDB) SourceBaseDataModule \
	  $(DSRCBASE) 'cds;csr;U=ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset;DS=ZTable'

#src/$(DSRCBASE).pp: $(DBUTILS) $(TTGMDB) Makefile
#	cd src/laz ; $(DBUTILS) /ACC2DM ../../$(TTGMDB) SourceBaseDataModule \
#	  $(DSRCBASE) 'cds;csr;lfm;U=ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset;DS=ZTable'

$(TTGSQL): $(DBUTILS) $(TTGMDB)
	$(DBUTILS) /ACC2SQL $(TTGMDB) $@

$(TTGSQLITE3): $(TTGSQL) Makefile
	$(RM) $@
	sqlite3 $@ "pragma journal_mode=off;pragma foreign_keys=true"
	sqlite3 $@ ".read $(TTGSQL)"

clean:
	$(RM) $(INSTALLER) $(TTGEXE) $(DBUTILS) $(TTGSQL) \
	  $(TTGSQLITE3) obj/* \
	  bin/*.o \
	  bin/*.ppu \
	  src/del/$(DSRCBASE0).pas src/del/$(DSRCBASE0).dfm \
	  src/laz/$(DSRCBASE0).pp  src/laz/$(DSRCBASE0).lfm \
	  $(ISS) $(ABOUTPAS) src/del/*.identcache src/dbutils/*.identcache
	$(RM) -r src/del/__history src/dbutils/__history

kbmtosq3:
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0) $(UNITS)) ; do \
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
	for i in $(addprefix src/, $(FORMS) $(DSRCBASE0) $(UNITS)) ; do \
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

test:
	@echo TTGDIR=$(TTGDIR)
	@echo FILES=$(addprefix src/del/, $(addsuffix .pas, $(UNITS) $(FORMS) $(DSRCBASE)))
