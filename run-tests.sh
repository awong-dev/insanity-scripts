#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
. "$SCRIPT_DIR/env.sh"

TESTIT_DIR=${PWD/test\/*/test}

EXTRA_FLAGS=--with-compiler-rt

if [ -n "$VERBOSE" ]; then
  VERBOSE_FLAGS="--verbose --verbose --verbose"
fi

ABI=armeabi-v7a
if [ "$1" == "--hard" ]; then
  ABI=armeabi-v7a-hard
  shift
fi

PATH="${INSTALL_DIR}/bin:${PATH}" "${TESTIT_DIR}/testit_android" --abi=${ABI} ${VERBOSE_FLAGS} --cxx=arm-linux-androideabi-${TOOLCHAIN} ${EXTRA_FLAGS} "$@"
