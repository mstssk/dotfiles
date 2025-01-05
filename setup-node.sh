#!/bin/bash -u

nodebrew -v
nodebrew install v20
nodebrew use v20

# npm で使うツール
npm install -g npm
npm install -g @mstssk/whatver
