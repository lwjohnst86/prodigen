#===================================================================
# Build process for analyzing the data and creating the results files
# and figures.

#-------------------------------------------------------------------

# Data processing or analyses using SAS
SAS_FILES := $(sort $(wildcard ??-*.sas))

# SAS output targets (which are the log files)
SAS_OUT := $(SAS_FILES:.sas=.log)

# Data processing, analyses, or plots using R
R_FILES = $(sort $(wildcard ??-*.R))

# R output targets (R output files)
R_OUT = $(R_FILES:.R=.Rout)

#-------------------------------------------------------------------
# Create output files if need be

analyze : $(SAS_OUT) $(R_OUT)

# Run the SAS scripts
%.log : %.sas
	@echo "Processing SAS scripts"
	sas $?

# Run the R scripts
%.Rout : %.R
	@echo "Processing R scripts"
	Rscript $?

#-------------------------------------------------------------------
