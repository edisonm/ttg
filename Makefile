INNOIDE="c:/archivos de programa/Inno Setup 5/ISCC.exe"
ISS=INSTALL/TTG.iss
INSTALLER=INSTALL/OUTPUT/TTGSETUP.exe
TTGEXE=BIN/TTG.exe
DBUTILS=BIN/DBUTILS.exe
DCC32="c:/archivos de programa/CodeGear/RAD Studio/5.0/bin/dcc32"
DCC32OPTS=-E'..\BIN' -U'..\..\kbmMemTable552\Source' -N0'..\OBJ'
TTGDPR=TTG.dpr
DBUTILSDPR=DBUTILS.dpr
TTGMDB='SOURCE\TTG.mdb'

all: $(INSTALLER)

dcchelp:
	$(DCC32)

INSTALL/OUTPUT/TTGSETUP.exe: $(ISS) $(TTGEXE)
	$(INNOIDE) $(ISS)

$(TTGEXE): SOURCE/$(TTGDPR) SOURCE/DSrcBase.pas
	cd SOURCE; $(DCC32) $(DCC32OPTS) $(TTGDPR)

$(DBUTILS): DBUTILS/$(DBUTILSDPR)
	cd DBUTILS; $(DCC32) $(DCC32OPTS) $(DBUTILSDPR)

SOURCE/DSrcBase.pas: $(DBUTILS) $(shell cygpath $(TTGMDB))
	$(DBUTILS) /ACC2DM $(TTGMDB) SourceBaseDataModule 'SOURCE\DSrcBase' /DS

clean:
	$(RM) $(INSTALLER) $(TTGEXE) $(DBUTILS) OBJ/* SOURCE/DSrcBase.{pas,dfm}
