# To do list #

* Update project readme, rename to "projREADME.md"
* Include DocItOut/Roxygen/knitr or something to make the macros more
  documentable and to make the scripts better and more descriptive.
* Include scripts that can print off the version of each program used
  (e.g. R, SAS, LaTeX, etc.)
* Include a script that will generate documentations of the macros, in
  html, for the functions folder, make a doc folder?
* include the for.sas macro in the template file? 
* include a STROBE checklist in templates?
* create in makefile a way to generate .aux file from .md, and jabref
  to export bib from the .aux file.
* Change mindmap template, move the search terms, scheduling, etc. to
  another, plain text, file.
* Include code to create `output` directory if not created (in .sas
  and .R files), update README to reflect that.
* Remove importing the master PROMISE file into the directory tree.
  Change to only be a link to the PROMISE file in the `variables.sas`
  file.  This will prevent an excessive number of duplicate PROMISE
  datasets in my computer, but also allow me, if need to be easily
  send the directory to someone else without having to delete the
  dataset.
* Include the common library packages and subsetting the dataset in
  the R script.
* Include the ggplot2 theme setting for the plots in the R script
* Include a clear session on the bottom of the R script.
* Change import dataset in the analysis.sas file (it is set to the
  master dataset file right now)
* Include table shells in md file
* Include YAML in README file.
* Update Makefile based on renalProg makefile
