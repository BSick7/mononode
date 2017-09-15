# mononode

This is a packer build for a vagrant box running a mononode.
A mononode is a single box running an entire cluster of consul, vault, and nomad.

In the future, nomad worker boxes will be able to join the cluster.

## Vault

This box is intentionally configured to run vault insecurely.
Vault is automatically initialized and unsealed upon boot.
The root token is stored in `/etc/vault/root-token`.
The recovery shares are stored in `/etc/vault/shares/`: 
  - `/etc/vault/shares/0` 
  - `/etc/vault/shares/1` 
  - `/etc/vault/shares/2` 
  - `/etc/vault/shares/3` 
  - `/etc/vault/shares/4`

Since vault is configured to use consul as a backend, vault can be reset by destroying `vault/` in the consul k/v store.
