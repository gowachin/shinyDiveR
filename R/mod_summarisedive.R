#' summarisedive UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_summarisedive_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' summarisedive Server Function
#'
#' @noRd 
mod_summarisedive_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_summarisedive_ui("summarisedive_ui_1")
    
## To be copied in the server
# callModule(mod_summarisedive_server, "summarisedive_ui_1")
 
