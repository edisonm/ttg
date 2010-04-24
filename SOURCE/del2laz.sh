#!/bin/sh
##
## del2laz.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Sun Mar  7 01:21:08 2010 Edison Mera
## Last update Sat Apr 24 15:31:05 2010 Edison Mera
##

find . -name "*.pas" -exec str_replace "TkbmMemTable"    "TMemDataset" {} \;
find . -name "*.dfm" -exec str_replace "TkbmMemTable"    "TMemDataset" {} \;
find . -name "*.pas" -exec str_replace "kbmMemTable"           "memds" {} \;



