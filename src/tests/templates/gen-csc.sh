#!/bin/bash

PWD=`pwd`


FIRMWARE="$PWD/$1"
JS_FILE="$PWD/$2"
TARGET=$3

TEMPLATE="$VLROOT/src/tests/templates/$TARGET-test-template.csc"
TESTDIR="$VLROOT/src/tests/testcases"

A="`echo | tr '\012' '\001' `"

if [ $3 = micaz ]; then
    FIRMWARE="$FIRMWARE.elf"
    cp -f $1 $1.elf
fi

sed  "s$A<firmware></firmware>$A<firmware>$FIRMWARE</firmware>$A" $TEMPLATE >$TESTDIR/$1.csc.tmp
[ $? -eq 0 ] || exit 1

sed "/<script>/r $JS_FILE" $TESTDIR/$1.csc.tmp > $TESTDIR/$1.csc
[ $? -eq 0 ] || exit 1

rm -f $TESTDIR/$1.csc.tmp 

echo "$TESTDIR/$1.csc is generated."
echo
echo "You can run your test by issuing:"
echo "$VLROOT/src/tests/RUN_TEST $TESTDIR/$1.csc"
