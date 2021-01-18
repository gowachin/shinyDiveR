#' @import shiny
#' @import shiny.i18n
#' @import shinyTime
#' @import shinyWidgets
NULL

#' @title   mod_advparamInput
#' @description  Shiny module for advanced parameters of a dive
#'
#' @param id shiny id
#' @param i18n traduction language
#' 
#' @examples
#' library(shiny)
#' library(shiny.i18n)
#' library(shinyTime)
#' library(shinyWidgets)
#' if (interactive()){
#' i18n <- Translator$new(translation_json_path = "inst/app/translations/translation.json")
#' i18n$set_translation_language('en')
#' ui <- fluidPage(
#'   mod_advparamInput('adv', i18n)
#' )
#' server <- function(input, output, session) {
#' }
#' shinyApp(ui, server)
#' }
#' 
#' @export
mod_advparamInput <- function(id, i18n){
  ns <- NS(id)
  
  out <- tagList(
    hr(style = "border-color: #766812;"),
    checkboxInput(ns("advset"), i18n$t("Advanced settings"), FALSE),
    conditionalPanel(
      condition = "input.advset", ns = ns,
      switchInput(
        inputId = ns("secu"), label = i18n$t("Security stop"), value = TRUE,
        onStatus = "success", offStatus = "danger"
      ),
      # checkboxInput("secu", i18n$t("Security stop"), TRUE),
      numericInput(ns("vup"), i18n$t("Ascent speed:"), 10, min = 1),
      helpText(
        i18n$t(paste0("Recommended speed for propper desaturation ",
                      "is between 10 and 15 m/min"))
      ),
      timeInput(ns("time_input1"), i18n$t("Immersion time"),
                value = strptime("00:00:00", "%T"), seconds = FALSE
      )
    )
  )
  
  if ( app_prod()) {
    out <-   out[! grepl('^dev',names(out))]
  }
  out
}