#! /bin/zsh

ARG1=$1

cd ansible


while getopts ":g:d" opt; do
  case $opt in
    a)
      echo -e "\n*********\nTargetting ALL hosts in inventory\n*********\n" >&2
      command="ansible-playbook -i inventory/staging cluster.yml"
      ;;
    g)
      echo -e "\n*********\nTargetting $OPTARG hosts in inventory\n*********\n" >&2
      command="ansible-playbook -l $OPTARG -i inventory/staging cluster.yml"
      ;;
    d)
      dflag=1
      ;;
    \?)
      echo -e "\n*********\nTargetting All hosts in inventory\n*********\n" >&2
      command="ansible-playbook -i inventory/staging cluster.yml"
      ;;
  esac
done

if [ ! -z "$dflag" ]; then
    command+=" --check"
fi

echo -e "*********\n$command\n*********\n" >&2
eval "$command"