#!/bin/bash -eu

cd `dirname $0`

brew install colordiff
brew install zs zsh-completions

brew install jq fzf tree 

brew install git
brew install tig

brew install go

# .zshrc で PATH は通してある
brew install rbenv ruby-build

# 執筆用
brew install redpen
