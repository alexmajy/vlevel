#!/bin/bash

PWD=`pwd`
TARGET=''
BASENAME=''


if [ $1 != micaz -a $1 != sky ];then
    echo "$1 is not supported yet!"
    exit 1
else
    TARGET=$1
fi

BASENAME=`/bin/ls -1 *.$TARGET`

if [ -z $BASENAME ]; then
    echo 
    echo "Missing firmware! Try to run 'make all' first."
    exit 1
else
    BASENAME=`echo $BASENAME | sed "s/\.$TARGET//"`
    if [ ! -f "$BASENAME.js" ]; then
        echo "Missing .js test script!"
        exit 1
    fi
fi

JS_FILE="$PWD/$BASENAME.js"
FIRMWARE="$PWD/$BASENAME.$TARGET"

if [ $TARGET = micaz ]; then
    cp -f $FIRMWARE $FIRMWARE.elf
    FIRMWARE="$FIRMWARE.elf"
fi

echo "#######################################################################"
echo "Creating cooja test configuration $BASENAME.$TARGET.csc file from:"
echo "$BASENAME.$TARGET $BASENAME.js"


TEMPLATE="$VLROOT/src/tests/templates/$TARGET-test-template.csc"
TESTDIR="$VLROOT/src/tests/testcases"
A="`echo | tr '\012' '\001' `"


sed  "s$A<firmware></firmware>$A<firmware>$FIRMWARE</firmware>$A" $TEMPLATE >$TESTDIR/$BASENAME.$TARGET.csc.tmp
[ $? -eq 0 ] || exit 1

sed "/<script>/r $JS_FILE" $TESTDIR/$BASENAME.$TARGET.csc.tmp > $TESTDIR/$BASENAME.$TARGET.csc
[ $? -eq 0 ] || exit 1

rm -f $TESTDIR/$BASENAME.$TARGET.csc.tmp 

echo 
echo "$TESTDIR/$BASENAME.$TARGET.csc is generated."
echo
echo "You can run your test by issuing:"
echo "$VLROOT/src/tests/RUN_TEST $TESTDIR/$BASENAME.$TARGET.csc"
