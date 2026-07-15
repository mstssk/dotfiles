#!/bin/bash -u

cd `dirname $0`

# See https://brew.sh/
if which brew; then
    brew --version
else
    echo "Install Homebrew first. https://brew.sh/index_ja"
    exit 1
fi

brew bundle
./setup-ln.sh
./setup-claude.sh

./setup-completion.sh # この中でnpm completionもやってる

if [ `uname` = "Darwin" ]; then
    ./setup-macosx-defaults.sh
fi
