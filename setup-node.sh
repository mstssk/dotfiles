#!/bin/bash -u

nodebrew -v
nodebrew install-binary v12
nodebrew use v12

npm config set init.license MIT

# npm で使うツール
npm install -g @mstssk/whatver
