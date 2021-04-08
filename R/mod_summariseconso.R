#' summarisedive server Function
#'
#' @description A shiny Module to summarise dive objects.
#' submodule of mod_01_squareUI
#'
#' @param id shiny id
#' @param i18n traduction language in a reactive element
#' @param dive a dive object created by the mn90 package
#'
#'
#' @noRd 
mod_summariseconsoServer <- function(id, i18n, conso){
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      
      if( sum(pressure(conso)) ){
        viable <- i18n()$t("The dive is viable !")
        fail <- ""
      } else {
        viable <- i18n()$t("The dive is deadly !")
        fail <- paste0(i18n()$t("The air failure happens at "),
        rules(conso, n =0)$timeE, i18n()$t(" at "),
        - depth_at_time(conso, rules(conso, n =0)$timeE), "m\n")
      }
      
            ret <- renderText({
        paste0(
          i18n()$t("The dive reaches "), depth(conso),
          i18n()$t(" meters with a total dive time of "), 
          round(diff(conso$hour),2), " minutes.\n",
          i18n()$t("The final pressure is "), pressure(conso), " bar\n",
          paste(sprintf(i18n()$t("The %s rule '%s' is reached at %.1f minutes"),
                  c(i18n()$t("first"), i18n()$t("second")),
                  unlist(rules(conso)[c(2, 5)]), 
                  unlist(rules(conso)[c(3, 6)]) 
          ), collapse = "\n"),"\n",
          fail,
          viable, "\n"
        )
        
      })
      ret
    }
  )
}

## To be copied in the server
# callModule(mod_summarisedive_server, "summarisedive_ui_1")

