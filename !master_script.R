# Scripts to translate variable and value labels in your SPSS data
# Alex Knorre
# alexknorre.com
# Aug 31, 2024

# How to use it:
# STEP 1. Run this line to install packages and initialize folders
source("00_init_packages.R")

# This will create four folders: 
# /input_files - save your SAV files here. Make sure they have different names!
# /translations_empty - folder with new translations sheets. Run 
#                       01_create_translation_sheets to populate this
# /translations_ready - folder with translation_sheets after you translated 
#                       and saved them here
# /output_files - this will contain your SAV files after 
#                 you run 02_translate_sav

# STEP 2. Put some SAV files you want to translate into input_files and run this line:
callr::rscript("01_create_translation_sheets.R")

# STEP 3. Translate your variable and value labels within Excel spreadsheets
# in folder "translations_empty". DON'T FORGET to 
# save them to folder "translations_ready" when done!

# STEP 4. Once you save translated sheets in translations_ready, run this:
callr::rscript("02_translate_sav.R")

# STEP 5. Enjoy your translated SPSS data in output_files
