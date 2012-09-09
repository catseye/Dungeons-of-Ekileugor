#!/bin/sh
# usage: [MINI=yes] ./make.sh [test]
mkdir -p bin
FULL='-DFULL'
if [ "x$MINI" != "x" ]; then
  FULL=''
fi
cpp -P $FULL src/ekileugor.bas >src/ekileugor.cpp.bas 2>/dev/null || exit $?
yucca -R -x src/ekileugor.cpp.bas > src/ekileugor.yucca.bas || exit $?
petcat -w2 -o bin/ekileugor.prg -- src/ekileugor.yucca.bas || exit $?
rm -f src/ekileugor.cpp.bas src/ekileugor.yucca.bas
ls -la bin/ekileugor.prg
if [ "x$1" = "xtest" ]; then
  xvic bin/ekileugor.prg
fi

