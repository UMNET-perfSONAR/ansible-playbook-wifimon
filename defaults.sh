#/bin/sh

# The purpose of this script is to create Ansible inventories.
# Usage: ./defaults.sh [ directory ]

if [ "$1" == "" ]; then
  directory="inventory"
else
  directory=$1
fi

mkdir -p $directory/group_vars/all/
mkdir -p $directory/group_vars/all/template
mkdir -p $directory/host_vars/localhost

# XXX
wget -q -P $directory -nc \
  https://raw.githubusercontent.com/UMNET-perfSONAR/ansible-playbook-template/master/inventory/hosts

if ! [ -f $directory/group_vars/all/perfsonar/ps_archive.yml ]; then
  cp roles/ansible-role-template/defaults/main.yml \
    $directory/group_vars/all/template/template.yml
fi
