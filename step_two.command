#! /bin/zsh
PATH=/usr/local/bin:$PATH

# This script setups up ssh access to the designated Centos-based master control node. 

# Run by double-clicking in Finder. If there is an issue run 'chmod +x step_two.command'

# clear terminal clutter
clear

# get IP address for master control node
echo -n "Provide IP address for Master Control Node [ex 192.168.1.100]: "
read address

# check if ssh key exists, then create if not
if [ -f ~/.ssh/id_rsa.pub ]; then
  echo "ssh key exists"
else
  ssh-keygen
fi

# copy ssh to machine at provided address
echo ""
ssh-copy-id root@$address

# create some space for readability
echo ""
echo ""
