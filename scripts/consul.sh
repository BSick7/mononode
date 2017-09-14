#!/bin/bash

set -e
set -o pipefail

me=consul

echo "[${me}]: downloading consul"
curl -sSL -o /tmp/consul.zip "${CONSUL_BINARY_URL}"

echo "[$me]: extracting consul"
unzip /tmp/consul.zip -d /opt/bin

echo "[${me}]: installing consul binaries"
chmod 755 /opt/bin/consul
chmod 755 /opt/consul/bind.sh
chmod 755 /opt/consul/data-dir.sh
chmod 755 /opt/consul/online.sh

echo "[${me}]: preparing consul data directory"
mkdir -p /var/lib/consul/
chown consul:consul /var/lib/consul
chmod 700 /var/lib/consul

echo "[${me}]: granting consul permissions to bind to privileged ports"
setcap 'cap_net_bind_service=+ep' /opt/bin/consul
