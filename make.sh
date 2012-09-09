#!/bin/sh
# usage: ./make.sh [test]
mkdir -p bin
yucca -R -x src/ekileugor.bas > src/ekileugor.yucca.bas || exit $?
petcat -w2 -o bin/ekileugor.prg -- src/ekileugor.yucca.bas || exit $?
rm -f src/ekileugor.cpp.bas src/ekileugor.yucca.bas
ls -la bin/ekileugor.prg
if [ "x$1" = "xtest" ]; then
  xvic bin/ekileugor.prg
fi

