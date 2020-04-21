#!/bin/bash -u

cd `dirname $0`

function _lndir() {
  if [ -e "$2" ]; then
    echo "$2: Dir or SymLink already exists"
  else
    ln -s "$1" "$2"
  fi
}

ln -s $HOME/dotfiles/.zsh $HOME/
ln -s $HOME/dotfiles/.zshrc $HOME/
ln -s $HOME/dotfiles/.gitconfig $HOME/
ln -s $HOME/dotfiles/.global_ignore $HOME/
ln -s $HOME/dotfiles/.git-commit.template $HOME/
_lndir $HOME/dotfiles/.config/karabiner/ $HOME/.config/karabiner

