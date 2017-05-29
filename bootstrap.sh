#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

## TODO Include other dotfiles
function doIt() {
        rsync --exclude ".git/" \
                --exclude ".DS_Store" \
                --exclude ".osx" \
                --exclude "bootstrap.sh" \
                --exclude "README.md" \
                --exclude "LICENSE-MIT.txt" \
                -avh --no-perms .vim .vimrc .aliases .bash_profile .bash_prompt .path, .exports  ~;
        source ~/.bash_profile;
        # Install Vundle for managing vim dependencies. (hmm, where should this be??)
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
        doIt;
else
        read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                doIt;
        fi;
fi;
unset doIt;
