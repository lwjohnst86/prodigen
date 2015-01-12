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
library(plyr)
library(reshape2)
library(knitr)
library(rmeta)
library(splines)
library(MASS)

##' Source personal functions, or install (or update) custom functions
##' in a package (to install from github, needs devtools)
##devtools::install_github("$GITHUBUSER/$GITHUBRPKG")
library($GITHUBRPKG)
##detach(package:rstatsToolkit, unload=TRUE)

