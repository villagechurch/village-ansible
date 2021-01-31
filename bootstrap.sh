#! /bin/zsh

ARG1=$1
rflag=1

cd ansible

#default command, barring any cli arguments
command="ansible-playbook -l bootstrap -i inventory/bootstrap bootstrap.yml"

while getopts ":cr" opt; do
  case $opt in
    c)
      echo -e "\n*********\nTargetting cloud hosts in inventory\n*********\n" >&2
      command="ansible-playbook -l bootstrap_cloud -i inventory/bootstrap bootstrap.yml"
      ;;
    r)
      rflag=0
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 2
      ;;
  esac
done

if [ "$rflag" -gt 0 ]; then
    command+=" --ask-pass"
fi

echo -e "*********\n$command\n*********\n" >&2
eval "$command"
