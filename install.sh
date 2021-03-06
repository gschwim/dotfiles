#!/bin/bash

export WORKDIR=$(pwd)

echo 'Cleaning out old nvim folder'
rm -rf ~/.config/nvim

echo 'Installing new nvim config'
cp -a nvim ~/.config/

# echo 'Installing Oh My Zsh!'
# # clean out the old
# rm -rf ~/.oh-my-zsh
# rm ~/.zshrc

# in with the new
if [[ `uname` == "Linux" ]] ; then
	ZPATH=$(which zsh)
	if ! [ -x "$ZPATH" ] ; then
		echo "Installing zsh..."
		sudo apt install zsh
	fi
fi

export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
cp zshrc ~/.zshrc
if test -e ~/.oh-my-zsh; then
	echo "Oh-My-Zsh already installed. Updating..."
	zsh -c "source ~/.zshrc; omz update"	
	echo "Updating spaceship prompt..."
	cd $ZSH_CUSTOM/themes/spaceship-prompt
	git pull
	cd $WORKDIR
else
	echo "Installing Oh-My-Zsh..."
	wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/omz_install.sh
	chmod +x /tmp/omz_install.sh
	/tmp/omz_install.sh --unattended --keep-zshrc
	echo 'Installing spaceship prompt'
	git clone -v https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

fi


# install pyenv

if test -e ~/.pyenv; then 
	echo "pyenv already installed. Updating..."
	cd ~/.pyenv
	git pull
	# zsh -c "source ~/.zshrc; echo $(pyenv root); cd $(pyenv root); git pull"
	cd $WORKDIR
else
	echo "Installing pyenv..."
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# change shell if needed
if [[ `uname` == "Linux" ]]; then
	if [[ $(echo $SHELL | rev | cut -d "/" -f 1 | rev) != 'zsh' ]]; then
		echo "Updating shell. Too lazy to make this smarter right now..."
		sudo chsh --shell /usr/bin/zsh $USER
	fi
fi

# Go!
zsh


