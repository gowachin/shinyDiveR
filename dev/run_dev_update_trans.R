library(usethis)

# Translation
library(shiny.i18n)
if (file.exists("data/i18n.rda")) {
  #Delete file if it exists
  file.remove("data/i18n.rda")
}
i18n <- Translator$new(translation_json_path = paste0(.libPaths()[1],"/shinyDiveR/app/www/translation.json"))
usethis::use_data(i18n, overwrite = TRUE)

file.copy('inst/app/www/bootstrap.css', 'www', overwrite = TRUE )