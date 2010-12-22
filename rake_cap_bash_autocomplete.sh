# from https://github.com/jpalardy/dotfiles/blob/master/bash/completion

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_check_rakefile() {
  if [ ! -e Rakefile ]; then
    return
  fi

  local cache_file=".cache_rake_t"

  if [ ! -e "$cache_file" ]; then
    rake -T | awk '/^rake / {print $2}' > $cache_file
  fi

  local tasks=$(cat $cache_file)
  COMPREPLY=( $(compgen -W "${tasks}" -- $2) )
}

_check_capfile() {
  if [ ! -e Capfile ]; then
    return
  fi

  local cache_file=".cache_cap_t"

  if [ ! -e "$cache_file" ]; then
    cap -T | awk '/^cap / {print $2}' > $cache_file
  fi

  local tasks=$(cat $cache_file)
  COMPREPLY=( $(compgen -W "${tasks}" -- $2) )
}

complete -F _check_rakefile -o default rake
complete -F _check_capfile -o default cap
