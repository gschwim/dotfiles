#!/bin/bash

export WORKDIR=$(pwd)

## Install os dependencies, or upgrade them
echo "Installing zsh and friends..."
if [[ `uname` == "Linux" ]] ; then
	sudo apt update
	sudo apt install --yes zsh wget ripgrep bat git snapd
	# Apt repos are fucking old!
	sudo apt remove --yes neovim
	sudo snap install nvim --classic
elif [[ `uname` == "Darwin" ]] ; then
	brew install wget ripgrep bat exa
fi

## establish some necessary directories
if [ ! -e ~/.local/bin ]; then
	echo "Creating ~/.local/bin"
	mkdir -p ~/.local/bin
fi

## neovim!
if [ ! -e ~/.config/nvim ]; then
	echo "Clear any old nvim caches..."
	rm -rf ~/.local/share/nvim
	echo "Install nvim config..."
	git clone https://github.com/gschwim/dotfiles.nvim.git ~/.config/nvim/
else
	echo "Updating nvim config..."
	bash -c "cd ~/.config/nvim && git pull && exit"
fi

## Oh my zsh!
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
cp zshrc ~/.zshrc
cp zprofile ~/.zprofile
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

wait

## install starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin --yes 
cp starship.toml ~/.config/

wait
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
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

fi

wait

## install rust things
if [ ! -e ~/.cargo ]; then
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

wait
source ~/.cargo/env

if  [ ! -e ~/.cargo/bin/exa ]; then
	cargo install exa
fi
# if test -x ~/.cargo/bin/bat; then
# 	cargo install bat
# if test -x ~/.cargo/bin/dust; then
# 	cargo install dust


# change shell if needed
if [[ `uname` == "Linux" ]]; then
	if [[ $(echo $SHELL | rev | cut -d "/" -f 1 | rev) != 'zsh' ]]; then
		echo "Updating shell. Too lazy to make this smarter right now..."
		sudo chsh --shell /usr/bin/zsh $USER
	fi
fi


# tmux config
cp tmux.conf ~/.tmux.conf

# Go!
zsh
