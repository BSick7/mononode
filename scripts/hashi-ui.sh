#!/bin/bash

set -e
set -o pipefail

me=hashi-ui

echo "[${me}]: downloading hashi-ui"
curl -sSL -o /opt/bin/hashi-ui "${HASHI_UI_BINARY_URL}"

echo "[${me}] installing hashi-ui"
chmod 755 /opt/bin/hashi-ui
