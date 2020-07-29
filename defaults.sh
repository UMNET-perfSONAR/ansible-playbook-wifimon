#/bin/sh

# The purpose of this script is to create Ansible inventories.
# Usage: ./defaults.sh [ directory ]

if [ "$1" == "" ]; then
  directory="inventory"
else
  directory=$1
fi

mkdir -p $directory/group_vars/all/
mkdir -p $directory/group_vars/all/wifimon
mkdir -p $directory/host_vars/

# copy hosts file
wget -q -P $directory -nc \
  https://raw.githubusercontent.com/UMNET-perfSONAR/ansible-playbook-wifimon/master/inventory/hosts

if ! [ -f $directory/group_vars/all/wifimon/elastic.yml ]; then
  cp roles/ansible-elasticsearch/defaults/main.yml \
    $directory/group_vars/all/wifimon/elastic.yml
fi

if ! [ -f $directory/group_vars/all/wifimon/kibana ]; then
  cp roles/ansible-role-kibana/defaults/main.yml \
    $directory/group_vars/all/wifimon/kibana.yml
fi

if ! [ -f $directory/group_vars/all/wifimon/kibana ]; then
  cp roles/ansible-role-wifimonbuild/defaults/main.yml \
    $directory/group_vars/all/wifimon/wifimonbuild.yml
fi

if ! [ -f $directory/group_vars/all/wifimon/kibana ]; then
  cp roles/ansible-role-wifimon/defaults/main.yml \
    $directory/group_vars/all/wifimon/wifimon.yml
fi
