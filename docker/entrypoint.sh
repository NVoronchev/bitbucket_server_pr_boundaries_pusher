#!/bin/bash

set -e

# Find non-root owner of the directory ${SRC_MOUNT}
read uid gid <<< "$(find "${SRC_MOUNT}" -maxdepth 0 -type d -printf '%U %G\n')"

[ -n "$uid" -o -n "$gid" ] || {
    echo "Can't determine ${SRC_MOUNT} owner";
    exit 1
}

exec gosu $uid:$gid "$@"
