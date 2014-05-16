#!/bin/bash

. $(dirname $0)/common.sh

if [ ! -z "$PS1" ]; then
  PS1="[!sane] $PS1"
fi
PATH="/tmp/ndk-insanity-scripts:${NDK_DOWNLOAD_DIR}/depot_tools:${NDK_DOWNLOAD_DIR}/adt-bundle-linux-x86_64/sdk/platform-tools:$PATH"
