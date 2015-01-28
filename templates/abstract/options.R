##' 
##' Code preamble
##' =============
##' 
##' This code clears the session, just in case.
rm(list=ls())

##' Load relevant libraries
library(devtools)
library(ggplot2)
library(grid)
library(gridExtra)
library(ggvis)
library(tidyr)
library(reshape2)
library(knitr)
library(MASS)
library(pander)
library(data.table)

##' Source personal functions, or install (or update) custom functions
##' in a package (to install from github, needs devtools)
##detach(package:((rpkg)), unload=TRUE)
##devtools::install_github("((github_user))/((rpkg))")
library(((rpkg)))

