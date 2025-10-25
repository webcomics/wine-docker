#!/bin/sh
update="$1"
set -eu

cd "$(dirname "$0")" || exit 1

if [ "$update" = "-u" ]
then
  echo > wine-dependencies.txt
fi

for flavour in stable devel staging
do
    podman build --build-arg WINE_FLAVOUR=$flavour -t wine:$flavour .
    podman run --rm wine:$flavour awk -F': ' \
        '$1 == "Install" { last=$2 } END { print last }' /var/log/apt/history.log | \
        sed 's/ ([^)]*)//g; s/, /\n/g' | sort -u > dependencies-${flavour}.log
done

if [ "$update" = "-u" ]
then
    cat dependencies-*.log | sort | uniq -c | sed -n -e 's/^ *[23] \(.*\)/\1/p' > wine-dependencies.txt
fi
