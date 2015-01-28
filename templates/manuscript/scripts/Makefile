#===================================================================
# Build process for analyzing the data and creating the results files
# and figures.

#-------------------------------------------------------------------

# Data processing, analyses, or plots using R
R_FILES = $(sort $(wildcard ??-*.R))

# R output targets (R output files)
R_OUT = $(R_FILES:.R=.Rout)

# Location of the knit.R file
KNIT := opt/knit.R

#-------------------------------------------------------------------
# Create output files if need be

# Run the R scripts
analyze : $(R_OUT)

# Run the knit.R script
knit :
	@echo "Generating HTML documents from R scripts"
	@Rscript $(KNIT)

# Run the R scripts
%.Rout : %.R
	@echo "Processing R scripts"
	@Rscript $?

#-------------------------------------------------------------------
