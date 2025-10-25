#!/bin/sh

set -e
# shellcheck disable=SC2016,SC1004
sed -i '/kill ".*"/a \
        wait "$XVFBPID" >&3 2>&3
' /usr/bin/xvfb-run
rm "$0"

