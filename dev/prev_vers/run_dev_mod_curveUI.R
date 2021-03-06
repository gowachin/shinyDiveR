.rs.api.documentSaveAll() # close and save all open file
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, character.only = TRUE, unload = TRUE))
rm(list = ls(all.names = TRUE))
devtools::document('.')
devtools::load_all('.')
options(app.prod = FALSE) # TRUE = production mode, FALSE = development mode
library(shiny)
library(shiny.i18n)
library(DiveR)
library(shinyWidgets)
library(rhandsontable)
if (interactive()){
  i18n <- Translator$new(translation_json_path = paste0(.libPaths()[1],"/shinyDiveR/app/translations/translation.json"))
  i18n$set_translation_language('fr')
  
  DF <- data.frame()
  
  ui <- fluidPage(
    mod_curveUI('curve', i18n)
  )
  
  server <- function(input, output, session) {
    observe({
      r <- reactiveValues()
      mod_curveServer('curve', i18n)
    })
  }
  shinyApp(ui, server)
}
