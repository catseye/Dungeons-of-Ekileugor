#!/bin/sh
if [ -z $1 ]; then
    TARGET='ekileugor'
else
    TARGET=$1
fi
./make.sh $TARGET || exit $?
xvic bin/$TARGET.prg
