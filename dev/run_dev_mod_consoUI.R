.rs.api.documentSaveAll() # close and save all open file
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, character.only = TRUE, unload = TRUE))
rm(list = ls(all.names = TRUE))
devtools::document('.')
devtools::load_all('.')
options(app.prod = F) # TRUE = production mode, FALSE = development mode
library(shiny)
library(shiny.i18n)
library(lubridate)
library(DiveR)
library(shinyWidgets)
if (interactive()){
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language('fr')
  
  ui <- fluidPage(
    # setSliderColor(c("DeepPink ", "#FF4500", "", "Teal", 'blue', 'orange'), c(1, 2, 4, 5)),
    # chooseSliderSkin(
    #   skin = c("Square"),#, "Flat", "Modern", "Nice", "Simple", "HTML5", "Round", "Square"),
    #   color = NULL
    # ),
    # tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max {
    #         visibility: hidden !important;
    # }'))),
    mod_squareUI('square', i18n),
    mod_consoUI('conso', i18n)
  )
  
  server <- function(input, output, session) {
    observe({
      r <- reactiveValues()
      mod_squareServer('square', i18n, r)
      mod_consoServer('conso', i18n, input$"square-sec_plot", r$dives, r)
    })
  }
  shinyApp(ui, server)
}


