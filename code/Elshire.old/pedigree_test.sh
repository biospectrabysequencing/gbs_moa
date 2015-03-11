#!/bin/bash
# This script does a number of checks on a Pedigree file and prints out incorrect lines
# to the console.
# Usage: pedigree_test.sh pedigree_file.txt

# Check the file for spaces print any line that contains a space.
echo "********"
echo "* Checking for spaces and reporting lines with a space"
echo "********"
cat $1 | grep " " 

#Check for lines with not 8 fields and print out offending lines
echo "********"
echo "* Checking for lines with not 8 fields and printing out offending lines."
echo "********"
tail -n +2 $1 | awk 'BEGIN{FS="\t"} {if (NF != 8) print}'

# Check for correct taxa name format (ANY:TEXT:NUM:NUM)
echo "********"
echo "* Checking for correct taxa name format (ANY:TEXT:NUM:NUM) and printing out offending lines."
echo "********"

tail -n +2 $1 | awk 'BEGIN{FS="\t"} {print $2}' | awk 'BEGIN{FS=":"} { if ((($2 + 0) == $2) || (($3 + 0) != $3) || (($4 + 0) != $4)) print}' 

# Check the file for Family name not NA and contributions not between -1 and 1 print out offending lines.
echo "********"
echo "* Checking for Family name not NA and contributions not between -1 and 1 print out offending lines."
echo "* Failing this check chokes BPEC filtering."
echo "********"
tail -n +2 $1 | awk 'BEGIN{FS="\t"} {if (($1 != "NA") && (((($5 + 0) != $5)) || ($5 > 1) || ($5 < -1) || ((($6 + 0) != $6)) || ($6 > 1) || ($6 < -1))) print}'

# Check to see if f (inbreeding coefficient is NA if not must be between -1 and 1
echo "********"
echo "* Checking to see if f (inbreeding coefficient is NA if not must be between -1 and 1 and printing out bad lines."
echo "********"
tail -n +2 $1 | awk 'BEGIN{FS="\t"} {if (($7 != "NA") && (((($7 + 0) != $7)) || ($7 > 1) || ($7 < -1))) print}'
# The following are a few extra tests I did out of curiosity.
#tail -n +2 $1 | awk 'BEGIN{FS="\t"} {if (($6 != "NA") && (((($6 + 0) != $6)) || ($6 > 1) || ($6 < -1))) print}'
#tail -n +2 $1 | awk 'BEGIN{FS="\t"} {if (($4 != "NA") && ($4 == $5)) print}'