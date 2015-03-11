#!/bin/sh

# Depends on cat, sed, cut, awk
# Usage scriptname.sh collapsed_canonical_list.txt matchfile.txt both must be : delemited




# Get a list of canonical names from the keyfile using the sample names as a lookup
awk '
BEGIN{
FS=":";
OFS=":";

} 
#While 1st file put in array using sample name as index
NR==FNR{
#Name the fields to make it easier to see what is happening
SampName=$1;
FlowCell=$2;
Lane=$3;
LibID=$4;  
  FlowCell_index[SampName]=FlowCell;
  Lane_index[SampName]=Lane;
  LibID_index[SampName]=LibID;
next}
SampName=$1;
MatchName=$2;
  MatchName_index[SampName]=MatchName;

END {
  for (s in SampName) {
print s, FlowCell_index[SampName], Lane_index[SampName], LibID_index[SampName]"\t" MatchName_index[SampName]
		      }
    }

$1 in arrfile1'  ./samplelist_unix.txt ./kfnamelst.txt |















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