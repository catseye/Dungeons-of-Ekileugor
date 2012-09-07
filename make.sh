#!/bin/sh
mkdir -p bin
yucca -R src/ekileugor.bas > src/ekileugor.tmp.bas
petcat -w2 -o bin/ekileugor.prg -- src/ekileugor.tmp.bas
rm -f src/ekileugor.tmp.bas
xvic bin/ekileugor.prg
