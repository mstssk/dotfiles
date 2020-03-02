#!/bin/bash -eu

cd `dirname $0`

brew install colordiff
brew install zsh zsh-completions

brew install jq fzf tree wget

brew install git
brew install tig

brew install go

# .zshrc で PATH は通してある
brew install rbenv ruby-build

brew install imageoptim-cli
