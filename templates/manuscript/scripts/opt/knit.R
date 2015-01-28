##' This script takes all the `scripts/` files and generates html
##' documents from them.
library(knitr)

##' Generate html files from the .R files.
files <- list.files(path = "..", pattern = "*.R$")
for (f in files) {
    fi <- paste("../", f, sep = "")
    spin(fi, TRUE, precious = FALSE)
}

##' Delete .md files.
unlink("*.md")

##' Move the html files to the doc folder.
html <- list.files(pattern = "*.html")
doc.dir <- "../../doc/"
dir.create(doc.dir)

for (f in html) {
    file.rename(f, paste(doc.dir, f, sep = ""))
}
