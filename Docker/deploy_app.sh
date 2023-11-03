#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Retrieving the Control Machine${NC}"
control=$(vagrant global-status | grep odin0 | cut -d " " -f1)

echo -e "${GREEN}Run the playbook to test docker${NC}"
vagrant ssh "$control" -c "ansible-playbook -i /vagrant/Ansible/myhosts -K /vagrant/Docker/deploy_app.yml"
