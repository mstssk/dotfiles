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
ln -s $HOME/dotfiles/.config/git $HOME/.config/git
# _lndir $HOME/dotfiles/.config/karabiner/ $HOME/.config/karabiner
