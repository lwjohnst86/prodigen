##'
##' Fetch and Process the Data
##' ==========================
##'
##' This script fetchs the ((data)), keeps variables relevant to the
##' analysis, restrict the sample size as needed, and lastly save the
##' new ((project)) dataset as an `.RData` file.
##'
##' * Project: ((project))
##' * Author: ((author))
##' * Created: ((date)
##' * Master dataset: ((data))
##' 
##' Load the options for the R session.
source("opt/options.R")

##' Load the master dataset, 
ds <- read.table("((dataset))",
                 header = TRUE, na = "", sep = ",") %>%
                     tbl_df()
names(ds)

##' Keep and subset the dataset to keep the relevant observations.
df <- dplyr::select(speed, dist) %>%
    filter(speed >= 10)

##' Save the dataset as an RData file.  Create a data directory in
##' case none exists.
dir.create("../data/")
save(df, file = "../data/((project))_data.RData")

