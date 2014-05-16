#!/bin/bash

. $(dirname $0)/common.sh

if [ ${TOOLCHAIN} = "g++" ]; then
  TOOLCHAIN_FLAG="--llvm-version=$LLVM_VERSION"
else
  TOOLCHAIN_FLAG="--gcc-version=4.8"
fi

ndk build/tools/build-cxx-stl.sh --stl=libc++ --ndk-dir=$NDK --abis=armeabi-v7a --verbose --verbose --verbose --build-dir=${BUILD_DIR} ${TOOLCHAIN_FLAG} -j$PARALLEL
ndk build/tools/make-standalone-toolchain.sh --platform=android-${API_VERSION} --llvm-version=$LLVM_VERSION --install-dir=${INSTALL_DIR} --arch=arm --toolchain=arm-linux-androideabi-4.8
