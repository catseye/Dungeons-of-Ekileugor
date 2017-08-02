#!/bin/sh
if [ -z $1 ]; then
    TARGET='ekileugor'
else
    TARGET=$1
fi

# $1001 is the BASIC memory start address on the unexpanded VIC-20
tokenize() {
  if which hatoucan >/dev/null; then
    hatoucan -l 1001 <$1 >$2
  elif which petcat >/dev/null; then
    petcat -l 1001 -w2 -o $2 -- $1
  else
    echo 'ERROR: no suitable Commodore BASIC 2.0 tokenizer found (install hatoucan or petcat)'
    exit 1
  fi
}

mkdir -p bin

if which yucca >/dev/null; then
  yucca -R -x src/$TARGET.bas > src/$TARGET.yucca.bas || exit $?
else
  cat src/ekileugor.bas | grep -v '^rem' | grep -v '^$' > src/$TARGET.yucca.bas
fi

tokenize src/$TARGET.yucca.bas bin/$TARGET.prg || exit $?

rm -f src/$TARGET.yucca.bas
ls -la bin/$TARGET.prg
