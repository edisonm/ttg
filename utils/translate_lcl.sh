#!/bin/bash

find . -name "*.po"  -exec str_replace "msgid \"$1\"" "msgid \"$2\"" {} \;
find . -name "*.lrt" -exec str_replace "=$1\$" "=$2" {} \;
find . -name "*.lfm" -exec str_replace "= '$1'" "= '$2'" {} \;
find . -name "*.pas"  -exec str_replace "= '$1'" "= '$2'" {} \;
