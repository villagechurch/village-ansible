#! /bin/zsh

# This script builds an ansible environment on macOS 10.14 for the purpose of building out an ansible control infrastructure.

# clear terminal clutter
clear

# Assume ready, failed checks will change this
READY="True"

# Application checks
Apps=('Transmit' 'BBEdit')

for i in "${Apps[@]}"; do
  if [ -d /Applications/$i.app ]; then
    echo $i "is installed"
  else
    echo "You need to install" $i
    READY="False"
  fi
done

# Homebrew
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
  echo "You're ready for Step Two"
fi

# create some space for readability
echo ""
echo ""
