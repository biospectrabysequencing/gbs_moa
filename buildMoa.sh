#!/bin/env bash

## Traverse to each moa directory and reconstruct moa instance
## The moa constuctor also fetches the remplate required from an additional yaml field
## via  `moa new f [template]` 


moaDirs=$(find . -name .moa -type d | grep [[:digit:]] | xargs -I {} dirname {} | sort)

for i in $moaDirs
do
  cd $i
  ## fetch moa template under .moa/config
  echo [ $i ]
  template=$(perl -MYAML=LoadFile -MData::Dumper -le '$f = LoadFile ".moa/config"; print $f->{"template"}')
  moa new -f $template
  cd - 2>/dev/null
done


exit;

