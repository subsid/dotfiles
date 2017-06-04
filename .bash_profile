eval "$(rbenv init -)"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home"
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
source "/usr/local/Cellar/nvm/0.25.4/nvm.sh"

## virtualenv settings
source /usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/activate.sh
if [ -e ./.env ]
then
  source ./.env
else
  source /Users/siddharth/.env
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

# MacPorts Installer addition on 2016-09-18_at_13:40:50: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# bash-completion for respecting CDPATH- homebrew
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
