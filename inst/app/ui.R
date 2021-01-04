language <- Sys.getenv('LANG')
if (! language %in% c('en','fr')) language <- 'en'
i18n <- Translator$new(translation_json_path = paste0(getOption( "shiny.loc"),"translations/translation.json"))
i18n$set_translation_language(language)

shinyDiveR::app_ui(i18n)