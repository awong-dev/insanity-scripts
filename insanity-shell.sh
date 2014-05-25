#!/bin/bash -i

# Just setups up the environment.
OLD_PS1="$PS1"
unset PS1  # Bypass env.sh's guard against sourcing to interactive shell.
source $(dirname $0)/env.sh

# Don't use the default.
if [[ "${OLD_PS1}" =~ '\s-\v' ]]; then
  OLD_PS1="\h:\W \u\$ "
fi

exec env PS1="[!sane $TOOLCHAIN] $OLD_PS1" bash --norc -i
