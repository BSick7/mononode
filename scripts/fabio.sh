#!/bin/bash

set -e
set -o pipefail

me=fabio

echo "[${me}]: downloading fabio"
curl -sSL -o /opt/bin/fabio "${FABIO_BINARY_URL}"

echo "[${me}] installing fabio"
chmod 755 /opt/fabio/ensure-consul-config.sh
chmod 755 /opt/bin/fabio
