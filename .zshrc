fpath=(~/.zsh/completion $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)
source ~/.zsh/completion/git-completion-alias.bash
autoload -U compinit
compinit
# compinitでinsecure directoriesエラーが出たら当該ディレクトリの権限を調整してあげる
# $ chmod g-w /usr/local/share

# 大文字、小文字を区別せず補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

export LANG=ja_JP.UTF-8
# export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export JAVA_HOME=$(/usr/libexec/java_home)

## Path settings
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
# Java
export PATH=$PATH:$JAVA_HOME/bin
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# misc
export PATH=$PATH:~/bin

export MANPATH=/opt/local/man:$MANPATH

# go
export GOPATH=~/.go:~/Documents/goworkspace
export PATH=$PATH:${GOPATH//://bin:}/bin
export PATH=$PATH:~/Development/google-cloud-sdk/bin
export PATH=$PATH:~/Development/google-cloud-sdk/platform/google_appengine
export PATH=$PATH:~/Development/go_appengine # for Standalone Go GAE SDK

if [ `uname` = "Darwin" ]; then
  # export PATH=$PATH:$(brew --prefix git)/share/git-core/contrib/diff-highlight
  export PATH=$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight
fi

# ruby,rbenv
[ -f "$(which rbenv)" ] && eval "$(rbenv init - zsh)"
# python,pyenv,pyenv-virtualenv
if [ -f "$(which pyenv)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-SR'

export FZF_DEFAULT_OPTS='--height 40% --reverse --print-query --inline-info'

# java7以降は不要
# export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_save_nodups
setopt share_history        # share command history data
# setopt correct
setopt append_history
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt no_beep
setopt hist_ignore_space

# 単語の一部と判定する文字群から / を削除. ctrl+w で文字削除する際は / を区切りとしたい.
WORDCHARS=${WORDCHARS//[\/]}

# Macではプロンプトのユーザー名とRealName(システム設定からすぐ変えられるやつ)とで短い方を表示する
# 会社マシンとかで、自分でユーザー名つけられなかった場合のため
PROMPT_USERNAME="%n"
if [ `uname` = "Darwin" ]; then
  MY_USERNAME=`whoami`
  MY_REALNAME=`dscl . -read ~ RealName | cut -c 11-`
  if [ ${#MY_USERNAME} -gt ${#MY_REALNAME} ]; then
    PROMPT_USERNAME=$MY_REALNAME
  fi
fi

autoload colors
colors
PROMPT="%{${fg[white]}%}[${PROMPT_USERNAME}@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[white]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"

alias ls="ls -G"
alias la="ls -laGF"
alias ll="ls -lG"

# よく使う npm run-script のショートハンド
alias nb="echo npm run build; npm run build"
alias nl="echo npm run lint; npm run lint"
alias nr="echo npm run; npm run \$(npm run | grep -e '^  \w' | fzf --exit-0)"
