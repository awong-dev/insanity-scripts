#!/bin/bash

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

SCRIPT_DIR=$(realpath $(dirname $0))
BOOTSTRAP_CHECKOUT=1
. "${SCRIPT_DIR}/common.sh"
unset BOOTSTRAP_CHECKOUT

mkdir -p insanity
cd insanity
echo "---===--- Downloading SDK ..."
${SCRIPT_DIR}/download-sdk.sh
echo "---===--- Creating the build environment ..."
${SCRIPT_DIR}/make-build-env.sh

BOOTSTRAP_CHECKOUT=0

cd ndk
echo "---===--- Making toolchain ..."
${SCRIPT_DIR}/make-toolchain.sh
echo "---===--- Building libcxx ..."
${SCRIPT_DIR}/build-libcxx.sh

echo "***"
echo "*** Done setting up."
echo "***"
echo
echo "To run a tests, ensure android device is ready, cd to the appropriate directory and call:"
echo "  ${SCRIPT_DIR}/run-tests.sh"
echo
echo "Example of running time.clock.system tests:"
echo "  cd insanity/ndk/sources/cxx-stl/llvm-libc++/libcxx/test/utilities/time/time.clock/time.clock.system"
echo "  ${SCRIPT_DIR}/run-tests.sh"
echo
echo "Example of running all tests (likely takes 1-2 hours):"
echo "  cd insanity/ndk/sources/cxx-stl/llvm-libc++/libcxx/test"
echo "  ${SCRIPT_DIR}/run-tests.sh"
echo
echo "To check if the android devices are ready:"
echo "  source ${SCRIPT_DIR}/env.sh"
echo "  adb devices"
echo
echo "The list should not be empty."
echo
