eval "$(rbenv init -)"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

## hub for git
eval "$(hub alias -s)"

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


## virtualenv settings
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"

[ -f /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

## For autoenv
source $(brew --prefix autoenv)/activate.sh
if [ -e ./.env ]
then
  source ./.env
fi

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}
## Name terminal in iterm
function title {
  echo -ne "\033]0;"$*"\007"
}

# if [ -e /Users/siddharth/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/siddharth/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

##
# Your previous /Users/siddharth/.bash_profile file was backed up as /Users/siddharth/.bash_profile.macports-saved_2016-09-18_at_13:40:50
##

# Finished adapting your PATH environment variable for use with MacPorts.

# bash-completion for respecting CDPATH- homebrew
[ -f /usr/local/etc/bash_completion ] && LC_ALL=C . /usr/local/etc/bash_completion
# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

