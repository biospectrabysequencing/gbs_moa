Running the tag count pipeline

---------------------------------------------

# Running

This pipeline conprises of three sub-steps:

1. 01_IndividualTagCounts
2. 02_MergedTagCounts
3. 03_TagCountToFastq

For each step an XML configuration file is given. Use these files to specify your input and output files and to configure your run. You can give 
your own xml configuration files by typing:

moa set config_fastq_to_tag_counts=yourfile.xml
moa set config_merged_to_tag_counts=yourfile.xml
moa set config_tag_counts_to_fastq=yourfile.xml

Be aware that you have to set your own output subdirectories.

Once the configuration has been done you run this piepline by typing:

moa run

# Information about your run

This pipeline has been developed using knitr. That is why you need R and knitr installed in your system in order to run the pipeline. 
You will find a gbs_tagcount.md file that contains information about the run of the pipeline (stdout and documentation about the steps
performed in this analysis). 

# Output Data

The outputs will be stired in three subdirectories:

1. 01_IndividualTagCounts
2. 02_MergedTagCounts
3. 03_TagCountToFastq

Except you have used your own configuration files.

# Cleaning

If you feel the need to clean your results, type:

moa clean

This will delete your ouitput directories


