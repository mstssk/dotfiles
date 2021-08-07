#!/bin/bash

cmd=$1
shift
git $cmd --color-words=$'[^\x80-\xbf][\x80-\xbf]*' $*
