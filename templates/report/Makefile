#===================================================================
# Build process for creating the final or editable version of the
# manuscript.

#-------------------------------------------------------------------

# Manuscript options file
REP_OPT := options.tex

# Manuscript file type (for example, pdf, doc, html, etc.).  Can be
# specified in the make options (for example: `make report
# REP_TYPE=pdf`)
REP_TYPE = pdf

# Report file (Will need to add Rmd later)
REP_IN := $(wildcard *.md)

# Output report file
REP_OUT := $(REP_IN:.md=.$(REP_TYPE))

#-------------------------------------------------------------------

# Create output files if need be. Will need to add commands for Rmd

report : $(REP_OUT)

%.$(REP_TYPE) : %.md
	@echo "Processing the manuscript"
	@pandoc $< \
		--filter pandoc-citeproc \
		--highlight-style=tango \
		-o $@

#-------------------------------------------------------------------
