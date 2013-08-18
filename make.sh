#!/bin/sh
# usage: ./make.sh ekileugor [test]
mkdir -p bin
yucca -R -x src/$1.bas > src/$1.yucca.bas || exit $?
petcat -w2 -o bin/$1.prg -- src/$1.yucca.bas || exit $?
rm -f src/$1.yucca.bas
ls -la bin/$1.prg
if [ "x$2" = "xtest" ]; then
  xvic bin/$1.prg
fi
