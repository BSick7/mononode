#!/bin/bash

# Usage: ./ensure-consul-config.sh public|private
# This script ensures the consul kv config exists (empty is OK) for the specified fabio instance
# When it is missing, we experience performance degradation due to the way fabio watches the kv

FABIO_INSTANCE=$1
key="infra/fabio/config/${FABIO_INSTANCE}"

echo "Checking for fabio config in consul @ ${key}"
/opt/bin/consul kv get ${key} 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Fabio config exists in consul @ ${key}"
else
    echo "Seeding empty fabio config in consul @ ${key}"
    /opt/bin/consul kv put ${key} ""
fi
