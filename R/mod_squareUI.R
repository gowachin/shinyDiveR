#' squareUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_squareUI_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' squareUI Server Function
#'
#' @noRd 
mod_squareUI_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_squareUI_ui("squareUI_ui_1")
    
## To be copied in the server
# callModule(mod_squareUI_server, "squareUI_ui_1")
 