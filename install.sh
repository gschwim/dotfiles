#!/bin/sh

echo 'Cleaning out old nvim folder'
rm -rf ~/.config/nvim

echo 'Installing new nvim config'
cp -a nvim ~/.config/

echo 'Installing Oh My Zsh!'
# clean out the old
rm -rf ~/.oh-my-zsh
rm ~/.zshrc

# in with the new
wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/omz_install.sh
chmod +x /tmp/omz_install.sh
/tmp/omz_install.sh --unattended --keep-zshrc
cp zshrc ~/.zshrc
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

echo 'Installing spaceship prompt'
git clone -v https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


zsh


