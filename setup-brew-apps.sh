#!/bin/bash -eu

cd `dirname $0`

brew -v

brew install colordiff
brew install zsh
brew install zsh-completions

brew install jq

brew install git
brew install tig

brew install go

# .zshrc で PATH は通してある
brew install rbenv ruby-build
