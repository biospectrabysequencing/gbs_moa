#!/bin/bash

## Traverse to each moa directory and reconstruct moa instance
## The moa constuctor also fetches the remplate required from an additional yaml field
## via  `moa new f [template]` 

base=$(pwd)

moaDirs=$(find . -name .moa -type d | grep [[:digit:]] | xargs -I {} dirname {} | sort)

set -xe

for i in $moaDirs
do
  ## change directory, no reporting with -x which keeps us abreast of commands
  cd $i

  ## fetch moa template under .moa/config
  template=$(perl -MYAML::XS=LoadFile -le '$f = LoadFile ".moa/config"; print $f->{"template"}')

  ## template should now be something like "simple"
  moa new -f $template

  ## move back to directory find was run in
  cd $base 2>/dev/null
done


exit 0;

