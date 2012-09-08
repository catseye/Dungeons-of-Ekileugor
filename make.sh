#!/bin/sh
mkdir -p bin
yucca -R src/ekileugor.bas > src/ekileugor.tmp.bas || exit $?
petcat -w2 -o bin/ekileugor.prg -- src/ekileugor.tmp.bas || exit $?
rm -f src/ekileugor.tmp.bas
ls -la bin/ekileugor.prg
if [ "x$1" = "xtest" ]; then
  xvic bin/ekileugor.prg
fi

