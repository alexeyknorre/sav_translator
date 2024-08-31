# Scripts to translate variable and value labels in your SPSS data
**Author:** Alex Knorre  
**Website:** [alexknorre.com](https://alexknorre.com)  
**Date:** Aug 31, 2024

## How to use it:

### STEP 1. Install packages and initialize folders
Run the following line in your R environment:

```r
source("00_init_packages.R")
```

This will create four folders:
- **/input_files**: Save your SAV files here. Make sure they have different names!
- **/translations_empty**: Folder with new translation sheets.
- **/translations_ready**: Folder for translation sheets after you have translated and saved them here.
- **/output_files**: This will contain your translated SAV files at the end,

### STEP 2. Prepare translation spreadsheets
Put some SAV files you want to translate into the `input_files` folder and run:

```r
callr::rscript("01_create_translation_sheets.R")
```

This will create a translation Excel spreadsheet in **/translations_empty** for each SAV file.

### STEP 3. Translate your variable and value labels within Excel spreadsheets

Go to folder **/translations_empty**, open Excel files and translate your variable and value labels there. DON'T FORGET to save them to folder "translations_ready" when done!

### STEP 4. Once you save translated sheets in translations_ready, run this line:
```r
callr::rscript("02_translate_sav.R")
```
### STEP 5. Enjoy your translated SPSS data in output_files
