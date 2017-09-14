#!/bin/bash

# NOTE TO CONTRIBUTORS:
# This file is intended to contain steps that are applicable to all packer runs
# It is generic, and each packer run will introduce new artifacts linked to
# this logic.
#
# All other activities should be part of separate 'feature' scripts.

set -e
set -o pipefail

me=init

echo "[${me}]: placing files"
rsync -rv /tmp/files/ /

echo "[${me}]: setting binary permissions"
chmod 755 /opt/bin/*

echo "[${me}]: reset ownership on /home/core/.bashrc"
chown core:core /home/core/.bashrc

if [ -d /tmp/files/etc/systemd/system/ ]; then
    echo "[${me}]: enabling systemd units"
    pushd /tmp/files/etc/systemd/system/
    for unit in *; do
      [[ -f ${unit} ]] && systemctl enable ${unit}
    done
    popd
fi
