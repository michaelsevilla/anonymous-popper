#! /bin/bash

set -ex

OTHERHOST="issdm-0"

mkdir results
dd if=/dev/zero of=dummy10k.bin bs=23247507 count=1
dd if=/dev/zero of=dummy100k.bin bs=232497507 count=1

/usr/bin/time --format="%e" scp dummy10k.bin $OTHERHOST:/tmp/blah > results/dummy10k.txt 2>&1
/usr/bin/time --format="%e" scp dummy100k.bin $OTHERHOST:/tmp/blah > results/dummy100k.txt 2>&1
