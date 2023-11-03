#!/bin/bash
echo "#### Cleaning up the space to start again... ####"
vagrant destroy
rm -rf Vagrantfile .vagrant/