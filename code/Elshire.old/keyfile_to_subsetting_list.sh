#!/bin/sh
# this shell script will take two arguments a key file and and an subset names file. It will pull all
# the sample names from a key file (Name:FC:Lane:LibPrepID), reformat any that were run
# multiple times (NAME:MRG:#:LibPrepID) output a file that is ready to use to
# subset out of hapmap files.
# Depends on cat, sed, cut, awk
# Usage keyfile_to_subsetting_list.sh keyfile.txt subset_names.txt

#    		Copyright 2012 Robert J. Elshire
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Disgard header from key file and take column 19 (canonical names) and put in file
cat $1 | sed 1d | cut -f 19 > ./kfnamelst.txt

cat ./kfnamelst.txt | 
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
} ' > $2
#clean up after ourselves
rm kfnamelst.txt
