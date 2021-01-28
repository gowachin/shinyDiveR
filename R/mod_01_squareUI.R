#' squareUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_01_squareUI_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' squareUI Server Function
#'
#' @noRd 
modi_01_squareUI_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_01_squareUI_ui("squareUI_ui_1")
    
## To be copied in the server
# callModule(mod_01_squareUI_server, "squareUI_ui_1")
 
