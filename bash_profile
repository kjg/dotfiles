export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

if [ -d /opt/local ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:/opt/local/lib/postgresql83/bin:$PATH
fi

export HISTCONTROL=erasedups
shopt -s histappend

export P4CONFIG="$HOME/.p4config"

alias gst='git status'
alias gbst='git branch -a -v'
alias gco='git checkout'
alias gci='git commit'
alias gb='git branch'
alias gsh='git show'
alias gshb='git show-branch'
alias gl='git log'
alias gd='git diff'
alias gds='git diff --cached'
alias gdhd='git diff HEAD'
alias gdst='git diff --stat'
alias stash='git stash'
alias unstash='git stash apply'
alias stash-ls='git stash list'
alias stash-patch='git stash show -p'

alias scpr='rsync --partial --progress --rsh=ssh'

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f ~/.cap_bash_autocomplete.sh ]; then
  source ~/.cap_bash_autocomplete.sh
fi

if [ -f ~/.completion-rake ]; then
  source ~/.completion-rake
fi

complete -o default -o nospace -F _git_checkout gco

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PS1="\n-- [ \u @ \h \w ] \[\033[0;32m\]\$(vcprompt)\[\033[0m\][\D{%a, %b %d %T}]\n-- $ "
