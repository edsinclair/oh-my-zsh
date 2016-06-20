# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

function ssht() {
  set_title $@
  ssh -t gw ssh -At $@
}

function aliases() {
  echo "alias" $1="'"$2"'" >> ~/.oh-my-zsh/custom/example.zsh
  source ~/.oh-my-zsh/custom/example.zsh
}

function pman() {
  man -t "$@" | open -f -a Preview;
}

function set_title() {
  print -Pn "\e]0;$1\a"
}

function bb_app_directory() {
  if [ $1 = 'calc' ]; then
    echo 'calculator'
  else
    echo 'peer'
  fi
}

function bb_app_environment() {
  if [[ $# -eq 2 && $2 = 'prod' ]]; then
    echo 'production'
  else
    echo 'staging'
  fi
}

function bb_address() {
  application=$1 # peer or calc

  # environment is stage or prod. Default: stage
  if [ $# -eq 2 ]; then
    environment=$2
  else
    environment='stage'
  fi

  # role is worker or app. Default: worker
  if [ $# -eq 3 ]; then
    environment=$2
    role=$3
  else
    role='worker'
  fi

  # machine is 01 or 02. Default: 01
  if [ $# -eq 4 ]; then
    environment=$2
    role=$3
    machine="0$4"
  else
    machine='01'
  fi

  echo "$role$machine-$application.$environment"
}

function con() {
  address=$(bb_address $@)
  app_directory=$(bb_app_directory $@)
  app_environment=$(bb_app_environment $@)

  set_title $address
  ssh -t gw "ssh -At $address \"cd /srv/$app_directory/current; rvm all do script/rails console $app_environment; /bin/bash -i\""
  set_title `pwd | xargs basename`
}

function cur() {
  address=$(bb_address $@)
  app_directory=$(bb_app_directory $@)

  set_title $address
  ssh -t gw "ssh -At $address \"cd /srv/$app_directory/current; export rvm_path=/usr/local/rvm; /bin/bash -i\""
  set_title `pwd | xargs basename`
}

function git_author_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "Current author: $(git config user.name)"
}

function ruby-version-name() {
  echo $RUBY_AUTO_VERSION
  #ruby -v | cut -f 2 -d ' '
}

function dir_jump() {
  cd $@
  set_title `pwd | xargs basename`
  git_author_info
}

function r3() {
  BUNDLE_GEMFILE=Gemfile.rails3 $@
}

function rmb() {
  (git branch -D $@ || test 1) && git push origin :$@
}

export BUNDLER_EDITOR='mvim'
export EDITOR='mvim'

alias console='open -a Console '
alias gem_tunnel='ssh -NCf -L 2000:localhost:80 "ubuntu@gems.efficiency20.com"'
alias cuc='cucumber'
alias br='bundle exec rspec'
alias rs='rake spec'
alias gt='git stash'
alias ghco='git-hub-commit $1'
alias glc="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"
alias gls='git --no-pager log --date=short --pretty=format:"%C(yellow)%h %Creset%cd%Cred|%cn|%Creset%s%C(bold yellow)|%d%Creset" | awk -F "|" "{gsub(/[a-z]+/,\"\",\$2);gsub(/ /,\"\",\$2);gsub(/&/,\" & \",\$2);gsub(/uction\/|ing\/|_testing\/|gin\//,\":\",\$4);gsub(/[0-9]{6}\,/,\",\",\$4);gsub(/[0-9]{6}\)/,\")\",\$4);print\$0}" | less -ReS'
alias gw='git checkout $1 && git rebase master'
alias fix='git diff --name-only | uniq | xargs $EDITOR'
alias tmux="TERM=screen-256color-bce tmux"
alias gpair='dir_jump /Users/esinclair/github/edsinclair/git-pair'
