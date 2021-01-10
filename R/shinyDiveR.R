#' @import shiny
#' @import utils
#' @import shiny.i18n
#' @import pkgload
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
#' @examples 
#' if (interactive()){
#'  shinyDiveR:::run_app()
#' }
#' 
#' @docType package
#' @name shinyDiveR
#' @export
run_app <- function(language = c("en","fr")) {
  # choosing language
  language <- match.arg(language)
  cat("Launching app with ", language, " language\n")
  options(shiny.lang = language)
  
  shinyApp(ui = app_ui(), server = app_server)
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
#' @export
app_prod <- function(){
  getOption( "app.prod" ) %-% TRUE
}