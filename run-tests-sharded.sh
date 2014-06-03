#!/bin/bash
SCRIPT_DIR="$(dirname $0)"
. "$SCRIPT_DIR/env.sh"

export SHARD_TEST_TOOLCHAIN=${TOOLCHAIN}

for i in *; do
  if [ -d "$i" ]; then
    cd $i
    run-tests.sh "$@" &
    cd ..
  fi
done
wait
