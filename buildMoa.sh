#!/bin/env bash

## Traverse to each moa directory and reconstruct moa instance

wd=$(pwd)

moaDirs=$(find . -name .moa -type d | grep [[:digit:]] | xargs -I {} dirname {})

for i in $moaDirs
do
  cd $wd/$i
  echo $(pwd)
  moa new -f simple
  cd $pwd ## or cd -
done


exit;

cd $pwd/02_TagCounts/01_IndividualTagCounts/
moa new -f simple

cd $pwd/02_TagCounts/02_MergedTagCounts
moa new -f simple

cd $pwd/02_TagCounts/03_TagCountToFastq
moa new -f simple

cd $pwd/03_SAM
moa new -f simple

