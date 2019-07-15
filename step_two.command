#! /bin/zsh
PATH=/usr/local/bin:$PATH

# This script setups up ssh access and deploys master role to the designated Centos-based master control node. 

# Run by double-clicking in Finder. If there is an issue run 'chmod +x step_two.command'

# clear terminal clutter
clear

# get IP address for master control node
echo -n "Provide IP address for Master Control Node [ex 192.168.1.100]: "
read address

# check if ssh key exists, then create if not
echo ""
echo ""
if [ -f ~/.ssh/id_rsa.pub ]; then
  echo "SSH key exists"
else
  ssh-keygen
fi

# copy ssh to machine at provided address
echo ""
echo ""
ssh-copy-id root@$address

### ADD STEP ansible-playbook -i production master.yml

# create some space for readability
echo ""
echo ""
