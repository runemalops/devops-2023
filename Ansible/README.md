# Run the setup_ansible.sh (recommended)
```bash
./setup_ansible.sh
```

# Install Ansible on control station
```bash
sudo apt install ansible -y
```

# Make hosts SSH accessible (only if ssh didn't work)
```bash
ssh-keygen
ssh-copy-id rune0 && ssh-copy-id rune1 && ssh-copy-id rune2
```

### Test Ansible
```bash
ansible nodes -i myhosts -m command -a hostname
```
### Install Python simplejson
```bash
ansible nodes -i myhosts -m command -a 'sudo apt -y install python-simplejson'
```

### Run the playbook to install docker
```bash
ansible-playbook -i myhosts -K playbook1.yml
```
