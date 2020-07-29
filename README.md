----------------------
Overview
----------------------

[Developer Instructions Here](https://github.com/UMNET-perfSONAR/ansible-playbook-wifimon/blob/master/development.md)

This playbook will install and configure the wifimon analysis server on a vagrant virtual environment.

**Quick Start**:

Clone this repository:

```
git clone https://github.com/UMNET-perfSONAR/ansible-playbook-wifimon.git
cd ansible-playbook-wifimon
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
vi inventory/group_vars/all/
```

