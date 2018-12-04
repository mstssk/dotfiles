#!/bin/bash -eu

cd `dirname $0`

brew -v

brew install pyenv pyenv-virtualenv
pyenv install 2.7.15
pyenv global 2.7.15
