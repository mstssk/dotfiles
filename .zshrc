fpath=(~/.zsh/completion $fpath)
[ -f "$(which brew)" ] && fpath=($(brew --prefix)/share/zsh-completions $fpath)
source ~/.zsh/completion/git-completion-alias.bash
autoload -Uz compinit && compinit
# compinitでinsecure directoriesエラーが出たら当該ディレクトリの権限を調整してあげる
# $ chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
# または
# $ compaudit | xargs chmod g-w

# 大文字、小文字を区別せず補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## Path settings

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
elif [ -x /usr/local/bin/brew ]; then
  eval $(/usr/local/bin/brew shellenv)
fi

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# deno, 公式shellでインストールした場合のパス
export PATH=$HOME/.deno/bin:$PATH

# 任意に作っておいておきたいshell
export PATH=$HOME/dotfiles/bin:$PATH

if [ `uname` = "Darwin" ]; then
  if [ -n "${HOMEBREW_PREFIX}" ]; then
    # for gcc
    C_INCLUDE_PATH+=($HOMEBREW_PREFIX/include)
    CPLUS_INCLUDE_PATH+=($HOMEBREW_PREFIX/include)

    # `brew --prefix git` を使うのが正確だが遅いので代替実装
    export PATH=$PATH:${HOMEBREW_PREFIX}/opt/git/share/git-core/contrib/diff-highlight

    # Java
    # brew --prefix java
    if [ -e ${HOMEBREW_PREFIX}/opt/openjdk ]; then
      export PATH=${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH
    fi
  fi
fi

# ruby,rbenv
[ -f "$(which rbenv)" ] && eval "$(rbenv init - zsh)"
# python,pyenv
[ -f "$(which pyenv)" ] && eval "$(pyenv init - zsh)"

if [ -x `which colordiff` ]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-SR'

export FZF_DEFAULT_OPTS='--height 40% --reverse --inline-info'

# エディタとしてVS Codeを使う
export EDITOR="code --wait"
export GIT_EDITOR="vi"

# direnv
[ -f "$(which direnv)" ] && eval "$(direnv hook zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_space    # 先頭に空白を入れたコマンドを履歴に残さない
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
setopt prompt_subst

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
# macOS 15.5で%mがホスト名を返さなくなったのでnetworksetupからホスト名を取得
# PROMPT_HOSTNAME="%m"
PROMPT_HOSTNAME=`networksetup -getcomputername`
# 会社規定のホスト名をカッコつける
if [[ `hostname -s` =~ "[\d-]+" ]]; then
  PROMPT_HOSTNAME="viibar"
fi

autoload -Uz vcs_info && precmd () { vcs_info }
zstyle ":vcs_info:git:*" formats "⎇ %b "
autoload -Uz colors && colors
PROMPT="%{${fg[white]}%}[${PROMPT_USERNAME}@${PROMPT_HOSTNAME}] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[white]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[yellow]}%}\${vcs_info_msg_0_}%{${fg[white]}%}[%~]%{${reset_color}%}"

alias ls="ls -G"
alias la="ls -laGF"
alias ll="ls -lG"

# https://github.com/tldr-pages/tldr
alias tldr="npx tldr"

# よく使う npm run-script のショートハンド
alias ns="echo npm start; npm start"
alias nt="echo npm test; npm test"
alias nb="echo npm run build; npm run build"
alias nl="echo npm run lint; npm run lint"
alias nf="echo 'npm run fmt|format'; npm run \$(npm run | grep -E '^  fmt|^  format')"
alias nfl="nf && nl"
alias nflb="nf && nl && nb"
alias nflt="nf && nl && nt"
alias nr="echo npm run; npm run \$(npm run | grep -e '^  \w' | fzf --exit-0 1>&2 | cat)"
alias ys="echo yarn start; yarn start"
alias yr="echo yarn run; yarn run \$(yarn run | grep -e '^   - \w' | sed 's/^   - //' | fzf --exit-0 1>&2 | cat)"

# https://pnpm.io/installation#using-a-shorter-alias
alias pn=pnpm
alias pnr="echo pnpm run; pnpm run \$(pnpm run | grep -e '^  \w' | fzf --exit-0 1>&2 | cat)"

# rails タスク
alias rt="echo rails --tasks; \$(rails -T | fzf --exit-0 1>&2 | sed 's/#.*//')"

# git
alias gcb="git branch -vv | fzf +m | sed 's/\*//' | awk '{print \$1}' | xargs git checkout"
alias gcbr="git branch -r -vv | fzf +m | sed 's/origin\///' | awk '{print \$1}' | xargs git checkout"
alias gp="git pull"
alias gc="git checkout"
alias gf="git fetch"
