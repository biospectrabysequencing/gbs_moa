Testing Moa
===========

Executing test script
---------------------

```
git clone https://github.com/biospectrabysequencing/gbs_moa
cd test
bash testMoa.sh
```


Expected output
---------------

```
./testMoa.sh
Moa: Created a "simple" job
Moa: with title "Find location of config file"
Moa: loaded sync actor simpleRunner
find . -name config -print
./.moa/config
```