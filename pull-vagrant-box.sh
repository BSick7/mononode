#!/bin/bash

# Usage: ./pull-vagrant-box.sh <vagrant-box-name> <vagrant-box-version> <provider> <local-filename>
# Example ./pull-vagrant-box.sh brad_sickles/coreos 1465.7.0 virtualbox ./boxes/coreos-virtualbox.box

box_name="$1"
box_version="$2"
provider="$3"
local_box="$4"

box_url=$(curl -sSL "http://vagrantcloud.com/${box_name}" \
    | jq ".versions[] | select(.version == \"${box_version}\") | .providers[] | select(.name == \"${provider}\").url" \
    | sed 's/"//g')

if [ -z "${box_url}" ]; then
    echo "could not find box for ${box_name}:${box_version} (${provider})"
    exit 1
fi

mkdir -p $(dirname ${local_box})
echo "downloading ${box_url} to ${local_box}"
curl -SL -o "${local_box}" "${box_url}"
