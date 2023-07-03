#!/bin/bash

export LANG=C.UTF-8
export AWS_PROFILE=devtest-admin
#export AWS_SDK_LOAD_CONFIG=true
export AWS_VAULT_BACKEND=file
export AWS_VAULT_FILE_PASSPHRASE=insecure

alias caconfig="rm -f ~/.config/pip/pip.conf && aws codeartifact login --tool pip --repository dpe-python --domain lacework --domain-owner 249446771485 --region us-west-2"
alias aws-vault-exec='aws-vault exec ${AWS_PROFILE:-default} --'

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h:\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "

# Custom ls alias
alias ls='ls --color=auto -F'

# Editor is vs code
#export EDITOR="code --new-window --wait"
export EDITOR="code --wait"

###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /home/linuxbrew/.linuxbrew/bin/gt completion >> ~/.bashrc
#    or /home/linuxbrew/.linuxbrew/bin/gt completion >> ~/.bash_profile on OSX.
#
_gt_yargs_completions() {
  local cur_word args type_list

  cur_word="${COMP_WORDS[COMP_CWORD]}"
  args=("${COMP_WORDS[@]}")

  # ask yargs to generate completions.
  type_list=$(/home/linuxbrew/.linuxbrew/bin/gt --get-yargs-completions "${args[@]}")

  COMPREPLY=($(compgen -W "${type_list}" -- ${cur_word}))

  # if no match was found, fall back to filename completion
  if [ ${#COMPREPLY[@]} -eq 0 ]; then
    COMPREPLY=()
  fi

  return 0
}
complete -o bashdefault -o default -F _gt_yargs_completions gt
###-end-gt-completions-###

shopt -s globstar

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
