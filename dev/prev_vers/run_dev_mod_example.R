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
  i18n <- Translator$new(translation_json_path = paste0(.libPaths()[1],"/shinyDiveR/app/translations/translation.json"))
  i18n$set_translation_language('fr')
  
  ui <- fluidPage(
  )
  
  server <- function(input, output, session) {
    r <- reactiveValues()
  }
  shinyApp(ui, server)
}