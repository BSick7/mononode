#!/bin/sh

set -e

# assume we have an EBS volume mounted at /data
if [ ! -d /var/lib/consul ]; then
  mkdir -p /var/lib/consul
fi

/bin/chown consul:consul /var/lib/consul
