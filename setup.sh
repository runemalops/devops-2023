#!/bin/bash
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN} #### Preparing The Environment... ####${NC}"
brew install virtualbox ansible
brew install hashicorp/tap/hashicorp-vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox

echo -e "${GREEN}#### Initializing Vagrantfile... ####${NC}"
rm -rf Vagrantfile && vagrant init --template Vagrantfile.erb

echo -e "${GREEN} # You are all set, starting your machines with #~> vagrant up command # ${NC}"
vagrant up

echo -e "${BLUE}#### Initializing Hosts... ####${NC}"
./LabSetup/setup_hosts.sh

echo -e "${BLUE}#### Setting Up Ansible on Hosts ####${NC}"
./Ansible/setup_ansible.sh

echo -e "${BLUE}#### Deploying app on Hosts ####${NC}"
./Docker/deploy_app.sh

echo -e "${BLUE}#### Setting Up Swarm ####${NC}"
./DockerSwarm/setup_swarm.sh
