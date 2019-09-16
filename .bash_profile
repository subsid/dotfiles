if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Enable global python env
source ~/.virtualenvs/global/bin/activate

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file


# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

## virtualenv settings
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"

[ -f /home/ssubramaniyam/.local/bin/virtualenvwrapper.sh ] && . /home/ssubramaniyam/.local/bin/virtualenvwrapper.sh
[[ -s /home/ssubramaniyam/.autojump/etc/profile.d/autojump.sh ]] && source /home/ssubramaniyam/.autojump/etc/profile.d/autojump.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}
## Name terminal in iterm
function title {
  echo -ne "\033]0;"$*"\007"
}

