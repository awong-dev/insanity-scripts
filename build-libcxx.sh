#!/bin/bash

. $(dirname $0)/common.sh

if [ "${TOOLCHAIN}" = "g++" ]; then
  TOOLCHAIN_FLAG="--gcc-version=4.8"
elif [ "${TOOLCHAIN}" = "clang++" ]; then
  export LLVM_VERSION
  TOOLCHAIN_FLAG="--llvm-version=$LLVM_VERSION"
else
  echo "Unknown toolchain: $TOOLCHAIN"
  exit 1
fi

if [ -n "$VERBOSE" ]; then
  VERBOSE_FLAGS="--verbose --verbose --verbose"
else
  VERBOSE_FLAGS="--verbose"  # Show build progress.
fi

ndk build/tools/build-cxx-stl.sh --stl=libc++ --ndk-dir=$NDK --abis=${ABIS} ${VERBOSE_FLAGS} --build-dir=${BUILD_DIR} ${TOOLCHAIN_FLAG} -j$PARALLEL --with-debug-info
ndk build/tools/make-standalone-toolchain.sh --stl=libc++ --abis=${ABIS} --platform=android-${API_VERSION} ${TOOLCHAIN_FLAG} --install-dir=${INSTALL_DIR} --arch=arm --toolchain=arm-linux-androideabi-4.8
