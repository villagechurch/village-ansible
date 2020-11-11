#! /bin/zsh

cd ansible

ansible-playbook -i inventory/iwiebe-home bootstrap.yml
