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

## How to use

```
$ cat > ./Vagrantfile <<EOF
Vagrant.configure("2") do |config|
  config.vm.box = "brad_sickles/mononode"
  
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.network "forwarded_port", guest: 4646, host: 4646 # nomad
  config.vm.network "forwarded_port", guest: 8200, host: 8200 # vault
  config.vm.network "forwarded_port", guest: 8500, host: 8500 # consul
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # hashi ui
end
EOF
$ vagrant up \
  --provider virtualbox # only necessary if not default
```
