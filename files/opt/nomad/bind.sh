#!/bin/bash

set -e
set -o pipefail

me=nomad-bind

echo "[${me}] configuring nomad agent with private_ip = ${COREOS_PRIVATE_IPV4}"
cat > /etc/nomad/bind.hcl <<EOF
bind_addr = "${COREOS_PRIVATE_IPV4}"
EOF

echo "[${me}] configuring nomad agent with consul address"
cat <<EOF > /etc/nomad/consul.hcl
consul {
  address = "${COREOS_PRIVATE_IPV4}:8500"
}
EOF

echo "[${me}] configuring vault agent with vault address"
cat <<EOF > /etc/nomad/vault-addr.hcl
vault {
  address = "${VAULT_ADDR}"
}
EOF
