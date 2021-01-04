#' @import shiny
#' @import shiny.i18n 
#' @import shinyTime
#' 
#' @param i18n traduction language
#' 
app_ui <- function(i18n) {
  fluidPage(
    #### CSS ####
    # tags$head(tags$link(
    #   rel = "stylesheet",
    #   type = "text/css",
    #   href = "bootstrap.css"
    # )),
    ####
    # checkboxInput("help", i18n$t("hepl"), FALSE),
    tabsetPanel(
      type = "pills",
      #### Dive profile panel ####
      tabPanel(
        i18n$t("Dive Profile"),
        mod_squareUI('square', i18n),
        ## invisible panel
        conditionalPanel(
          condition = "false",
          checkboxInput("sec_plot", "plot second dive", FALSE)
        )
      )
    )
  )
}