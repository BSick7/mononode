#!/bin/bash

set -e
set -o pipefail

me=nomad

echo "[${me}]: downloading nomad"
curl -sSL -o /tmp/nomad.zip "${NOMAD_BINARY_URL}"

echo "[${me}]: extracting nomad"
unzip /tmp/nomad.zip -d /opt/bin/

echo "[${me}] installing nomad"
chmod 755 /opt/nomad/bind.sh
chmod 755 /opt/bin/nomad
