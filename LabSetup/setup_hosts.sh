#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}#### Getting list of machines to apply changes... ####${NC}"
machines=$(vagrant global-status | grep devops-2023 | cut -d " " -f1)
echo -e "${GREEN}#### Setting up /etc/hosts... ####${NC}"
for i in $machines; do
	vagrant ssh $i -c "sudo cp /vagrant/hosts /etc/hosts" 
done
