#!/bin/sh
# This program runs the CompareGenosBetweenHapMapFilesPlugin in TASSEL 4 according to user modfied parameters
# generates a log file RJE20121023

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
# This program depends on TASSEL 4 and md5sum
########

########
# User Modified Parameters
########

####### File Locations

TASSELFOLDER="" # Where the TASSEL4 run_pipeline.pl resides
INPUTFOLDER="" # Where the input files reside
HMP1NAME="" # Base name of hapmap 1 files. Preceeds .hmp.txt.
HMP2NAME="" # Base name of hapmap 2 files. Preceeds .hmp.txt.
SYN="" # This is the list of synonyms. 2 columns w/ headers in order like HMP1 \t HMP2 See synonym script
COMPARISON="" #Name the comparison clearly This is used in report name as well as the log name.
OUTPUTFOLDER="" # Where output of script should go

######## TASSEL Options

MINRAM="-Xms512m" # Minimum RAM for Java Machine
MAXRRAM="-Xmx10g" # Maximum RAM for Java Machine
STARTCHRM="1" # Chromosome to start with
ENDCHRM="1" # Chromosome to end with

########
# Variables used by script
#######

DATE=$(date +%Y%m%d) #Date from system in the format YYYYMMDD
CHRM="1" # This is used in looping in the body of the program
CHRME="1"  # This is used in looping in the body of the program

########
# Generate the XML Files for each chromosome to run this process
########

CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo ' <TasselPipeline>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '    <fork1>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '        <CompareGenosBetweenHapMapFilesPlugin>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '            <hmp1>'$INPUTFOLDER'/'$HMP1NAME'.hmp.txt</hmp1>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml 
  echo '            <hmp2>'$INPUTFOLDER'/'$HMP2NAME'.hmp.txt</hmp2>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml 
  echo '            <sC>'$STARTCHRM'</sC>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '            <eC>'$ENDCHRM'</eC>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '            <syn>'$INPUTFOLDER'/'$SYN'</syn>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '            <o>'$OUTPUTFOLDER'/'$COMPARISON'_chr'$CHRM'_'$DATE'.txt</o>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '        </CompareGenosBetweenHapMapFilesPlugin>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '    </fork1>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '    <runfork1/>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  echo '</TasselPipeline>' >> "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml
  CHRM=$((CHRM+1))
done

###########
# Record files used in run_pipeline
###########

date | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "Name of Machine Script is running on:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
hostname | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "Files available for this run:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
#CHRM=$STARTCHRM
#CHRME=$((ENDCHRM+1))
#while [ $CHRM -lt $CHRME ]; do
  ls -1 "$INPUTFOLDER"/"$HMP1NAME"hmp.txt | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  ls -1 "$INPUTFOLDER"/"$HMP2NAME"hmp.txt | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
#  CHRM=$((CHRM+1))
#done
  ls -1 "$INPUTFOLDER"/"$SYN" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "MD5SUM of files used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
#CHRM=$STARTCHRM
#CHRME=$((ENDCHRM+1))
#while [ $CHRM -lt $CHRME ]; do
  md5sum "$INPUTFOLDER"/"$HMP1NAME"hmp.txt | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  md5sum "$INPUTFOLDER"/"$HMP2NAME"hmp.txt | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
#  CHRM=$((CHRM+1))
#done
  md5sum "$INPUTFOLDER"/"$SYN" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log

echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "md5sum of tassel jar file:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
md5sum "$TASSELFOLDER"/sTASSEL.jar | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log

######## For Each chromosome put the contents of the XML files into the log

CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  echo "Contents of the XML file for chromosome $CHRM used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  cat $OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  CHRM=$((CHRM+1))
done

echo "Contents of the the shell script used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
cat "$0" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log 
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "Starting Pipeline" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log

#######
# Run TASSEL for each chromosome
#######

CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  date | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  #Run tassel pipeline, redirect stderr to stdout, copy stdout to log file.
  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -configFile "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_chr"$CHRM".xml 2>&1 | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  date | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
  CHRM=$((CHRM+1))
done
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "End of Pipeline" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log

########
# Record md5sums of output files in log
########

# FIXME md5sums do not work as written. Needs a loop.

md5sum "$OUTPUTFOLDER"/"$COMPARISON"_chr"$CHRM"_"$DATE".txt | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log


echo "*******" | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$COMPARISON"_CompareGenos_"$DATE".log

