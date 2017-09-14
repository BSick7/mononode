source /usr/share/skel/.bashrc
source /etc/environment

export TERM=vt100
export CONSUL_HTTP_ADDR=${COREOS_PRIVATE_IPV4}:8500
export NOMAD_ADDR=http://${COREOS_PRIVATE_IPV4}:4646
if [ -e /etc/vault-access.env ]; then
    source /etc/vault-access.env
    export VAULT_ADDR
    export VAULT_TOKEN
fi
