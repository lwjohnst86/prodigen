#===================================================================
# Build process for creating the final or editable version of the
# manuscript.

#-------------------------------------------------------------------

# Manuscript options file
REP_OPT := config.txt

# Report file (Will need to add Rmd later)
REP_IN := $(wildcard *.Rmd)

# Output report file
REP_OUT := $(REP_IN:.Rmd=.md)

#-------------------------------------------------------------------

# Create output files if need be. Will need to add commands for Rmd

report : $(REP_OUT)

%.md: %.Rmd $(REP_OPT) knit.R
	Rscript knit.R

#-------------------------------------------------------------------
