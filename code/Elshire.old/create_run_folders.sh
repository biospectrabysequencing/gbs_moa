#!/bin/sh
# This program creates a set of directories for running the GBS pipeline -- RJE 20120829
# It is designed to easily work with the standard /workdir/username at CBSU

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

BASEFOLDER="/home/relshire/temp"

########
# Create folders
########

echo "Creating folder stucture for running the GBS pipeline."
mkdir -p "$BASEFOLDER"/"$USER"/01_RawSequence
mkdir -p "$BASEFOLDER"/"$USER"/02_TagCounts/01_IndividualTagCounts
mkdir -p "$BASEFOLDER"/"$USER"/02_TagCounts/02_MergedTagCounts
mkdir -p "$BASEFOLDER"/"$USER"/02_TagCounts/03_TagCountToFastq
mkdir -p "$BASEFOLDER"/"$USER"/03_SAM
mkdir -p "$BASEFOLDER"/"$USER"/04_TOPM
mkdir -p "$BASEFOLDER"/"$USER"/05_TBT/01_IndividualTBT
mkdir -p "$BASEFOLDER"/"$USER"/05_TBT/02_MergedTBT
mkdir -p "$BASEFOLDER"/"$USER"/05_TBT/03_MergedTaxaTBT
mkdir -p "$BASEFOLDER"/"$USER"/05_TBT/04_PivotMergedTaxaTBT
mkdir -p "$BASEFOLDER"/"$USER"/06_HapMap/01_UnfilteredSNPs
mkdir -p "$BASEFOLDER"/"$USER"/06_HapMap/02_MergeDupSNPs
mkdir -p "$BASEFOLDER"/"$USER"/06_HapMap/03_HapMapFilteredSNPs
mkdir -p "$BASEFOLDER"/"$USER"/06_HapMap/04_BPECFilteredSNPs
mkdir -p "$BASEFOLDER"/"$USER"/06_HapMap/05_ImputedSNPs
mkdir -p "$BASEFOLDER"/"$USER"/50_KeyFiles
mkdir -p "$BASEFOLDER"/"$USER"/51_RunScripts
mkdir -p "$BASEFOLDER"/"$USER"/52_ConfigFiles
mkdir -p "$BASEFOLDER"/"$USER"/53_AlignerIdices

echo "Finished creating folder structure. Ready to copy sequence, key, aligner files."