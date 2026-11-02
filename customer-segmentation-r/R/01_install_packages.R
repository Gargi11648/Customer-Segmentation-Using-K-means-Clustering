# Run this once to install all required packages
pkgs <- c("tidyverse", "cluster", "factoextra", "shiny", "plotly",
          "DT", "corrplot", "rmarkdown", "knitr")
to_install <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(to_install)) install.packages(to_install)
cat("All packages ready.\n")
