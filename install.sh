#!/bin/sh

echo 'Cleaning out old nvim folder'
rm -rf ~/.config/nvim

echo 'Installing new nvim config'
cp -a nvim ~/.config/

