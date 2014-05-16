#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
. "$SCRIPT_DIR/env.sh"

TESTIT_DIR=${PWD/test\/*/test}

PATH="${INSTALL_DIR}/bin:${PATH}" "${TESTIT_DIR}/testit_android" --abi=armeabi-v7a --verbose --verbose --verbose --cxx=arm-linux-androideabi-${TOOLCHAIN}
