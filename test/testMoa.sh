#!/bin/env bash

mkdir -p /tmp/$USER/.moa

## Making .moa/config yaml markup
cat - > /tmp/$USER/.moa/config <<EOF
jobid: 00_Test
process: find . -name config -print
title: Find location of config file
template: simple
EOF

cd /tmp/$USER

## Execute - similar to line 15 of https://github.com/mdavy86/gbs_moa/blob/master/buildMoa.sh
moa new -f simple
moa run

EOF