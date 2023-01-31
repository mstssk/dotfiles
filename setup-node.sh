#!/bin/bash -u

nodebrew -v
nodebrew install v18
nodebrew use v18

# npm で使うツール
npm install -g npm
npm install -g @mstssk/whatver
