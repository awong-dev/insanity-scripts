#!/bin/bash
set -x

# Disable some sanity checks to bootstrap the first checkout.
BOOTSTRAP_CHECKOUT=1

. "$(dirname $0)/env.sh"

# Grab the NDK source.
repo init -u https://github.com/awong-dev/ndk-manifest.git
repo sync

# Expand release toolchains on top of everything.
NDK=`pwd`/ndk
cd ndk
SOURCE_PATHS="\
    '${ANDROID_TOOLCHAIN_ROOT}/platforms/' \
    '${ANDROID_TOOLCHAIN_ROOT}/toolchains/' \
    '${ANDROID_TOOLCHAIN_ROOT}/prebuilt/' \
    '${ANDROID_TOOLCHAIN_ROOT}/sources/' \
"

tar xjf "${NDK_DOWNLOAD_DIR}/${ANDROID_TOOLCHAIN_X86_TARBZ}" --strip 1 ${SOURCE_PATHS}
tar xjf "${NDK_DOWNLOAD_DIR}/${ANDROID_TOOLCHAIN_X86_64_TARBZ}" --strip 1 ${SOURCE_PATHS}

git stash  # The release toolchain overwrites some files from the ndk checkout.
