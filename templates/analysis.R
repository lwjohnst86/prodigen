## This R ($RVERSION) script was created on $DATE by Luke Johnston.
## The file contains code to analyze data from ${DatasetName} for the
## project ${ProjectDir}.  This script likely contains a large portion
## of code for generating graphics, plots, and regression diagnostics.
## However, it may also contain code for the main analysis for the
## project.

## Source the functions and the dataset
source("functions/functions.R")
ds <- read.table("../dataset/${ProjectDir}_data.csv.gz", 
	header=TRUE, na="", sep=",")

## Load relevant libraries
library()

