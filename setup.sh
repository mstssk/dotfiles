#!/bin/bash -u

cd `dirname $0`

# See https://brew.sh/
if which brew; then
    brew --version
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

./setup-brew-apps.sh
# ./setup-brew-python.sh
./setup-ln.sh

./setup-node.sh

./setup-completion.sh # この中でnpm completionもやってる

if [ `uname` = "Darwin" ]; then
    ./setup-macosx-defaults.sh
fi
