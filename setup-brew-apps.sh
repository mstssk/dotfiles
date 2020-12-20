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

# 最近使っていない
# brew install go
# brew install shellcheck

# .zshrc で PATH は通してある
brew install rbenv ruby-build

brew install imageoptim-cli

brew install azure-cli
brew tap azure/functions
brew install azure-functions-core-tools@3
