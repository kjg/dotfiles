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

# Author.: Ole J
# Date...: 23.03.2008
# License: Whatever

# Wraps a completion function
# make-completion-wrapper <actual completion function> <name of new func.>
#                         <command name> <list supplied arguments>
# eg.
#   alias agi='apt-get install'
#   make-completion-wrapper _apt_get _apt_get_install apt-get install
# defines a function called _apt_get_install (that's $2) that will complete
# the 'agi' alias. (complete -F _apt_get_install agi)
#
function make-completion-wrapper () {
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2
  local function="
function $function_name {
  ((COMP_CWORD+=$arg_count))
  COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
  "$comp_function_name"
  return 0
}"
  eval "$function"
}

make-completion-wrapper _git _gco git checkout
complete -o default -o nospace -F _gco gco



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

ps1_vcprompt()
{
  if command -v vcprompt >/dev/null 2>&1 ; then
    printf "%s" "$G\$(vcprompt)$NONE"
  fi
}

ps1_rvmprompt()
{
  if command -v rvm-prompt &> /dev/null 2>&1 ; then
    printf "%s" "$C[\$(rvm-prompt u p g s)]$NONE "
  fi
}

ps1_identity()
{
  if [[ $UID -eq 0 ]]  ; then
    printf "%s" "$R\u$NONE@$C\h$M:\w$NONE"
  else
    printf "%s" "$G\u$NONE@$C\h$M:\w$NONE"
  fi
}

ps1_update()
{
  PS1="\n-- [$(ps1_identity)] $(ps1_vcprompt)$(ps1_rvmprompt)[\D{%a, %b %d %T}]\n-- $ "
}

PROMPT_COMMAND="ps1_update $@"
