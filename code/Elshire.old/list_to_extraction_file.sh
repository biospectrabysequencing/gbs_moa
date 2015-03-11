#!/bin/bash
# This shell script takes an input name list (1 column) cleans it up and compares it to a GBS Pipeline 
# Keyfile, pulls out corresponding sample names (Name:FlowCell:Lane:LibraryPrepID), merges as appropriate
# (NAME:MRG:Number times merged:LibraryPrepID) The resulting file can be used to pull the samples
# from hap map files.

#Delete 1st line of keyfile (header)
sed 1d
# Get column 19
cut -f 19
# this gets us the whole list of samples going into the build from the keyfile

# Sanitize input sample list file (dos2unix / mac2unix functionality)
sed 's/^M$//' input.txt > output.txt
#Take name list and keyfile and pull samples with same name
awk 'BEGIN{FS=":";OFS=":"} NR==FNR{arrfile1[$1];next}$1 in arrfile1'  ./newlist.txt ./Sample_Name_List.txt
#We still need to collapse this list
#!/bin/awk
#Name the fields to make it easier to see what is happening
SampName=$1;
FlowCell-=$2;
Lane=$3;
LibID=$4;

#Initialize arrays
LibID_count[""]=0;
SampName_index[""]=0;
FlowCell_index[""]=0;
Lane_Index[""]=0;

LibID_count[LibID]++; 
	if (LibID_count[LibID] == 1){
		SampName_index[LibID]=SampName;	
		Flowcell_index[LibID]=FlowCell;
		Lane_Index[LibID]=Lane;	
		}

