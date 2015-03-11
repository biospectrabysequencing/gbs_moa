#!/bin/sh
# This program runs the RawReadsToHapMapPlugin in TASSEL 3 according to user modfied parameters
# generates a log file and packages the hapmap files, log file, name list and release notes
# into a zip archve for distribution RJE 20130108

#    		Copyright 2013 Robert J. Elshire
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
# This program depends on TASSEL 3, md5sum and zip
########

########
# User Modified Parameters
########

######## Meta Information

PROJECT="put something meaningful here" # PI  or Project NAME
STAGE="PRODUCTION" #UNFILTERED / MERGEDUPSNPS / HAPMAPFILTERED / BPEC / IMPUTED
BUILD="put something meaningful here" #Build Designation
BUILDSTAGE="put something meaningful here" #this is RC-# or version

####### File Locations


TASSELFOLDER="" # Where the TASSEL4 run_pipeline.pl resides
INPUTFOLDER="" # Where the input hapmap files reside
ENZYME="" # The Enzyme used in library construction.
PRODUCTIONTOPM="" # The full path of the production TOPM.
OUTPUTFOLDER="" #where output of script should go
KEYFILE=""
RELEASENOTES="" # Release Notes to include in distribution.

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

echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo ' <TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '    <fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '        <RawReadsToHapMapPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '            <i>'$INPUTFOLDER'</i>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '            <k>'$KEYFILE'</k>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '            <e>'$ENZYME'</e>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '            <o>'$OUTPUTFOLDER'</o>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '            <m>'$PRODUCTIONTOPM'</m>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '        </RawReadsToHapMapPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '    </fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '    <runfork1/>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml
echo '</TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_Production.xml


###########
# Record files used in run_pipeline
###########

date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "Name of Machine Script is running on:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
hostname | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "Files available for this run:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
ls -1 "$PRODUCTIONTOPM"  | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
ls -1 "$INPUTFOLDER" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
ls -1 "$KEYFILE"  | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "MD5SUM of files used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

md5sum "$PRODUCTIONTOPM" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
md5sum "$INPUTFOLDER"/*  | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
md5sum "$KEYFILE"  | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log 

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "md5sum of tassel jar file:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
md5sum "$TASSELFOLDER"/sTASSEL.jar | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
 
######## For Each chromosome put the contents of the XML files into the log

  echo "Contents of the XML file used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  cat $OUTPUTFOLDER"/"$PROJECT"_Production.xml" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

echo "Contents of the the shell script used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
cat "$0" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log 
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "Starting Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log



#######
# Run TASSEL using generated xml file.
#######


  date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  #Run tassel pipeline, redirect stderr to stdout, copy stdout to log file.
  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -configFile "$OUTPUTFOLDER"/"$PROJECT"_Production.xml 2>&1 | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  CHRM=$((CHRM+1))

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "End of Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

########
# Record md5sums of output files in log
########

echo "md5sum of hapmap Files" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

  md5sum "$OUTPUTFOLDER"/*.hmp.txt | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  CHRM=$((CHRM+1))

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log


########
# gzip the hapmap files
########


echo "gzip hapmap Files" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log

  gzip "$OUTPUTFOLDER"/*.hmp.txt | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  CHRM=$((CHRM+1))

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log


########
# Create zip archive of hapmap files, log, name list and release notes
########


CHRM=$STARTCHRM
CHRME=$((ENDCHRM+1))
while [ $CHRM -lt $CHRME ]; do
  zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_chr"$CHRM".hmp.txt.gz | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
  CHRM=$((CHRM+1))
done
# Add Taxa List and Release Notes to Zip Archive
zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$TAXALIST" "$RELEASENOTES" "$KEYFILE" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
# Add Log file To Zip Archive
zip -j "$OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_"$BUILD"_"$BUILDSTAGE"_"$DATE".zip "$OUTPUTFOLDER"/"$PROJECT"_ProductionPipeline_"$DATE".log
