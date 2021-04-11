#' advparaminput UI Function
#'
#' @description A shiny Module for advanced parameters of a dive. 
#' submodule of mod_01_squareUI
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param i18n traduction language in a reactive element
#'
#' @noRd 
#'
#' @import shiny
#' @import shinyTime
#' @import shinyWidgets
mod_advparamInput <- function(id, i18n){
  ns <- NS(id)
  tagList(
    hr(style = "border-color: #766812;"),
    checkboxInput(ns("advset"), i18n$t("Advanced settings"), FALSE),
    conditionalPanel(
      condition = "input.advset", ns = ns,
      switchInput(
        inputId = ns("secu"), label = i18n$t("Security stop"), value = TRUE,
        onStatus = "success", offStatus = "danger"
      ),
      # checkboxInput("secu", i18n$t("Security stop"), TRUE),
      sliderInput(
        inputId = ns("vup"), label = i18n$t("Ascent speed:"),
        min = 1, max = 20, value = 10
      ),
      # numericInput(ns("vup"), i18n$t("Ascent speed:"), 10, min = 1, max = 120),
      helpText(
        i18n$t(paste0("Recommended speed for propper desaturation ",
                      "is between 10 and 15 m/min"))
      ),
      timeInput(ns("time_input1"), i18n$t("Immersion time"),
                value = strptime("00:00:00", "%T"), seconds = FALSE
      )
    )
  )
  
}

    
## To be copied in the UI
# mod_advparaminput_ui("advparaminput_ui_1")
    
