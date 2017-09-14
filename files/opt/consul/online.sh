#!/bin/bash

# Usage: ./online.sh <timeout-secs> <resolve-address>
# Example: ./online.sh 120 vault

set -e

me=consul-dns

max_duration=$1
resolve_addr=$2

private_ip=$(/opt/bin/private-ip)
start=$(/bin/date '+%s')
end=$((start + max_duration))

while /bin/true; do
  set +e
  is_unknown=$(/bin/nslookup "${resolve_addr}" "${private_ip}" | /bin/grep -c NXDOMAIN)
  set -e

  if [[ "$is_unknown" == "0" ]]
  then
    echo "[${me}]: resolved ${resolve_addr}"
    exit 0
  fi

  if [[ $(/bin/date '+%s') -gt ${end} ]]
  then
    echo "[${me}]: could not resolve ${resolve_addr} in ${max_duration} seconds"
    exit 1
  fi
done
