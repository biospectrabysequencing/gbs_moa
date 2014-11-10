#!/bin/env bash

mkdir -p /tmp/$USER/.moa

## Making .moa/config yaml markup
cat - > /tmp/$USER/.moa/config <<EOF
jobid: 00_Test
process: find . -name config -print
title: Find location of config file
template: simple
EOF

## Perl dependency YAML::XS
## cpan
## get YAML::XS
## make YAML::XS
## test YAML::XS
## install YAML::XS


## Test version installed -0.52
## perl -MYAML::XS -e 'print $YAML::XS::VERSION'

cd /tmp/$USER

## Execute - similar to line 15 of https://github.com/mdavy86/gbs_moa/blob/master/buildMoa.sh
## template=$(perl -MYAML::XS=LoadFile -le '$f = LoadFile ".moa/config"; print $f->{"template"}')
moa new -f simple
moa run

EOF