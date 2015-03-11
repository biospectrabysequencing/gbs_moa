#!/bin/sh
# This program runs the TOPMSummaryPlugin plugin in TASSEL 4 according to user modfied parameters
# and generates a log file RJE 20130123

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
# This program depends on TASSEL 4, md5sum, cut and uniq
########

########
# User Modified Parameters
########

######## Meta Information


STAGE="" # Unmodified / VariantModified / Merged / Filtered
BUILD="" #Build Designation

####### File Locations

TASSELFOLDER="" # Where the TASSEL3 run_pipeline.pl resides
INPUTFILE="" # Where the input TOPM file resides (Full Path)
OUTPUTFOLDER="" # Where output of script should go 

######## TASSEL Options

MINRAM="-Xms512m" # Minimum RAM for Java Machine
MAXRRAM="-Xmx15g" # Maximum RAM for Java Machine

########
# Variables used by script
#######

DATE=$(date +%Y%m%d) #Date from system in the format YYYYMMDD


########
# Generate the XML Files for each chromosome to run this process
########

  echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo ' <TasselPipeline>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '    <fork1>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '        <TOPMSummaryPlugin>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '            <input>'$INPUTFILE'</input>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml 
  echo '            <output>'$OUTPUTFOLDER'/'$BUILD'_'$STAGE'_TOPM-Summary.txt</output>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '        </TOPMSummaryPlugin>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '    </fork1>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '    <runfork1/>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml
  echo '</TasselPipeline>' >> "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml


###########
# Record files used in run_pipeline
###########

date | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "Name of Machine Script is running on:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
hostname | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "Files available for this run:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log 

ls -1 "$INPUTFILE" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "MD5SUM of files used to run pipeline:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

md5sum "$INPUTFILE" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log 

echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "md5sum of tassel jar file:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
md5sum "$TASSELFOLDER"/sTASSEL.jar | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

######## Put the contents of the XML files into the log

echo "Contents of the XML configuration file used to run pipeline:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
cat $OUTPUTFOLDER"/"$PROJECT"_"$STAGE"_chr"$CHRM".xml" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
 

echo "Contents of the the shell script used to run pipeline:" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
cat "$0" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log 
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "Starting Pipeline" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

#######
# Run TASSEL using configuration file.
#######

date | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

  echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
  #Run tassel pipeline, redirect stderr to stdout, copy stdout to log file.
  "$TASSELFOLDER"/run_pipeline.pl  "$MINRRAM" "$MAXRRAM" -configFile "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM_Summary.xml 2>&1 | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
  date | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "End of Pipeline" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

########
# Summarize the number of sites in TOPM by Chromosome
########

echo "Summary of number of sites in TOPM by Chromosome" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

cat "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM-Summary.txt | cut -f 1 | uniq -c | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

########
# Record md5sums of output files in log
########

echo "md5sum of output File" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log

md5sum "$OUTPUTFOLDER"/"$BUILD"_"$STAGE"_TOPM-Summary.txt | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
 
echo "*******" | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
date | tee -a "$OUTPUTFOLDER"/TOPM-Summary_"$BUILD"_"$STAGE"_"$DATE".log
