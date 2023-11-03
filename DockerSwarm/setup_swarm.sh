#!/bin/bash
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}Retrieving the Control Machine${NC}"
control=$(vagrant global-status | grep odin0 | cut -d " " -f1)

echo -e "${GREEN}Cloning ansible-swarm-playbook${NC}"
vagrant ssh "$control" -c "cd /vagrant/DockerSwarm/ && git clone https://github.com/devopsjourney1/ansible-swarm-playbook.git"
echo -e "${GREEN}Replacing eth0 by eth1 in ansible-swarm-playbook/swarm.yml file${NC}"
vagrant ssh "$control" -c "cd /vagrant/DockerSwarm/ansible-swarm-playbook/ && sed -i 's/eth0/eth1/' swarm.yml"
echo -e "${BLUE}Applying ansible-swarm-playbook/swarm.yml file${NC}"
vagrant ssh "$control" -c "ansible-playbook -i /vagrant/Ansible/myhosts -K /vagrant/DockerSwarm/ansible-swarm-playbook/swarm.yml"
echo -e "${BLUE}Applying playbook_setup_swarm.yml${NC}"
vagrant ssh "$control" -c "ansible-playbook -i /vagrant/Ansible/myhosts -K /vagrant/DockerSwarm/playbook_setup_swarm.yml"
echo -e "${BLUE}Testing proper swarm setup${NC}"
vagrant ssh "$control" -c "for i in {1..6}; do curl rune0:5000; done"
