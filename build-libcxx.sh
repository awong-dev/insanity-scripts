#!/bin/bash

. $(dirname $0)/common.sh

if [ ${TOOLCHAIN} = "g++" ]; then
  TOOLCHAIN_FLAG="--gcc-version=4.8"
else
  TOOLCHAIN_FLAG="--llvm-version=$LLVM_VERSION"
fi

ndk build/tools/build-cxx-stl.sh --stl=libc++ --ndk-dir=$NDK --abis=${ABIS} --verbose --verbose --verbose --build-dir=${BUILD_DIR} ${TOOLCHAIN_FLAG} -j$PARALLEL
ndk build/tools/make-standalone-toolchain.sh --stl=libc++ --abis=${ABIS} --platform=android-${API_VERSION} ${TOOLCHAIN_FLAG} --install-dir=${INSTALL_DIR} --arch=arm --toolchain=arm-linux-androideabi-4.8
