#' @import shiny
#' @import mn90
#' @import rhandsontable
NULL

#' @title   mod_curveUI
#' @description  Shiny module for conso
#'
#' @param id shiny id
#' @param i18n traduction language
#' 
#'  
#' @export
mod_curveUI <- function(id, i18n){
  ns <- NS(id)
  
  out <- tagList(
    'dev1' = sidebarLayout(
      position = "right",
      ### Sidebar panel for inputs ####
      sidebarPanel(
        id = ns("sidebar"),
        helpText(paste(
          i18n$t("You can input a dive with a depth and time")
        )),
        
        titlePanel(i18n$t("First dive")),
        # Input : Number of points ----
        numericInput(ns("rows"), "Number of rows:", 10, min = 1),
        # Input : ways ----
        materialSwitch(
          inputId = ns("way"), label = "Round trip",
          status = "warning"
        ),
        # Input : Points table ----
        rHandsontableOutput(ns("hot")),
        # Input : Save ----
        wellPanel(
          h3("Save"),
          actionButton(ns("save"), "Save table")
        )
        
      ),
      mainPanel(
        h1('in work')
      )
    )
  )
  
  if ( app_prod()) {
    out <-   out[! grepl('^dev',names(out))]
  }
  out
}


#' @title   mod_consoServer
#' @description  Shiny module for square profile
#'
#' @param id shiny id
#' @param i18n traduction language
#'
#' @export
#' @rdname mod_squareUI
mod_curveServer <- function(id, i18n){
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      # compute the interval in minuyte ----
      if (!app_prod()){
        cat('\n\ncurve start\n')
      }
      
      #### Profile input ####
      values <- reactiveValues()
      #### Handsontable ####
      observe({
        if (!is.null(input$hot)) {
          DF <- hot_to_r(input$hot)
          DF <- DF[1:input$rows, ]
          rownames(DF) <- 1:input$rows
        } else {
          if (is.null(values[["DF"]])) {
            DF <- data.frame(
              "depth" = rep(10, input$rows),
              "time" = rep(10, input$rows),
              "distance" = rep(10, input$rows),
              "name" = rep(letters, 10)[1:input$rows],
              stringsAsFactors = F
            )
          } else {
            DF <- values[["DF"]]
            DF <- DF[1:input$rows, ]
            rownames(DF) <- 1:input$rows
          }
        }
        values[["DF"]] <- DF
      })
      #### Profile output ####
      output$hot <- renderRHandsontable({
        DF <- values[["DF"]]
        if (!is.null(DF)) {
          rhandsontable(DF, useTypes = TRUE, stretchH = "all") %>%
            hot_cell(1, 1, "Test comment")
        } # %>%
        # hot_validate_numeric(cols = 1, min = -50, max = 50)
      })
      ## Save
      observeEvent(input$save, {
        finalDF <- isolate(values[["DF"]])
        saveRDS(finalDF, file = file.path(outdir, sprintf("%s.rds", outfilename)))
      })
      
    }
  )
}
