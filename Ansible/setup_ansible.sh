#!/bin/bash
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Retrieving the Control Machine${NC}"
control=$(vagrant global-status | grep odin0 | cut -d " " -f1)

echo -e "${GREEN}Making hosts ssh accessible"
vagrant ssh "$control" -c "sudo apt install sshpass"
vagrant ssh "$control" -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1" 
vagrant ssh "$control" -c "sshpass -p \"vagrant\" ssh-copy-id -o StrictHostKeyChecking=no rune0 <<<'yes'"
vagrant ssh "$control" -c "sshpass -p \"vagrant\" ssh-copy-id -o StrictHostKeyChecking=no rune1<<<'yes'"
vagrant ssh "$control" -c "sshpass -p \"vagrant\" ssh-copy-id -o StrictHostKeyChecking=no rune2<<<'yes'"

echo -e "${GREEN}Installing and setting up ansible in control machine${NC}"
vagrant ssh "$control" -c "sudo apt install -y ansible"

echo -e "${GREEN}Testing Ansible${NC}"
vagrant ssh "$control" -c "ansible nodes -i /vagrant/Ansible/myhosts -m command -a hostname"

echo -e "${BLUE}Installing Python on the list of hosts${NC}"
vagrant ssh "$control" -c "ansible nodes -i /vagrant/Ansible/myhosts -m command -a 'sudo apt-get -y install python-simplejson'"

echo -e "${GREEN}Run the playbook to install docker${NC}"
vagrant ssh "$control" -c "ansible-playbook -i /vagrant/Ansible/myhosts -K /vagrant/Ansible/playbook_docker.yml"