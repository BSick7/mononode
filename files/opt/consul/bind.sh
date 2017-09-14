#!/bin/bash

#return zero if all commands exit successfully
#otherwise will return the value of the last (rightmost) command to exit with a non-zero status
set -e
set -o pipefail

me=consul-bind

private_ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

echo "[${me}] Configuring consul agent with private_ip = ${private_ip}"
cat <<EOF > /etc/consul/bind.json
{
  "bind_addr": "${private_ip}"
}
EOF
