#!/bin/sh

set -e
# shellcheck disable=SC2016,SC1004
sed -i '/kill ".*"/a \
        wait "$XVFBPID" >>"$ERRORFILE" 2>&1
' /usr/bin/xvfb-run
rm "$0"

