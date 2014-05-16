#!/bin/bash

# Don't mess up the shell if this is interactive.
if [ -z "$PS1" ]; then
  if [ ! -z "$INSANITY_VERBOSE" ]; then
    set -x
  fi
  set -e
fi

NDK=${PWD/ndk\/*/ndk}
: ${LLVM_VERSION:=3.4}
: ${PARALLEL:=$(nproc)}
: ${API_VERSION:=9}
: ${TOOLCHAIN:=clang++}
: ${BUILD_DIR:="/tmp/ndk-libcxx-${TOOLCHAIN}"}
: ${INSTALL_DIR:="/tmp/ndk-api${API_VERSION}-arm-${TOOLCHAIN}"}
: ${SRC_DIR:="/tmp/ndk-${USER}"}
: ${NDK_DOWNLOAD_DIR:="/tmp/ndk-${USER}-download"}

ANDROID_TOOLCHAIN_ROOT="android-ndk-r${API_VERSION}d"
ANDROID_TOOLCHAIN_X86_TARBZ="${ANDROID_TOOLCHAIN_ROOT}-linux-x86.tar.bz2"
ANDROID_TOOLCHAIN_X86_64_TARBZ="${ANDROID_TOOLCHAIN_ROOT}-linux-x86_64.tar.bz2"

# Turn off some functionality if bootstraping for first checkout.
if [ -z "$BOOTSTRAP_CHECKOUT" ]; then
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
fi
