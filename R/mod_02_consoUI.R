#' 02_consoUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_02_consoUI_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' 02_consoUI Server Function
#'
#' @noRd 
mod_02_consoUI_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_02_consoUI_ui("02_consoUI_ui_1")
    
## To be copied in the server
# callModule(mod_02_consoUI_server, "02_consoUI_ui_1")
 
