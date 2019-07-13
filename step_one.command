#! /bin/zsh
PATH=/usr/local/bin:$PATH

# This script prepares an install of macOS 10.14 for the purpose of building out an ansible control infrastructure. 

# Run by double-clicking in Finder. If there is an issue run 'chmod +x step_one.command'

# clear terminal clutter
clear

# Assume ready, failed checks will change this
READY="True"

# PHASE ONE - Application checks
echo "--- PHASE ONE ---"
Apps=('Transmit' 'BBEdit')

for i in "${Apps[@]}"; do
  if [ -d /Applications/$i.app ]; then
    echo $i "is installed"
  else
    echo "You need to install" $i
    READY="False"
  fi
done

# PHASE ONE - Homebrew
if which brew >/dev/null; then
  echo "Homebrew is installed"
else
  echo -n "You need to install Homebrew, proceed? [y/n]: "
  read ans
  case $ans in
    y | Y)
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      if which brew >/dev/null; then
        echo "Homebrew now installed."
      else
        echo "Homebrew install failed."
        READY="False"
      fi
      ;;
    
    n)
      echo "Skipping Homebrew install..."
      READY="False"
      ;;

    *)
      echo "you answered something other than 'y', Skipping Homebrew install..."
      READY="False"
      ;;
  esac
fi

if [[ $READY == "True" ]]; then
  echo ""
  echo "You're ready for Phase Two"
else
  echo ""
  echo "You're not ready for Phase Two"
  # create some space for readability
  echo ""
  echo ""
  exit
fi

# PHASE TWO - Python3
echo ""
echo "--- PHASE TWO ---"
if brew list python3 &>/dev/null; then
  echo "Python 3 is installed"
else 
  brew install python3
fi

# PHASE TWO - Ansible
if pip3 list | grep ansible>/dev/null; then
  echo "Ansible is installed"
else
  pip3 install ansible
fi

# PHASE TWO - Git
if brew list git &>/dev/null; then
  echo "Git is installed"
else 
  brew install git
fi

# PHASE THREE - Get village-ansible
echo ""
echo "--- PHASE THREE ---"
if [ -d ~/src/ ]; then
  echo "~/src folder exists"
else
  mkdir ~/src
fi

cd ~/src
git clone https://github.com/villagechurch/village-ansible.git

# create some space for readability
echo ""
echo ""
