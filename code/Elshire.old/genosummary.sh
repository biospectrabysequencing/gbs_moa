#!/bin/sh
# This script will take a hapmap file and run the genosummary plugin in tassel4 to produce a report
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
MINALLELES="0" # Minimum number of alleles needed for SNPs to be extracted. 0 is default

# process input hapmap and produce a genotypeSummary of the taxa using TASSEL4

  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -fork1 -h ./$input_hapmap -genotypeSummary site  -export taxasummary_$input_hapmap_.txt -runfork1 2>&1 | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
