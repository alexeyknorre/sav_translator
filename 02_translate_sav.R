# Alex Knorre
# Aug 31, 2024
# This translates original variables and values in SAV files 
# according to translation spreadsheets

source("00_init_packages.R")

input_files <- list.files("input_files/",
                          pattern = ".sav",
                          full.names = T)

input_file_path <- input_files

translate_sav <- function(input_file_path) {
  
  # Check is translation sheet with the same name exists
  file_name <- tools::file_path_sans_ext(
    basename(input_file_path))
  
  translation_sheets <- list.files("translations_ready/",
                                  pattern = file_name,full.names = T)
  if (length(translation_sheets) < 1) {
    stop("Can't find translation sheet for",
         input_file_path,
         " in folder translations_ready. Check if file exists.")
  }
  
  # Load and filter translated variables
  transl_variables <- openxlsx::read.xlsx(translation_sheets,sheet = 1) %>% 
    filter(!is.na(variable_label_translated))
  
  # Load and filter translated values
  transl_values <- openxlsx::read.xlsx(translation_sheets,sheet = 2) %>% 
    filter(!is.na(value_label_translated)) %>% 
    tidyr::fill(variable_name, .direction = "down")
  
  this_sav <- haven::read_spss(input_file_path)
  
  # Replace variable labels
  for (variable_in_sav in 1:nrow(transl_variables)) {
    var_label(
      this_sav[[ transl_variables$variable_name[variable_in_sav] ]]
      ) <- transl_variables$variable_label_translated[variable_in_sav]
  }
  
  # Replace value labels
  for (value_in_sav in 1:nrow(transl_values)) {
    
    val_label(
      this_sav[[ transl_values$variable_name[value_in_sav] ]],
      transl_values$value_label_id[value_in_sav]
      ) <- transl_values$value_label_translated[value_in_sav]
  }
  
  haven::write_sav(this_sav,
                   file.path("output_files",
                                       paste0(tools::file_path_sans_ext(
                                         basename(input_file_path)),
                                         ".sav")))
 
}

invisible(lapply(input_files, translate_sav))