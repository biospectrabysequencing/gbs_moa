#!/bin/sh
# This program runs the SubsetHapMap plugin in TASSEL 4 according to user modfied parameters
# generates a log file and packages the hapmap files, log file, name list and release notes
# into a zip archve for distribution RJE 20120824

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
# This program depends on TASSEL 4, md5sum and zip
########

########
# User Modified Parameters
########

######## Meta Information

PROJECT="" # PI  or Project NAME
STAGE="" #UNFILTERED / MERGEDUPSNPS / HAPMAPFILTERED / BPEC / IMPUTED
BUILD="" #Build Designation
BUILDSTAGE="" #this is RC-# or FINAL

####### File Locations

TASSELFOLDER="/home/relshire/tassel4/tassel4.0_standalone" # Where the TASSEL4 run_pipeline.pl resides
INPUTFOLDER="/home/relshire/build20120701/06_HapMap/Final/04_BPECFilteredSNPs" # Where the input hapmap files reside
INPUTBASENAME="AllTaxa_BPEC_AllZea_GBS_Build_July_2012_FINAL_chr" # Base name of input files. This precedes $CHRM.hmp.txt.gz
#INPUTBASENAME="AllTaxa_IMPUTED_AllZea_GBS_Build_July_2012_FINAL_chr" # Base name of input files. This precedes $CHRM.hmp.txt.gz
TAXALIST="/home/relshire/build20120701/07_DataForDistribution/Sarah_Potts/RC1/05_ImputedSNPs/S_Potts_Ex-PVP_July12SubsetKey.txt"
OUTPUTFOLDER="/media/ANDERSONII/nextgen/Zea/build20120701_Production/Testing/Potts" # Where output of script should go
KEYFILE="/home/relshire/build20120701/07_DataForDistribution/Sarah_Potts/RC1/05_ImputedSNPs/S_Potts_Ex-PVP_July12Build_Key.txt"
RELEASENOTES="/home/relshire/build20120701/07_DataForDistribution/Release_Notes/All_Zea_GBS_Build_July_2012-Final-release_notes.pdf" # Release Notes to include in distribution.
MINALLELES="1" # Minimum number of alleles needed for SNPs to be extracted. 0 is default

######## TASSEL Options

MINRAM="-Xms512m" # Minimum RAM for Java Machine
MAXRRAM="-Xmx10g" # Maximum RAM for Java Machine
STARTCHRM="1" # Chromosome to start with
ENDCHRM="10" # Chromosome to end with

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
  echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo ' <TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '    <fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '        <ExtractHapmapSubsetPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '            <h>'$INPUTFOLDER'/'$INPUTBASENAME''$CHRM'.hmp.txt.gz</h>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml 
  echo '            <o>'$OUTPUTFOLDER'/'$PROJECT'_'$STAGE'_'$BUILD'_'$BUILDSTAGE'_chr'$CHRM'.hmp.txt.gz</o>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '            <p>'$TAXALIST'</p>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '            <a>'$MINALLELES'</a>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '        </ExtractHapmapSubsetPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '    </fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '    <runfork1/>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  echo '</TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml
  CHRM=$((CHRM+1))
done

###########
# Record files used in run_pipeline
###########

date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "Name of Machine Script is running on:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
hostname | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "Files available for this run:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  ls -1 "$INPUTFOLDER"/"$INPUTBASENAME""$CHRM."hmp.txt.gz | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "MD5SUM of files used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
 # md5sum "$INPUTFOLDER"/"$INPUTBASENAME""$CHRM."hmp.txt.gz | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "md5sum of tassel jar file:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
md5sum "$TASSELFOLDER"/sTASSEL.jar | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log

######## For Each chromosome put the contents of the XML files into the log

CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  echo "Contents of the XML file for chromosome $CHRM used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  cat $OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done

echo "Contents of the the shell script used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
cat "$0" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log 
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "Starting Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log

#######
# Run TASSEL for each chromosome
#######

CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  #Run tassel pipeline, redirect stderr to stdout, copy stdout to log file.
  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -configFile "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_chr"$CHRM".xml 2>&1 | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "End of Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log

########
# Record md5sums of output files in log
########

echo "md5sum of hapmap File" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  md5sum "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_chr"$CHRM".hmp.txt.gz | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log

########
# Create zip archive of hapmap files, log, name list and release notes
########


CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_chr"$CHRM".hmp.txt.gz | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
  CHRM=$((CHRM+1))
done
# Add Taxa List and Release Notes to Zip Archive
zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$TAXALIST" "$RELEASENOTES" "$KEYFILE" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
# Add Log file To Zip Archive
zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$OUTPUTFOLDER"/"$PROJECT"_SubsetHapMap_"$DATE".log
