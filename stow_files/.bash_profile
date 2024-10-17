# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{exports,path,bash_prompt,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.pass-completion.bash ]; then
    . ~/.pass-completion.bash
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

## Name terminal in iterm
function title {
  echo -ne "\033]0;"$*"\007"
}

# Nix setup
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh; 
  # avoid nix-env warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
  export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
fi


### add to .bash_aliases, for differentiating between local and remote hosts
sshhelper() {
   gnome-terminal --window-with-profile=Remote -x bash -c "ssh $1";
}
alias sshc=sshhelper

## Use conda python
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$PATH:$HOME/miniconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# source activate py37

# autoenv initialize
source "$HOME/.nvm/versions/node/$(nvm version)/lib/node_modules/@hyperupcall/autoenv/activate.sh"

# Display machine name in terminal
title "$(hostname)"

## History settings
export HISTTIMEFORMAT='%F, %T '
export HISTSIZE=32768
export HISTFILESIZE=32768
# Append to history file
shopt -s histappend
# Ignore duplicate entries and commands with leading space
export HISTCONTROL=ignorespace:ignoredups
# Ignore some basic commands
export HISTIGNORE="history:ls:pwd:clear:vi"

. "$HOME/.cargo/env"

check-ssh-agent() {
  # ssh-add -l returns 2 if a connection cannot be opened with the running agent.
  [ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }
}

# Start ssh-agent if not running
# https://superuser.com/questions/141044/sharing-the-same-ssh-agent-among-multiple-login-sessions
check-ssh-agent || export SSH_AUTH_SOCK=~/.tmp/ssh-agent.sock
check-ssh-agent || eval "$(ssh-agent -s -a ~/.tmp/ssh-agent.sock)" > /dev/null

# Start pulseaudio if not running
# if ! pgrep -x pulseaudio > /dev/null; then
#   pulseaudio --start
# fi
#
# * ~/.extra can be used for other settings you don’t want to commit.
[ -r "$HOME/.extra" ] && source "$HOME/.extra"
