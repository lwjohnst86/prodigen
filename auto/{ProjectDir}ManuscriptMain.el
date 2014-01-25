(TeX-add-style-hook "{ProjectDir}ManuscriptMain"
 (lambda ()
    (LaTeX-add-bibliographies
     "myrefs")
    (TeX-run-style-hooks
     "csquotes"
     "wasysym"
     "natbib"
     "sort"
     "numbers"
     "pgfplotstable"
     "amsmath"
     "threeparttable"
     "array"
     "booktabs"
     ""
     "inputenc"
     "utf8"
     "fontenc"
     "T1"
     "latex2e"
     "art12"
     "article"
     "draft"
     "letterpaper"
     "12pt"
     "${ProjectDir")))

