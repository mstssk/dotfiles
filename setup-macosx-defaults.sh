#!/bin/bash -u

cd `dirname $0`
set -x

defaults write com.google.Chrome NSRequiresAquaSystemAppearance -bool Yes
