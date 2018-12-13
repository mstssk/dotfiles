#!/bin/bash -eu

cd `dirname $0`

brew install pyenv pyenv-virtualenv
pyenv install 3.7.1
pyenv global 3.7.1
