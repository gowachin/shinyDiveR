#' @import shiny
#'
app_server <- function(input, output,session) {
  # setting language
  language <- getOption( "shiny.lang")
  if (! language %in% c('en','fr')) language <- 'en'
  i18n <- Translator$new(translation_json_path = paste0(.libPaths()[1],"/shinyDiveR/app/translations/translation.json"))
  i18n$set_translation_language(language)
  
  r <- reactiveValues()
  
  observe({
    r$dives <- mod_squareServer('square', i18n, r)
  })
  
}