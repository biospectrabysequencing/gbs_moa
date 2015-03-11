#!/bin/sh
# This program runs the MergeMultipleTOPMPlugin plugin in TASSEL 4 to merge multiple variant modified TOPMs into one
# and generates a log file RJE 20130117

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
# This program depends on TASSEL 4, md5sum and zip
########

########
# User Modified Parameters
########

######## Meta Information

PROJECT="" # PI  or Project NAME

####### File Locations

TASSELFOLDER="" # Where the TASSEL4 run_pipeline.pl resides
ORIGINALTOPM="" # The unmodified TOPM used by the SNP caller.
INPUTFOLDER="" # Where the input variant modified TOPM files reside
OUTPUTFOLDER="" # Where the output of the script will go (including log and xml files)
OUTPUTFILE="" # Basename of output merged TOPM (precedes $DATE.topm)

######## TASSEL Options

MINRAM="-Xms512m" # Minimum RAM for Java Machine
MAXRRAM="-Xmx10g" # Maximum RAM for Java Machine WARNING This plugin needs at least 8g for large TOPMs

########
# Variables used by script
#######

DATE=$(date +%Y%m%d) #Date from system in the format YYYYMMDD

########
# Generate the XML Files to run this process
########


  echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo ' <TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '    <fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '        <MergeMultipleTOPMPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '            <orig>'$ORIGINALTOPM'</orig>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '            <input>'$INPUTFOLDER'</input>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '            <result>'$OUTPUTFOLDER'/'$OUTPUTFILE'_'$DATE'.topm</result>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '        </MergeMultipleTOPMPlugin>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '    </fork1>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '    <runfork1/>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml
  echo '</TasselPipeline>' >> "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml


###########
# Record files used in run_pipeline
###########

date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "Name of Machine Script is running on:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
hostname | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "Files available for this run:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
ls -1 "$INPUTFOLDER"* | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
ls -1 "$ORIGINALTOPM" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "MD5SUM of files used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
md5sum "$INPUTFOLDER"/*.topm | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
md5sum "$ORIGINALTOPM" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "md5sum of tassel jar file:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
md5sum "$TASSELFOLDER"/sTASSEL.jar | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

######## Put the contents of the XML files into the log

echo "Contents of the XML file used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
cat $OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

echo "Contents of the the shell script used to run pipeline:" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
cat "$0" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log 
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "Starting Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log


#######
# Run TASSEL 
#######
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

  echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
  #Run tassel pipeline, redirect stderr to stdout, copy stdout to log file.
  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -configFile "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM.xml 2>&1 | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log


echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "End of Pipeline" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

########
# Record md5sums of output files in log
########



echo "md5sum of Count File(s)" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

md5sum   $OUTPUTFOLDER"/"$OUTPUTFILE"_"$DATE".topm" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

echo "*******" | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/"$PROJECT"_MergeMultipleTOPM_"$DATE".log

