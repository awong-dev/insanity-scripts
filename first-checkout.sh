#!/bin/bash

set +x

mkdir insanity
cd insanity
$(dirname $0)/make-build-env.sh

cd ndk
$(dirname $0)/make-toolchain.sh
$(dirname $0)/build-libcxx.sh

echo "***"
echo "*** Done setting up."
echo "***"
echo
echo "To run a tests, ensure android device is ready, cd to the appropriate directory and call:"
echo "  $(dirname $0)/run-tests.sh"
echo
echo "Example of running time.clock.system tests:"
echo "  cd insanity/ndk/sources/cxx-stl/llvm-libc++/libcxx/test/utilities/time/time.clock/time.clock.system"
echo "  $(dirname $0)/run-tests.sh"
echo
echo "Example of running all tests (likely takes 1-2 hours):"
echo "  cd insanity/ndk/sources/cxx-stl/llvm-libc++/libcxx/test"
echo "  $(dirname $0)/run-tests.sh"
echo
echo "To check if the android devices are ready:"
echo "  source $(dirname $0)/env.sh"
echo "  adb devices"
echo
echo "The list should not be empty."
echo
