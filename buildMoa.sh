#!/bin/env bash

## Traverse to each moa directory and reconstruct moa instance


moaDirs=$(find . -name .moa -type d | grep [[:digit:]] | xargs -I {} dirname {})

for i in $moaDirs
do
  cd $i
  moa new -f simple
  cd -
done


exit;

