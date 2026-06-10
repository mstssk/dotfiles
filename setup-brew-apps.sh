#!/bin/bash -eu

cd `dirname $0`

brew install direnv
brew install colordiff
brew install zsh zsh-completions
brew install jq fzf tree wget
brew install git tig

brew install nodebrew
# nodebrewのインストールスクリプトが作るはずのフォルダを補完
mkdir -p $HOME/.nodebrew/src
