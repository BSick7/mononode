#!/bin/bash

#return zero if all commands exit successfully
#otherwise will return the value of the last (rightmost) command to exit with a non-zero status
set -e
set -o pipefail

me=vault-bind

private_ip=$(/opt/bin/private-ip)

echo "[${me}] configuring vault to use consul with private_ip = ${private_ip}"
cat > /etc/vault/consul.hcl <<EOF
backend "consul" {
  path = "vault"
  address = "${private_ip}:8500"
}
EOF
