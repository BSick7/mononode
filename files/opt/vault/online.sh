#!/bin/bash

# Usage: ./online.sh <timeout-secs>
# Example: ./online.sh 120

set -e

me=vault-online

max_duration="$1"

start=$(/bin/date '+%s')
end=$((start + max_duration))

while /bin/true; do
    set +e
    /opt/bin/vault init -check > /dev/null
    status="$?"
    set -e

    if [[ "${status}" != "1" ]]; then
        echo "[${me}]: vault online"
        exit 0
    fi

    if [[ $(/bin/date '+%s') -gt ${end} ]]
    then
        echo "[${me}]: vault is not responding"
        exit 1
    fi

    /bin/sleep 10
done