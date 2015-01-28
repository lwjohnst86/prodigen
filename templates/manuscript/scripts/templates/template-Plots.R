##' Template for creating a focused plot script (delete this line)
##'
##' Script to (describe task as header)
##' ===================================
##'
##' Description of what this script does.
##'
##' * Project: ((project))
##' * Author: ((author))
##' * Created: ((date)
##' * Master dataset: ((data))
##' 

##' Code preamble
##' =============
##' 
##' Load in the options as well as the dataset.
source("opt/options.R")
load("../data/((project))_data.RData")
names(ds)

##' Set plot theme.
##theme_set(theme_bw())
themeWhite() ## Function from personal library

##' Setting custom object variables
##' ===============================
##' 
##' (Optional) Set variables as objects so that they are easier to
##' reference in the script.  Doing this might make it easier to loop
##' through analyses or tasks.
##' 


##' -----

##' ## Plot title here ##
##' 
##' ...Plot description here...

##' Save the plots using this code.
pdf("../output/figs/plotName.pdf", height = 8,
    width = 8, onefile=TRUE)
print(plot.object)
dev.off()

