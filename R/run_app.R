#' Run the Shiny Application
#'
#' @param app_lang the language for the app. 'en' by default.
#' @param app_maxd maximum depth. Maximum and default value is 65.
#' @param app_prod is the application in prod. Default value is TRUE.
#' Allow to hide tabpanel with shinyjs.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  app_lang = c('en','fr'),
  app_maxd = 65, 
  app_prod = TRUE
) {
  # language boys
  app_lang <- match.arg(app_lang)
  # application maximum depth is actually 65
  app_maxd <- ifelse(app_maxd > 65, 65, app_maxd)
  if(app_maxd > 60){ 
    app_maxd <- c(app_maxd,60) 
  } else {
      app_maxd<- rep(app_maxd, 2) 
  }
  # production
  
  cat('launching app \n')
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(
      app_lang = app_lang,
      app_maxd = app_maxd,
      app_prod = app_prod
      )
  )
}
