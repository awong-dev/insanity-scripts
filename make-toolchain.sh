#!/bin/bash

. $(dirname $0)/common.sh

ndk build/tools/download-toolchain-sources.sh ${SRC_DIR}/src
ndk build/tools/build-compiler-rt.sh -j$PARALLEL --ndk-dir=$NDK --abis=armeabi,armeabi-v7a,x86,mips --src-dir=${SRC_DIR}/src/llvm-$LLVM_VERSION/compiler-rt --llvm-version=$LLVM_VERSION
