#! /bin/zsh

cd ansible

#ansible-playbook -i inventory/bootstrap bootstrap.yml
ansible-playbook -i inventory/bootstrap bootstrap.yml --ask-pass