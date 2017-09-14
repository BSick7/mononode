#!/bin/bash

set -e
set -o pipefail

me=vault

echo "[${me}]: downloading vault"
curl -sSL -o /tmp/vault.zip "${VAULT_BINARY_URL}"

echo "[${me}]: extracting vault"
unzip -o /tmp/vault.zip -d /opt/bin/

echo "[${me}]: installing vault binaries"
chmod 755 /opt/bin/vault

echo "[${me}] enabling vault bind"
chmod 755 /opt/vault/bind.sh
chmod 755 /opt/vault/online.sh
chmod 755 /opt/vault/init.sh
chmod 755 /opt/vault/unseal.sh
