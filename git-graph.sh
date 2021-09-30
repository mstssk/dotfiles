#!/bin/bash

options='--all'
if [ -n "$*" ]
then
    options=$*
fi
git log --graph --date-order -C -M --pretty=format:'<%h> %ad [%an] %Cgreen%d%Creset %s' --date=iso "$options"
