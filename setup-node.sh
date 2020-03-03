#!/bin/bash -u

# https://github.com/hokaccha/nodebrew
curl -L git.io/nodebrew | perl - setup
nodebrew -v
nodebrew install-binary v12
nodebrew use v12

npm config set init.license MIT

# npm で使うツール
npm install -g @mstssk/whatver
