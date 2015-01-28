##' 
##' Code preamble
##' =============
##' 
##' This code clears the session, just in case.
rm(list=ls())

##' Create an output and fig directory, if none exists.
dir.create("../output/")
dir.create("../output/figs/")

##' Load relevant libraries
library(devtools)
library(ggplot2)
library(grid)
library(gridExtra)
library(ggvis)
library(dplyr)
library(tidyr)
library(reshape2)
library(knitr)
library(pander)

##' Source personal functions, or install (or update) custom functions
##' in a package (to install from github, needs devtools)
##detach(package:((rpkg)), unload=TRUE)
##devtools::install_github("((github_user))/((rpkg))")
library(((rpkg)))

