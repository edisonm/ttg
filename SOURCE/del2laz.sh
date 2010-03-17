#!/bin/sh
##
## del2laz.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Sun Mar  7 01:21:08 2010 Edison Mera
## Last update Sun Mar  7 01:35:48 2010 Edison Mera
##

find . -name "*.pas" -exec str_replace "TkbmMemTable" "TMemDataset" {} \;
find . -name "*.dfm" -exec str_replace "TkbmMemTable" "TMemDataset" {} \;
find . -name "*.pas" -exec str_replace "TRxDrawGrid" "TDrawGrid" {} \;
find . -name "*.dfm" -exec str_replace "TRxDrawGrid" "TDrawGrid" {} \;
