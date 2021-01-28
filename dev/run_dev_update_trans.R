library(usethis)

# Translation
library(shiny.i18n)
if (file.exists("data/i18n.rda")) {
  #Delete file if it exists
  file.remove("data/i18n.rda")
}
i18n <- Translator$new(translation_json_path = "inst/app/www/translation.json")
usethis::use_data(i18n)

