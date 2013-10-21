#!/bin/sh
if [ -z $1 ]; then
    TARGET='ekileugor'
else
    TARGET=$1
fi
mkdir -p bin
yucca -R -x src/$TARGET.bas > src/$TARGET.yucca.bas || exit $?
# $1001 is the BASIC memory start address on the unexpanded VIC-20
petcat -l 1001 -w2 -o bin/$TARGET.prg -- src/$TARGET.yucca.bas || exit $?
rm -f src/$TARGET.yucca.bas
ls -la bin/$TARGET.prg
