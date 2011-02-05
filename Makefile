# GuideLine: Prefer definition of posix directories, because we are
# migrating this system to Linux

INNOIDE="c:/archivos de programa/Inno Setup 5/ISCC.exe"
TTGDIR:=$(shell pwd)
ISS=$(TTGDIR)/INSTALL/TTG.iss
INSTALLER=$(TTGDIR)/INSTALL/OUTPUT/TTGSETUP.exe
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

all: $(INSTALLER) $(TTGSQLITE3)

dcchelp:
	$(DCC32)

$(INSTALLER): $(ISS) $(TTGEXE)
	$(INNOIDE) '$(shell cygpath -w $(ISS))'

$(TTGEXE): src/$(TTGDPR) $(DSRCBASE).pas
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
	$(RM) $(INSTALLER) $(TTGEXE) $(DBUTILS) $(TTGSQL) $(TTGSQLITE3) obj/* src/DSrcBase.{pas,dfm}

test:
	@echo TTGDIR=$(TTGDIR)
