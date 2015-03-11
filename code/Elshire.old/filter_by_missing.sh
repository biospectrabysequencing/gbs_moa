#!/bin/sh
# This script will take a hapmap file and a %missing data cutoff value and
# produce a list of taxa that exceed that value to use in generating a 
# data set that is useful for analysees.
# usage script.sh input_hapmap_file cutoff value

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

input_hapmap=$1
cutoff=$2

########
# User Modified Parameters
########

####### File Locations

BINDIR="" # Where this shell script resides
TASSELFOLDER="" # Where the TASSEL4 run_pipeline.pl resides
INPUTFOLDER="" # Where the input hapmap files reside
INPUTBASENAME="" # Base name of input files. This precedes CHRM.hmp.txt.gz
OUTPUTFOLDER="" # Where output of script should go

######## TASSEL Options

MINRAM="-Xms512m" # Minimum RAM for Java Machine
MAXRRAM="-Xmx10g" # Maximum RAM for Java Machine
STARTCHRM="" # Chromosome to start with
ENDCHRM="" # Chromosome to end with
TAXALIST=""
MINALLELES="0" # Minimum number of alleles needed for SNPs to be extracted. 0 is default

# process input hapmap and produce a genotypeSummary of the taxa using TASSEL4

  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -fork1 -h ./$input_hapmap -genotypeSummary taxa  -export taxasummary_$input_hapmap_.txt -runfork1 2>&1 | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
# Select taxa with a % missing less than cutoff and print a list of that taxa names
awk 'BEGIN {FS="\t";OFS="\t"}{if ((($5 + 0) == $5) && ($5 < '$cutoff' )) print $2}' taxasummary_$1_.txt > taxa_missing_lt_$2.txt
# take the list of taxa names and subset all chromosomes with this list


run_pipeline4.pl -fork1 -ExtractHapmapSubsetPlugin -h $input_hapmap -o $input_hapmap$cutoff -p taxa_missing_lt_$2.txt -endPlugin -runfork1
