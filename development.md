----------------------
Developer Instructions
----------------------

**Quick Start**:

Clone this repository:

```
git clone git@github.com:UMNET-perfSONAR/ansible-playbook-wifimon.git
cd ansible-playbook-wifimon
```

Clone the required roles (ignore errors so we can run this multiple times):

```
cd roles
git clone git@github.com:UMNET-perfSONAR/ansible-role-wifimon.git
git clone git@github.com:UMNET-perfSONAR/ansible-role-kibana.git
git clone git@github.com:UMNET-perfSONAR/ansible-role-wifimonbuild.git
cd ..
```

Get other dependancies:

```
ansible-galaxy install -r  requirements.yml --ignore-errors
```

Run Vagrant

```
vagrant up
```

Develop Role
```
vi roles/ansible-role-wifimon/tasks/main.yml
vi roles/ansible-role-kibana/tasks/main.yml
vagrant provision
```

Check your work
```
vagrant ssh wifimon
```

Clean up when done
```
vagrant halt
```

To destroy the virtual environment.
WARNING: This will completely erase the virtual environment and all data on it!

```
vagrant destroy
```
