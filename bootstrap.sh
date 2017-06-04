#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

## TODO Include other dotfiles
function copyDotFiles() {
        rsync --exclude ".git/" \
                --exclude ".DS_Store" \
                --exclude ".osx" \
                --exclude "bootstrap.sh" \
                --exclude "README.md" \
                --exclude "LICENSE-MIT.txt" \
                -avh --no-perms .vim .vimrc .vimrc.bundles .aliases .bash_profile .bash_prompt .path, .exports  ~;
        source ~/.bash_profile;
}

function copyDotDirectories() {
        rsync --exclude ".git/" \
                --exclude ".DS_Store" \
                --exclude ".osx" \
                --exclude "bootstrap.sh" \
                --exclude "README.md" \
                --exclude "LICENSE-MIT.txt" \
                -avh --no-perms .vim ~;
        source ~/.bash_profile;
}

function installStuff() {
        # Install Vundle for managing vim dependencies. (hmm, where should this be??)
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        # Install YouCompleteMe
        ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

        source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
        doIt;
else
        read -p "This may overwrite existing files in your home directory. Copy dotfiles? (y/n) " -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                copyDotFiles;
        fi;
        read -p "This may overwrite existing files in your home directory. Copy dotDirectories? (y/n) " -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                copyDotDirectories;
        fi;
        read -p "Run installation scripts?" -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                installStuff;
        fi;
fi;
unset copyDotFiles;
unset copyDotDirectories;
unset installStuff;
