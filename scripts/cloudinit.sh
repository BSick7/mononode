#!/bin/bash

set -e
set -o pipefail

me=cloudinit

echo "[${me}]: running cloudinit"
coreos-cloudinit -from-file=/tmp/files/cloud-config.yml
rm /tmp/files/cloud-config.yml
