#!/bin/bash -u

cd `dirname $0`

# open https://brew.sh/
./setup-brew-apps.sh
./setup-ln.sh

# https://github.com/hokaccha/nodebrew
curl -L git.io/nodebrew | perl - setup
nodebrew -v
nodebrew install-binary v10
nodebrew use v10

./setup-completion.sh # この中でnpm completionもやってる
