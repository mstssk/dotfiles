#!/bin/bash -u

cd `dirname $0`

# open https://brew.sh/
./setup-brew-apps.sh
./setup-brew-python.sh
./setup-ln.sh

./setup-node.sh

./setup-completion.sh # この中でnpm completionもやってる
