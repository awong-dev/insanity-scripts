#!/bin/bash

set -x
set -e

NDK=${PWD/ndk\/*/ndk}
: ${LLVM_VERSION:=3.4}
: ${PARALLEL:=$(nproc)}
: ${API_VERSION:=9}
: ${TOOLCHAIN:=clang++}
: ${BUILD_DIR:="/tmp/ndk-libcxx-${TOOLCHAIN}"}
: ${INSTALL_DIR:="/tmp/ndk-api${API_VERSION}-arm-${TOOLCHAIN}"}
: ${SRC_DIR:="/tmp/ndk-${USER}-${TOOLCHAIN}"}
: ${NDK_DOWNLOAD_DIR:="/tmp/ndk-${USER}-release"}

if [[ ! "${NDK}" =~ '/ndk' ]]; then
  echo "Must be somewhere under your /ndk directory"
  exit 1
fi

function ndk {
        if [ -z $1 ]; then
                cd ${NDK}
        else
                pushd ${NDK}
                eval $*
                popd
        fi
}
