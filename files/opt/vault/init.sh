#!/bin/bash

me=init

export VAULT_ADDR="http://${COREOS_PRIVATE_IPV4}:8200"

/opt/bin/vault init -check > /dev/null
status="$?"
if [[ "${status}" == "0" ]]; then
    echo "[${me}]: vault is already initialized"
    exit 0
elif [[ "${status}" == "1" ]]; then
    echo "[${me}]: an error occurring check if vault is initialized"
    exit 1
fi

echo "[${me}]: initializing vault"

response=$(curl -s -X PUT -d '{"secret_shares": 5, "secret_threshold": 3}' "${VAULT_ADDR}/v1/sys/init")
mkdir -p /etc/vault/shares/
echo "${response}" | jq '.keys[0]' | sed "s/\"//g" > /etc/vault/shares/0
echo "${response}" | jq '.keys[1]' | sed "s/\"//g" > /etc/vault/shares/1
echo "${response}" | jq '.keys[2]' | sed "s/\"//g" > /etc/vault/shares/2
echo "${response}" | jq '.keys[3]' | sed "s/\"//g" > /etc/vault/shares/3
echo "${response}" | jq '.keys[4]' | sed "s/\"//g" > /etc/vault/shares/4
echo "${response}" | jq '.root_token' | sed "s/\"//g" > /etc/vault/root-token

echo "[${me}]: vault initialized"

cat > /etc/vault-access.env <<EOF
VAULT_ADDR=${VAULT_ADDR}
VAULT_TOKEN=$(cat /etc/vault/root-token)
EOF
