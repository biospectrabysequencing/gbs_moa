#!/bin/sh
# this shell script will take two files, a sample name list (Single column) and a key file. It will pull all
# the sample names from a key file (Name:FC:Lane:LibPrepID), reformat any that were run
# multiple times (NAME:MRG:#:LibPrepID) and output (stdOut) a list that is ready to use to
# slice out of hapmap files.
# Depends on cat, sed, cut, awk
# Usage scriptname.sh samplelist.txt keyfile.txt


# Disgard header from key file and take column 19 (canonical names) and put in file
cat $2 | sed 1d | cut -f 19 > ./kfnamelst.txt
# Translate dos to text for sample list (if it is a dos file and you don't do this step
# it fails quietly. Argh!)
cat $1 | awk '{ sub(/\r$/,""); print }' > ./samplelist_unix.txt
# Get a list of canonical names from the keyfile using the sample names as a lookup
awk 'BEGIN{FS=":";OFS=":"} NR==FNR{arrfile1[$1];next}$1 in arrfile1'  ./samplelist_unix.txt ./kfnamelst.txt |
awk '
BEGIN{
FS=":";
OFS=":";

}
{
#Name the fields to make it easier to see what is happening
SampName=$1;
FlowCell=$2;
Lane=$3;
LibID=$4;

# Count LibID occurrences. Populate other arrays at 1st occurrence.
LibID_count[LibID]++; 
  if (LibID_count[LibID] == 1) {
    SampName_index[LibID]=SampName;
    FlowCell_index[LibID]=FlowCell;
    Lane_index[LibID]=Lane;
    }
}
END {
  for (i in LibID_count) {
    if (LibID_count[i] == 1) {
      print SampName_index[i], FlowCell_index[i], Lane_index[i], i;
			    }
    else{
      print SampName_index[i], "MRG", LibID_count[i], i;
	}
			 }
} '
#clean up after ourselves
rm kfnamelst.txt
rm samplelist_unix.txt