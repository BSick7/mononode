#!/bin/bash

#return zero if all commands exit successfully
#otherwise will return the value of the last (rightmost) command to exit with a non-zero status
set -e
set -o pipefail

me=consul-bind

private_ip=$(/opt/bin/private-ip)

echo "[${me}] configuring consul with private_ip = ${private_ip}"
cat > /etc/consul/bind.json <<EOF
{
  "bind_addr": "${private_ip}"
}
EOF
