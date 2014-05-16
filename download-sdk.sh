#!/bin/bash

set -x

# Disable some sanity checks to bootstrap the first checkout.
BOOTSTRAP_CHECKOUT=1

. "$(dirname $0)/env.sh"

mkdir -p "$NDK_DOWNLOAD_DIR"
cd ${NDK_DOWNLOAD_DIR}

# Download the adt.
ADT_BUNDLE="adt-bundle-linux-x86_64-20140321"
if [ ! -f "${ADT_BUNDLE}.zip" ]; then
  curl -o "${ADT_BUNDLE}.zip" "http://dl.google.com/android/adt/22.6.2/${ADT_BUNDLE}.zip"
fi
if [ ! -d "adt-bundle-linux-x86_64" ]; then
  unzip "${ADT_BUNDLE}"
  mv ${ADT_BUNDLE} adt-bundle-linux-x86_64
fi

# Download the release toolchains.
if [ ! -f "${ANDROID_TOOLCHAIN_X86_TARBZ}" ]; then
  curl -o "${ANDROID_TOOLCHAIN_X86_TARBZ}" \
      "http://dl.google.com/android/ndk/${ANDROID_TOOLCHAIN_X86_TARBZ}"
fi
if [ ! -f "${ANDROID_TOOLCHAIN_X86_64_TARBZ}" ]; then
  curl -o "${ANDROID_TOOLCHAIN_X86_64_TARBZ}" \
      "http://dl.google.com/android/ndk/${ANDROID_TOOLCHAIN_X86_64_TARBZ}"
fi

# Grab depot tools.
if [ ! -d depot_tools ]; then
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git depot_tools
fi
