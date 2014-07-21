## This R script was created on $DATE by $AUTHOR.  The file contains
## code to analyze the data $DATA for the project $PROJECT.  This
## script likely contains a large portion of code for generating
## graphics, plots, and regression diagnostics.  However, it may also
## contain code for the main analysis for the project.

## Source the functions and the dataset
source("functions/functions.R")
ds <- read.table("../data/${PROJECT}_data.csv.gz", 
	header=TRUE, na="", sep=",")

## Load relevant libraries
library()

