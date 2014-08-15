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
VPATH=scripts/functions data report scripts # Tells make to search these directories for files
BIBDIR=$BIBLIO
CSLDIR=$BIBSTYLE
OBJ = variables.lst analysis.lst analysis.Rout # Object files to be created

all : refresh clean $(OBJ)

variables.lst : variables.sas
	sas $<

analysis.lst : analysis.sas
	sas $< # The "$<" = use the first dependency, in this case analysis.sas

analysis.Rout : analysis.R
	R CMD BATCH $<

# can call other makefiles using "$(MAKE) -C ./report/make"

.PHONY : refresh # To run this rule, type into the terminal "make refresh"

refresh :
	cp -fvu $FUNCTIONS ./scripts/functions
	cp -fvu $MACROS ./scripts/functions
	cp -fvup $DATASET ./data
	chmod 444 ./scripts/functions/*

.PHONY : clean # To run this rule, type into the terminal "make clean"

clean :
	find output -type f -delete
	find scripts -type f \( -iname "*.lst" -o \
		-iname "*.log" -o \
		-iname "*.Rout" -o \
		-iname "*.out" \) \
		-delete

# Include a rule for running knitr, and the latex files
manuscript.pdf : manuscript.md
	pandoc manuscript.md \
		--biblio $(BIBDIR) \
		--csl $(CSLDIR) \
		-o manuscript.pdf

README.pdf : README.md
	pandoc $< \
		-V geometry:margin=1in \
		-V mainfont="DejaVu Serif" \
		-V fontsize=12pt \
		-o $@
