#!/bin/sh
##
## del2laz.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Sun Mar  7 01:21:08 2010 Edison Mera
## Last update Fri Apr 23 23:26:15 2010 Edison Mera
##

find . -name "*.pas" -exec str_replace "TkbmMemTable"    "TMemDataset" {} \;
find . -name "*.dfm" -exec str_replace "TkbmMemTable"    "TMemDataset" {} \;
find . -name "*.pas" -exec str_replace "kbmMemTable"           "memds" {} \;
find . -name "*.pas" -exec str_replace "AttachedAutoRefresh = True" "" {} \;
find . -name "*.pas" -exec str_replace "AutoIncMinValue = -1"       "" {} \;



