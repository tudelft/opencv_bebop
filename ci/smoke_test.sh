#!/bin/sh
# Usage: ci/smoke_test.sh <pc|arm>
# Builds ci/smoke_test.cpp against install_<target> with the LDFLAGS of
# install_<target>/opencv.xml (as a paparazzi module uses them) and runs it
# (arm under qemu).
set -e
TARGET=$1
cd "$(dirname "$0")/.."
INSTALL=$PWD/install_$TARGET
test -s "$INSTALL/opencv.xml" || { echo "missing or empty $INSTALL/opencv.xml"; exit 1; }
cat "$INSTALL/opencv.xml"
LDFLAGS=$(sed -n 's/.*name="LDFLAGS" value="\([^"]*\)".*/-\1/p' "$INSTALL/opencv.xml" \
  | sed "s|\$(PAPARAZZI_HOME)/sw/ext/opencv_bebop|$PWD|" | tr '\n' ' ')
if [ "$TARGET" = arm ]; then
  CXX=arm-linux-gnueabi-g++
else
  CXX=g++
fi
$CXX -o smoke_test_$TARGET ci/smoke_test.cpp -I"$INSTALL/include/opencv4" $LDFLAGS
if [ "$TARGET" = arm ]; then
  qemu-arm -L /usr/arm-linux-gnueabi ./smoke_test_$TARGET
else
  ./smoke_test_$TARGET
fi
