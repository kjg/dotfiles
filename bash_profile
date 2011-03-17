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

if (which brew &> /dev/null) && [ -f `brew --prefix`/etc/bash_completion ]; then
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

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

NONE="\[\033[0m\]"    # unsets color to term's fg color
# regular colors
K="\[\033[0;30m\]"    # black
R="\[\033[0;31m\]"    # red
G="\[\033[0;32m\]"    # green
Y="\[\033[0;33m\]"    # yellow
B="\[\033[0;34m\]"    # blue
M="\[\033[0;35m\]"    # magenta
C="\[\033[0;36m\]"    # cyan
W="\[\033[0;37m\]"    # white

if which vcprompt &> /dev/null; then
  vcprompt="$G\$(vcprompt)$NONE"
else
  vcprompt=""
fi

if which rvm-prompt &> /dev/null; then
  rvmprompt="$C[\$(rvm-prompt s u p g)]$NONE "
else
  rvmprompt=""
fi

PS1="\n-- [ \u @ \h \w ] $vcprompt$rvmprompt[\D{%a, %b %d %T}]\n-- $ "
