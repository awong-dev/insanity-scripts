#!/bin/bash

if [ ! -z "$PS1" ]; then
  echo "Don't source env.sh."
  echo "Call $(dirname $0)/insanity-shell.sh from your ndk checkout instead."
  return
fi

SCRIPT_DIR=$(realpath ${BASH_SOURCE%/*})
. "${SCRIPT_DIR}/common.sh"

PATH="${SCRIPT_DIR}:${NDK_DOWNLOAD_DIR}/depot_tools:${NDK_DOWNLOAD_DIR}/adt-bundle-linux-x86_64/sdk/platform-tools:$PATH"
unset SCRIPT_DIR
