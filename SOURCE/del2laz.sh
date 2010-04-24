#!/bin/sh
##
## del2laz.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Sun Mar  7 01:21:08 2010 Edison Mera
## Last update Sat Apr 24 16:02:05 2010 Edison Mera
##

find . -name "*.pas" -exec str_replace "TkbmMemTable"    "TDbf" {} \;
find . -name "*.dfm" -exec str_replace "TkbmMemTable"    "TDbf" {} \;
find . -name "*.pas" -exec str_replace "kbmMemTable"     "dbf" {} \;
find . -name "*.pas" -exec str_replace "TIntegerField"   "TLongIntField" {} \;
find . -name "*.pas" -exec str_replace "Windows,"        "{Windows,}" {} \;
