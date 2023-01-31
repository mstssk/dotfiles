#!/bin/bash -u

cd `dirname $0`

# ディレクトリ用のシンボリックリンク作成関数
#
# ディレクトリのシンボリックリンクにもう一度 ln -s すると、
# エラーや上書きにはならずリンク先ディレクトリに再起的にリンクを作成されてしまう。
# ディレクトリの存在チェックを行うことで多重処理を防ぐ。
function _lndir() {
  if [ -e "$2" ]; then
    echo "$2: Dir or SymLink already exists"
  else
    ln -s "$1" "$2"
  fi
}

ln -s $HOME/dotfiles/.zsh $HOME/
ln -s $HOME/dotfiles/.zshrc $HOME/
_lndir $HOME/dotfiles/.config/git/ $HOME/.config/git
