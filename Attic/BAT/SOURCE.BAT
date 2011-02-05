CD ..
del sghcsrc.tar.bz2
CD ..
CD ..
SGHC\1.1\BAT\TAR.EXE -cv -TSGHC\1.1\filelist.txt -fsghcsrc.tar
SGHC\1.1\BAT\BZIP2.EXE -9 --repetitive-best sghcsrc.tar
CD SGHC\1.1
MOVE ..\..\sghcsrc.tar.bz2 .
CD BAT
