#!/bin/sh

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln ~/.vim/.vimrc ~/.vimrc
vim +PluginInstall +qall
