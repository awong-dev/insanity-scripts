#!/bin/bash
set -x

. "$(dirname $0)/env.sh"

# Grab the NDK source.
repo init -u https://github.com/awong-dev/ndk-manifest.git
repo sync

mkdir -p "$NDK_DOWNLOAD_DIR"
pushd ${NDK_DOWNLOAD_DIR} > /dev/null

# Download the adt.
ADT_BUNDLE="adt-bundle-linux-x86_64-20140321.zip"
if [ ! -f "${ADT_BUNDLE}" ]; then
  curl -o "${ADT_BUNDLE}" "http://dl.google.com/android/adt/22.6.2/${ADT_BUNDLE}"
  unzip -d "${ADT_BUNDLE}" adt-bundle-linux-x86_64
fi

# Download the release toolchains.
ANDROID_TOOLCHAIN_ROOT="android-ndk-r9d-linux"

X86_TARBZ="${ANDROID_TOOLCHAIN_ROOT}-x86.tar.bz2"
X86_64_TARBZ="${ANDROID_TOOLCHAIN_ROOT}-x86_64.tar.bz2"
if [ ! -f "${X86_TARBZ}" ]; then
  curl -o "${X86_TARBZ}" "http://dl.google.com/android/ndk/${X86_TARBZ}"
fi
if [ ! -f "${X86_64_TARBZ}" ]; then
  curl -o "${X86_64_TARBZ}" "http://dl.google.com/android/ndk/${X86_64_TARBZ}"
fi

# Grab depot tools.
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git depot_tools

popd > /dev/null

NDK=`pwd`/ndk
cd ndk
tar xjf "${NDK_DOWNLOAD_DIR}/${X86_TARBZ}" --strip 1
tar xjf "${NDK_DOWNLOAD_DIR}/${X86_64_TARBZ}" --strip 1
git stash  # The release toolchain overwrites some files from the ndk checkout.
