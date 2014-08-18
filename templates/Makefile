## This makefile is for the project $PROJECT.  Running this Makefile
## will run the analysis files in SAS and R to create the output files
## in the output directory.  Before submitting the paper to a Journal
## or writing up the final version of the manuscript, type "make" or
## "make all" to create an up-to-date output files, figures, and the
## reports.
##
## @author $AUTHOR
## @date $DATE

### Variable Definitions ###
SHELL:=/bin/sh # Tells make to use shell for shell commands
BIBDIR=/home/luke/Documents/bibliography/bib-db/myrefs.bib
CSLDIR=/home/luke/csl/vancouver.csl

all : refresh clean datashape plots analysis report

datashape :
	cd scripts/; sas variables.sas

analysis :
	cd scripts/; sas analysis.sas # The "$<" = use the first dependency, in this case analysis.sas

plots :
	cd scripts/; R CMD BATCH plots.R

# Include a rule for running knitr, and the latex files
.PHONY : report
report : 
	cd ./report ; \
	pandoc manuscript.md \
		--biblio $(BIBDIR) \
		--csl $(CSLDIR) \
		--highlight-style=tango \
		-o manuscript.pdf

.PHONY : refresh # To run this rule, type into the terminal "make refresh"
refresh :
	cp -fvu /home/luke/R/functions/functions.R ./scripts/functions
	cp -fvu /home/luke/SAS/src/*.sas ./scripts/functions
	chmod 444 ./scripts/functions/*

.PHONY : clean # To run this rule, type into the terminal "make clean"
clean :
	find output -type f -delete
	find scripts -type f \( -iname "*.lst" -o \
		-iname "*.log" -o \
		-iname "*.Rout" -o \
		-iname "*.out" \) \
		-delete

# Generate README if anything is edited in it
README.pdf : README.md
	pandoc $< -o $@

