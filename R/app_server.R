#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny DiveR
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  #### Translation ####
  # Allow for changing the 
  translator <- shinyDiveR::i18n
  # UI change of translation
  observeEvent(input$selected_language, {
    # This print is just for demonstration
    print(paste("Language change!", input$selected_language))
    # Here is where we update language in session
    shiny.i18n::update_lang(session, input$selected_language)
  })
  # serveur translation
  i18n <- reactive({
    selected <- input$selected_language
    if (length(selected) > 0 && selected %in% translator$get_languages()) {
      translator$set_translation_language(selected)
    }
    translator
  })
  
  #### serveur part ####
  r <- reactiveValues()
  
  observe({
    r$dives <- modi_01_squareUI_server('square', i18n, r)
  })
}
