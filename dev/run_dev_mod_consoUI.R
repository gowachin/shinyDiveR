.rs.api.documentSaveAll() # close and save all open file
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, character.only = TRUE, unload = TRUE))
rm(list = ls(all.names = TRUE))
devtools::document('.')
devtools::load_all('.')
options(app.prod = T) # TRUE = production mode, FALSE = development mode
library(shiny)
library(shiny.i18n)
library(lubridate)
library(DiveR)
library(shinyWidgets)
if (interactive()){
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language('fr')
  
  ui <- fluidPage(
    
    shiny.i18n::usei18n(i18n),
    div(style = "float: right;", tags$style(".chooselang {width: 80px}"),
        div(class = "chooselang",
            pickerInput(
              inputId = 'selected_language',
              label = "Change language", 
              choices = i18n$get_languages(), 
              selected = 'fr'
            )
        ),
    ),
    
    mod_01_squareUI_ui('square', i18n, maxd = c(65,60)),
    hr(style = "border-color: #766812;"),
    mod_02_consoUI_ui('conso', i18n)
  )
  
  server <- function(input, output, session) {
    
    translator <- shinyDiveR::i18n
    observeEvent(input$selected_language, {
      print(paste("Language change!", input$selected_language))
      shiny.i18n::update_lang(session, input$selected_language)
    })
    i18n <- reactive({
      selected <- input$selected_language
      if (length(selected) > 0 && selected %in% translator$get_languages()) {
        translator$set_translation_language(selected)
      }
      translator
    })
    
    observe({
      r <- reactiveValues()
      r$dives <- mod_01_squareUI_server('square', i18n, r)
      mod_02_consoUI_server('conso', i18n, input$"square-sec_plot", r$dives, r)
    })
  }
  shinyApp(ui, server)
}


