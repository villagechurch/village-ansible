#! /bin/zsh

ARG1=$1

cd ansible

if [ -z "$ARG1" ]; then
  echo "Targetting All hosts in inventory"
  ansible-playbook -i inventory/staging cluster.yml
else
  echo "Targetting $ARG1 hosts in inventory"
  ansible-playbook -l $ARG1 -i inventory/staging cluster.yml
fi
