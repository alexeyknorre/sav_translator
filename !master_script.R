# Scripts to translate variable and value labels in your SPSS data
# Alex Knorre
# alexknorre.com
# Aug 31, 2024

# Run this line to install packages and initialize folders
source("code/00_init_packages.R")

# Put some SAV files you want to translate into input_files and run this line:
callr::rscript("01_create_translation_sheets.R")

# Translate your variable and value labels within Excel spreadsheets
# in folder "translations_empty". DON'T FORGET to 
# save them to folder "translations_ready" when done!

# Once done, run this:
callr::rscript("02_translate_sav.R")

# Enjoy your translated SPSS data...
