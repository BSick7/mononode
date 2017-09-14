#!/bin/bash

me=unseal

sealed=$(curl "${VAULT_ADDR}/v1/sys/seal-status" | jq '.sealed' | sed "s/\"//g")
if [[ "${sealed}" == "false" ]]; then
    echo "[${me}]: vault is already unsealed"
    exit 0
fi

/opt/bin/vault unseal $(cat /etc/vault/shares/0)
/opt/bin/vault unseal $(cat /etc/vault/shares/1)
/opt/bin/vault unseal $(cat /etc/vault/shares/2)
