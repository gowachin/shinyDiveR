# following point :
# depth :
# absolute pressure :  (water pressure : )
# consumption at depth :
# actual pressure :
# time possible at this depth

# Note that by diving with a buddy, you may share your air with him in case of accident.

#' peda_conso_ui
#' 
#' @description  A shiny Module.
#'
#' @param id Internal parameters for {shiny}.
#' @param press show pressure calculus
#' @param vol show volume calculus
#'
#' @noRd 
#' 
#' Drop down part Was copied from hexmake !
#' 
#' @importFrom shiny NS tagList tags fluidRow textInput numericInput tagAppendAttributes selectInput
#' @importFrom tools toTitleCase
mod_peda_conso_ui <- function(id, press, vol, maxt){
  ns <- NS(id)
  tagList(
    tags$details(
      tags$summary(toTitleCase("Calculus details")),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_12(
            h4("Compute pressure"),
            uiOutput(outputId = press)
          ),
          col_12(
            h4("Compute required volume"),
            verbatimTextOutput(outputId = vol)
          ),
          col_12(
            h4("Maximum time at depth (without rules)"),
            # textOutput(maxt)
            verbatimTextOutput(outputId = maxt)
          )
        )
      )
    )
  )
}

#' peda_press server Function
#'
#' @description A shiny Module to summarise conso calculus objects.
#' submodule of mod_02_consoUI
#'
#' @param id shiny id
#' @param i18n traduction language in a reactive element
#' @param conso a conso object created by the mn90 package
#'
#'
#' @noRd 
mod_peda_pressServer <- function(id, i18n, conso){
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      
      ret <- renderUI({
        withMathJax(paste0(
          i18n()$t("$$pressure_{abs} "),
          i18n()$t("= pressure_{water} + pressure_{atmo}\\\\ "),
          i18n()$t(" pressure_{abs} "),
          i18n()$t("= \\frac{depth}{10} + 1 = "),"\\frac{",
          depth(conso), "}{10} + 1 = ",
          depth(conso) /10, " + 1 = ", depth(conso) /10 + 1, " \\text{bar}$$"#,
        ))
      })
      ret
    }
  )
}

#' @noRd 
mod_peda_volServer <- function(id, i18n, conso, input){
  renderText({
    paste0(
      i18n()$t("required volume = "),
      i18n()$t("time x consumption x absolute pressure / tank pressure \n"),
      i18n()$t("required volume = "), 
      round(diff(conso$hour),2), " x ",input$cons, " x ", 
      depth(conso) /10 + 1, " / ", input$press,
      " = ", (round(diff(conso$hour),2) * input$cons * depth(conso) /10 + 1) / 
        conso$vcons[1,3], " litre\n"
    )
  })
}

#' @noRd # NOT USED
mod_peda_finpressServer <- function(id, i18n, conso, input){
  renderText({
    paste0(
      # TODO : need another division by volume
      i18n()$t("final pressure = "),
      i18n()$t("pressure - (time x consumption x absolute pressure) \n"),
      conso$vcons[1,3], ' - (', round(diff(conso$hour),2), " * ",
      input$cons, " * ", depth(conso) /10 + 1, ") = ", 
      i18n()$t("final pressure = "), conso$vcons[1,3] - 
        ( (depth(conso) /10 + 1) * input$cons * round(diff(conso$hour),2)) , 
      " bar\n"
    )
  })
}

#' @noRd
mod_peda_maxtServer <- function(id, i18n, conso, input){
  # time with this bloc including second rule :
  # time = volume * press / conso * abs pressure
  renderText({
    paste0(
      i18n()$t("maximum time = "),
      i18n()$t("volume * press / (conso * abs pressure) \n"),
      i18n()$t("maximum time = "),
      input$volume, " * ", conso$vcons[1,3], ' / (', 
      input$cons, " * ", depth(conso) /10 + 1, ") = ", 
      input$volume * conso$vcons[1,3] / ( 
      input$cons * (depth(conso) /10 + 1) ), 
      " minutes\n"
    )
  })
}