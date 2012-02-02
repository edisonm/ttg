#!/bin/bash

set -e

if [ $# != 2 ] ; then
    echo "ERROR: Invalid number of arguments"
    echo "  Usage:"
    echo "  $0 SearchBy ReplaceWith"
    exit 1
fi

SEARCH_UC="`echo $1|tr '[a-z]' '[A-Z]'`"
REPLACE_UC="`echo $2|tr '[a-z]' '[A-Z]'`"

find . \( -name "*.pp" -o -name "*.lfm" -o -name "*.ttd" -o -name "*.pas" -o -name "*.lpr" \) -exec str_replace $1 $2 {} \;
find . \( -name "*.po" -o -name "*.lrt" \) -exec str_replace $SEARCH_UC $REPLACE_UC {} \;
