.rs.api.documentSaveAll() # close and save all open file
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, character.only = TRUE, unload = TRUE))
rm(list = ls(all.names = TRUE))
devtools::document('.')
devtools::load_all('.')
options(app.prod = FALSE) # TRUE = production mode, FALSE = development mode
library(shiny)
library(shiny.i18n)
library(lubridate)
library(DiveR)
library(shinyWidgets)
if (interactive()){
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language('en')
  
  ui <- fluidPage(
    mod_squareUI('square', i18n)
  )
  
  server <- function(input, output, session) {
    r <- reactiveValues()
    observe({
      mod_squareServer('square', i18n, r)
    })
  }
  shinyApp(ui, server)
}
