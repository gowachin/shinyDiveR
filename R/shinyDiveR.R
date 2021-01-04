#' @import graphics
#' @import shiny
#' @import utils
#' @import shiny.i18n
NULL

#' shinyDiveR
#'
#' A package to code some basic function about dive profiles.
#'
#' @docType package
#' @name shinyDiveR
NULL


#' run_app
#'
#' Function to run the application
#' 
#' @param language 'en' by default, option to choose the language to run the app
#' with. Choice between 'en' and 'fr' (english, french).
#'
#' @docType package
#' @name shinyDiveR
run_app <- function(language = c("en","fr")) {
  # choosing language
  language <- match.arg(language)
  cat('Launching app with ',language,' language\n')
  Sys.setenv(LANG = language)
  options(shiny.loc = "inst/app/")
  i18n <- Translator$new(translation_json_path = "inst/app/translations/translation.json")
  i18n$set_translation_language(language)
  
  shinyApp(ui = app_ui(i18n), server = app_server)
}


#' in prod functions
#' @param x value
#' @param y value
#' 
`%-%` <- function (x, y)
{
  if (is.null(x))
    y
  else x
}
#' return `TRUE` if in `production mode`
app_prod <- function(){
  getOption( "app.prod" ) %-% TRUE
}