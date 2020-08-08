#!/bin/bash

CURRENT_DIR=$(pwd)

# is a command exists? call like isCmdExist vim
function isCmdExist() {
	local cmd="$1"
	if [ -z "$cmd" ]; then
		echo "Usage isCmdExist yourCmd"
		return 1
	fi
	which "$cmd" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		return 0
	fi
	return 2
}

# 1. git and zsh
if ! isCmdExist git; then
  echo "please install git"
  exit
fi
if ! isCmdExist zsh; then
  echo "please install zsh"
  exit
else
  chsh -s $(which zsh)
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "install oh-my-zsh via zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh"
    sh zsh/install_oh_my_zsh_079e7bb5e0a79171f3356d55d3f6302a82645a39.sh
  fi
  cp -R zsh/zsh-autosuggestions  $HOME/.oh-my-zsh/custom/plugins/
  cp -R zsh/zsh-syntax-highlighting  $HOME/.oh-my-zsh/custom/plugins/
fi

# 2. vim
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backup
cp vim/color/*.vim $HOME/.vim/colors/
if [ ! -f "$HOME/.viminfo" ]; then
  rm $HOME/.viminfo
fi

# 3. TODO: python
# $CURRENT_DIR/scripts/install_python.sh

# 4. set paths
ln -sf $CURRENT_DIR/vim/vimrc $HOME/.vimrc
ln -sf $CURRENT_DIR/zsh/zshrc $HOME/.zshrc

# 5. github
git config --global user.email "xingchensong1996@163.com"
git config --global user.name "xingchensong"

# 6. launch zsh
echo "DONE"
zsh
