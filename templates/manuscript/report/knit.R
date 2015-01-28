library(knitr)
library(dplyr)

rep <- list.files(pattern = "*.Rmd$") %>%
    knit() %>%
        pandoc(format = c("docx", "latex"), config = "config.txt")
