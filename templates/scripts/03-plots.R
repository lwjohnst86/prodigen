##' Introduction
##' ============
##' 
##' The file contains code to analyze the data $DATA for the project
##' $PROJECT.  This script likely contains a large portion of code for
##' generating graphics, plots, and regression diagnostics.  However,
##' it may also contain code for the main analysis for the project.
##'
##' @author $AUTHOR
##' @date $DATE
##' 

##=================================================================

##' 
##' Code preamble
##' =============
##' 
##' This code clears the session, just in case.
rm(list=ls())

##' Include the options files into the R session.
source(options.R)

##' Load in the dataset
ds <- read.table("../data/${PROJECT}_data.csv.gz", 
	header=TRUE, na="", sep=",")
names(ds)

##' Set the plot theme.  This code creates a simple plot theme, rather
##' than the default used by ggplot2.
##theme_set(theme_bw())
themeWhite()

##=================================================================

##' Setting custom object variables
##' ===============================
##' 
##' These object variables store the column number corresponding to
##' each of the names of the variables within the dataframe `ds`.  I
##' do this because it makes it easier to loop through these variables
##' in the code below.

##=================================================================

##' Exploratory plots
##' =================
##' 
##' In order to better do a "formal" analysis of the data, I need to
##' explore it first, making sure that the data looks good and so on.
##' These initial plots are univariate over the 6 year period.

##----------------------------------------------------------------

##' ## Plot title here ##
##' 
##' ...Plot description here...

## Save the plots using this code.
pdf("../output/figs/plotName.pdf", height = 8,
    width = 8, onefile=TRUE)
print(plot.object)
dev.off()

##----------------------------------------------------------------

##' ## Next plot title here ##
##' 
##' ...Plot description here...

## Save the plots using this code.
pdf("../output/figs/plotName.pdf", height = 8,
    width = 8, onefile=TRUE)
print(plot.object)
dev.off()

## etc...

##=================================================================

##' Plots for manuscript
##' ====================
##' 
##' These are plots that I will likely use for my manuscript/formal
##' presentation of the data.  So they will be prettied up more
##' compared to the exploratory plots.
##' 

##----------------------------------------------------------------

##' ## Plot title here ##
##' 
##' ...Plot description here...

## Save the plots using this code.
pdf("../output/figs/plotName.pdf", height = 8,
    width = 8, onefile=TRUE)
print(plot.object)
dev.off()

##----------------------------------------------------------------

##' ## Next plot title here ##
##' 
##' ...Plot description here...

## Save the plots using this code.
pdf("../output/figs/plotName.pdf", height = 8,
    width = 8, onefile=TRUE)
print(plot.object)
dev.off()

##=================================================================

##' Clear the R session, just in case.
rm(list=ls())
