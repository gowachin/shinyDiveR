library(usethis)

# Translation
library(shiny.i18n)
if (file.exists("data/i18n.rda")) {
  #Delete file if it exists
  file.remove("data/i18n.rda")
}
i18n <- Translator$new(translation_json_path = "inst/app/www/translation.json")
usethis::use_data(i18n)

file.copy('inst/app/www/bootstrap.css', 'www', overwrite = TRUE )

# # install and restart before testing this
# i18n <- shinyDiveR::i18n
# i18n$set_translation_language('fr')
# 
# i18n$t(paste(
#   'This application will provide planification about dive',
#   'profile and air consumption, without giving any warning',
#   'if the activity would be dangerous or fatal.',
#   'The author does not warrant that the application is',
#   'correct in any sense whatsoever.'))
# i18n$t(paste(
#   'Disclaimer : This application is intended for use',
#   'in education about scubadiving planification only. It is not designed for',
#   'actual use in scuba diving and underwater activity. It is emphatically not',
#   'suitable for use in actual diving. Scuba diving is a dangerous activity with',
#   'risks of death and serious injury. No-one should attempt scuba diving without',
#   'training, certification, supervision and regular medical assessment. It is',
#   'also dangerous for trained scuba divers to exceed the limitations of their',
#   'training.'))
