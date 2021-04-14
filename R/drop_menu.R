# Was copied from hexmake !

# Module UI

#' @title   mod_pkg_name_ui and mod_pkg_name_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#'
#' @rdname mod_pkg_name
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList tags fluidRow textInput numericInput tagAppendAttributes selectInput
#' @importFrom tools toTitleCase
mod_pkg_name_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$details(
      # "coucou",
      tags$summary(toTitleCase("Calculus details")),
      tags$div(
        class = "innerrounded rounded",
        fluidRow(
          col_12(
            textInput(
              ns("package"), 
              "Name", 
              value = "hexmake"
            )
          ), 
          tags$div(
            id = ns("xy"),
            col_6(
              numericInput(
                ns("p_x"),
                "x position for name",
                value = 1,
                step = 0.1
              )
            ),
            col_6(
              numericInput(
                ns("p_y"),
                "y position for name",
                value = 1.4,
                step = 0.1
              )
            )
          ),
          # col_6(
          #   tags$label(
          #     `for` = "p_color",
          #     "Font color for name"
          #   ),
          #   tags$br(),
          #   tags$input(
          #     tags$br(),
          #     type = "color",
          #     id = ns("p_color"),
          #     value = "#FFFFFF",
          #     name = "p_color"
          #   ) %>%
          #     tagAppendAttributes(
          #       onInput = sprintf(
          #         "Shiny.setInputValue('%s', event.target.value)",
          #         ns("p_color")
          #       )
          #     )
          # ),
          col_6(
            numericInput(
              ns("p_size"),
              "Font size for name",
              value = 8,
              step = 0.1
            )
          )
        )
      )
    )
  )
}
