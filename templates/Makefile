#===================================================================
# This makefile is for the project $PROJECT.  Running this Makefile
# will run the analysis files in SAS and R to create the output files
# in the output directory.  Before submitting the paper to a Journal
# or writing up the final version of the manuscript, type "make" to
# see all the commands to run.
# 
# @author $AUTHOR
# @date $DATE
# 
#===================================================================

#-------------------------------------------------------------------
# Settings

# Tells make to use shell for shell commands
SHELL:=/bin/sh 

# Location of project, report, scripts and functions folder
SCRIPTS_DIR = ./scripts
PROJ_FUN_DIR = $(SCRIPTS_DIR)/functions
REP_DIR = ./report

# Manuscript file type (for example, pdf, doc, html, etc.).  Can be
# specified in the make options (for example: `make report
# REP_TYPE=pdf`)
REP_TYPE = pdf

# Manuscript options file
REP_OPT = $(REP_DIR)/options.tex

# Functions and macros location and files
MAIN_FUNCTIONS = \
	$FUNCTIONS \
	$MACROS

# Data processing or analyses using SAS
SAS_SCRIPTS = \
	$(sort $(wildcard $(SCRIPTS_DIR)/??-*.sas))

# SAS output targets (which are the log files)
SAS_OUT = $(SAS_SCRIPTS:.sas=.log)

# Data processing, analyses, or plots using R
R_SCRIPTS = \
	$(sort $(wildcard $(SCRIPTS_DIR)/??-*.R))

# R output targets (R output files)
R_OUT = $(R_SCRIPTS:.R=.Rout)

# Report file (Will need to add Rmd later)
REP_IN = \
	$(wildcard $(REP_DIR)/*.md)

# Output report file
REP_OUT = $(REP_IN:.md=.$(REP_TYPE))

#-------------------------------------------------------------------
# To not lead to mistakes, use the default make target list the
# commands, rather than run anything.

all : commands

#-------------------------------------------------------------------
# Create output files if need be

# Run the SAS scripts
$(SAS_OUT) : $(SAS_SCRIPTS)
	sas $?

# Run the R scripts
$(R_OUT) : $(R_SCRIPTS)
	R CMD BATCH $?

$(REP_OUT) : $(REP_IN)
	pandoc $< \
		--highlight-style=tango \
		-o $@

#-------------------------------------------------------------------
# Targets and commands

##-------------------------------------------------------------------
## commands   : Show all commands in Makefile
commands :
	@grep -E '^##' Makefile | sed -e 's/##//g'

##-------------------------------------------------------------------

## final      : Run all Make targets, creating the final manuscript file.
final : readme clean refresh analysis report

## analysis   : Run all statistical programs to output results.
analysis : $(SAS_OUT) $(R_OUT)

## report     : Create the manuscript in its final format.
# Include a rule for running knitr, and the latex files
report : $(REP_OUT)

## refresh    : Update the functions in the local project folder from the
##              master file location.
refresh :
	for file in $(MAIN_FUNCTIONS) ; do \
		cp -fvu $$file $(PROJ_FUN_DIR)/; \
	done
	chmod 444 $(PROJ_FUN_DIR)/*

## clean      : Delete all extraneous / unnecessary files.
clean :
	find output -type f -delete
	find scripts -type f \( -iname "*.lst" -o \
		-iname "*.log" -o \
		-iname "*.Rout" -o \
		-iname "*.out" \) \
		-delete

## readme     : Only need to run if you have edited the README file.
readme : 
	sed -i 's/-+-/-|-/g' README.md
	pandoc README.md --highlight-style tango -o README.pdf

##-------------------------------------------------------------------

.PHONY : report analysis refresh clean

