export HISTCONTROL=erasedups
shopt -s histappend

export BASH_IT=$HOME/.bash_it

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

alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

if (which brew &> /dev/null) && [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if [ -f ~/.cap_bash_autocomplete ]; then
  source ~/.cap_bash_autocomplete
fi

if [ -f ~/.completion-rake ]; then
  source ~/.completion-rake
fi

[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

command -v _completion_loader > /dev/null  && _completion_loader git
command -v __git_complete > /dev/null && __git_complete git __git_main
command -v __git_complete > /dev/null && __git_complete gco _git_checkout


flushdns()
{
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

quiet_which() {
  command -v "$1" >/dev/null
}

if quiet_which code
then
  export EDITOR="code --wait --new-window"
fi

if [ -s "/usr/local/share/chruby/chruby.sh" ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
elif quiet_which rbenv; then
  eval "$(rbenv init -)"
else
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

  [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
fi

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
    local prompt=$(vcprompt -f [%n:%b%m%u] \")
  else
    local gitbranch='`\
        export BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); \
        if [ "${BRANCH}" = "HEAD" ]; then \
            export BRANCH=$(git describe --contains --all HEAD 2>/dev/null); \
        fi; \
        if [ "${BRANCH}" != "" ]; then \
            echo -n "${BRANCH}" \
            && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                    echo -n "?"; \
            fi
        fi`'
    local prompt="[git:$gitbranch]"
  fi
  if [ ! -z "$prompt" ]; then
    printf "%s" "$G$prompt$NONE "
  fi
}

ps1_ruby_version()
{
  if command -v rvm-prompt &> /dev/null 2>&1 ; then
    printf "%s" "$C[\$(rvm-prompt u p g s)]$NONE "
  else
    if [ -n "$RUBY_ROOT" ]; then
      printf "%s" "$C[\$(basename $RUBY_ROOT)]$NONE "
    elif quiet_which rbenv && rbenv version-name &>/dev/null; then
      if [ $(rbenv version-name) != "system" ]; then
        printf "%s" "$C[ruby-\$(rbenv version-name)]$NONE "
      fi
    fi
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

ps1_dashes()
{
  if [[ $XIT -ne 0 ]] ; then
    printf "%s" "$R"
  fi
  printf "%s" "--"
  printf "%s" "$NONE"
}

ps1_update()
{
  export XIT=$?
  PS1="\n$(ps1_dashes) [$(ps1_identity)] $(ps1_vcprompt)$(ps1_ruby_version)[\D{%a, %b %d %T}]\n$(ps1_dashes) $ "
}

PROMPT_COMMAND="ps1_update $@;$PROMPT_COMMAND"

[[ -s "$HOME/.bash_profile_local" ]] && source "$HOME/.bash_profile_local"
[[ -s "$BASH_IT/bash_it.sh" ]] && source $BASH_IT/bash_it.sh

true # make last command a success
