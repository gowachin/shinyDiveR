library(usethis)

# Translation
library(shiny.i18n)
i18n <- Translator$new(translation_json_path = paste0(.libPaths()[1],"/shinyDiveR/app/www/translation.json"))
usethis::use_data(i18n, overwrite = TRUE)
