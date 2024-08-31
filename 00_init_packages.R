# Init

# Pacman for packages install/load
if(!require("pacman",quietly = T)){
  install.packages("pacman")
  library(pacman)
}
p_load(char = c("tidyverse",
                "haven",
                "labelled",
                "tibble",
                "callr",
                "tidyr"))


# Create folders if they are not there
lapply(c("input_files",
         "output_files",
         "translations_ready/",
         "translations_empty/"),
       \(x) {if (!dir.exists(x)) {dir.create(x)}})