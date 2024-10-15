# Alex Knorre
# Aug 31, 2024
# This converts variables and values in SAV to a spreadsheet for manual translation

source("00_init_packages.R")

create_translation_sheet <- function(input_file_path) {
  this_sav <- haven::read_spss(input_file_path)
  
  # Prepare variable labels
  variable_labels <- labelled::var_label(this_sav) |>
    discard(is.null) |>
    as.data.frame() |>
    t() |>
    as.data.frame() |>
    tibble::rownames_to_column() %>% 
    setNames(c("variable_name","variable_label_original")) %>% 
    mutate(variable_label_translated = "")
  
  # Prepare value labels
  value_labels_list <- labelled::val_labels(this_sav)
  
  value_labels <- setNames(
    data.frame(
      matrix(ncol = 5, nrow = 0)),
           c("variable_name",
             "variable_label_original",
             "value_label_id",
             "value_label_original",
             "value_label_translation"))
  
  extract_labels_from_list_element <- function(list_element,
                                               value_labels_list){
    
    variable_name <- names(value_labels_list)[list_element]
    
    variable_label_original <- variable_labels[
      variable_labels$variable_name == variable_name,
      "variable_label_original"]
    
    value_labels <- value_labels_list[[list_element]] |>
      as.data.frame() |>
      tibble::rownames_to_column() |>
      as.data.frame() |>
      setNames(c("value_label_original",
                 "value_label_id")) %>% 
      mutate(value_label_translated = "",
             variable_name = "",
             variable_label_original = "") %>% 
      select(variable_name,
             variable_label_original,
             value_label_id,
             value_label_original,
             value_label_translated)
    
    value_labels$variable_name[1] <- variable_name
    value_labels$variable_label_original[1] <- variable_label_original
    
    return(value_labels)
  }
  
  for (list_element in 1:length(value_labels_list)) {
    # Skip non-string variables for value labels
    if (is.null(value_labels_list[[list_element]])) {
      next
    }
    
    value_labels_for_list_element <- extract_labels_from_list_element(
      list_element = list_element,
      value_labels_list = value_labels_list)
    
    value_labels <- rbind(value_labels, value_labels_for_list_element)
  }
  
  openxlsx::write.xlsx(list("variable_labels" = variable_labels,
                            "value_labels" = value_labels),
                       file = file.path("translations_empty",
                                        paste0(tools::file_path_sans_ext(
                                          basename(input_file_path)),
                                          ".xlsx")))

}

input_files <- list.files("input_files/",
                          pattern = ".sav",
                          full.names = T)

invisible(lapply(input_files, create_translation_sheet))
