#' @import shiny
#'
app_server <- function(input, output,session) {
  # setting language
  language <- getOption( "shiny.lang")
  if (! language %in% c('en','fr')) language <- 'en'
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language(language)
  
  r <- reactiveValues()
  
  observe({
    r$dives <- mod_squareServer('square', i18n, r)
    # mod_consoServer('conso', i18n, input$"square-sec_plot", r$dives, r)
  })
  
}