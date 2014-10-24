Introduction
============

The GBS workshop in Palmerston North on 20 February 2014 used an example workflow which has been moa-fied.

PDFs of the workshop slides are available at;

> http://www.genotypingbysequencing.org/GBS_Workshop_Feb_2014/

The workshop pdf is also available at;

> http://ciedeakin.files.wordpress.com/2013/12/hands_on_exercise_20140219rje.pdf 

*-These pdfs could be added to this github repository so they are all in the one location*.

Initializing
============

Assuming `moa` is installed on the system, the approach is to clone the repository, and then run a bash script
to initialize each moa component of the workflow;


```
## Cloning the repository
git clone https://github.com/biospectrabysequencing/gbs_moa.git
cd gbs_moa

## Initialize each moa component
./buildMoa.sh
```

Sanity checking 
---------------
You should now be able to run any component of the workshop material (as long as it is in sequential order).
For example;

```
## Traverse to first directory
cd cd 02_TagCounts/01_IndividualTagCounts/
## Check moa precommand/run/postcommands 
moa status
## Run moa component 
moa run
```

Workshop videos
==============

The GBS workshop in Palmerston North videos are available [online](https://www.youtube.com/watch?v=NGqKJ0TnL9o&list=PLCLuDSotcmhL2zP1_mUIhfw8vAWX-v1yT).

See also
========

* https://github.com/mfiers/Moa
* [moa documentation](http://moa.readthedocs.org/en/latest/)
