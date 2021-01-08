# Module UI
#' @title   mod_select_view_ui and mod_select_view_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_select_view
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_select_view_ui <- function(id){
  ns <- NS(id)
  tagList(
  )
}
# Module Server
#' @rdname mod_select_view
#' @export
#' @keywords internal
mod_select_view_server <- function(input, output, session){
  ns <- session$ns
}
## To be copied in the UI
# mod_select_view_ui("select_view_ui_1")
## To be copied in the server
# callModule(mod_select_view_server, "select_view_ui_1")