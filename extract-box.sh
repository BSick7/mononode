#!/bin/bash

# Usage: ./extract-box.sh <source-box> <destination-dir>
# Example: ./extract-box.sh ./boxes/coreos-virtualbox.box ./boxes/coreos/virtualbox/

source_box="$1"
dest="$2"

mkdir -p "${dest}"
tar -xvf "${source_box}" -C "${dest}"
