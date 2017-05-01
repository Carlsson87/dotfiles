#!/bin/sh

# Install Plug vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the .vimrc to the home folder.
cp .vimrc ~