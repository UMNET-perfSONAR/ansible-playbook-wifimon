template for Ansible playbooks

**Quick Start**:

Clone this repository:

```
git clone https://github.com/UMNET-perfSONAR/ansible-playbook-template.git
cd ansible-playbook-template
```

Get the required roles (ignore errors so we can run this multiple times):

```
ansible-galaxy install -r  requirements.yml --ignore-errors
```

Set up your inventory.  Connection variables can be added here as well.

```
vi inventory/hosts
```

Set up template variables by running the defaults.sh script and then editing:

```
./defaults.sh
vi inventory/group_vars/all/template/*
```

Use Ansible ping to verify connectivity to targets:

```
ansible all -m ping
```

Run the playbook:

```
ansible-playbook template.yml
```
