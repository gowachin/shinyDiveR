#' summariseconso server Function
#'
#' @description A shiny Module to summarise conso objects.
#' submodule of mod_02_consoUI
#'
#' @param id shiny id
#' @param i18n traduction language in a reactive element
#' @param conso a conso object created by the mn90 package
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
      
      met_rule <- character(2)
      ord_rule <- c(i18n()$t("first"), i18n()$t("second"))
      
      for(r in seq_along(met_rule)){
        if(! is.na(rules(conso)[paste0("time", r)])){
          met_rule[r] <- sprintf(
            i18n()$t("The %s rule '%s' is reached at %.1f minutes"),
            ord_rule[r], rules(conso)[paste0("name", r)], 
            rules(conso)[paste0("time", r)])
        } else {
          met_rule[r] <- sprintf(
            i18n()$t("The %s rule '%s' is not reached"),
            ord_rule[r], rules(conso)[paste0("name", r)])
        }
      }
      
      
      ret <- renderText({
        paste0(
          i18n()$t("The dive reaches "), depth(conso),
          i18n()$t(" meters with a total dive time of "), 
          round(diff(conso$hour),2), " minutes.\n",
          i18n()$t("The final pressure is "), pressure(conso), " bar\n",
          met_rule[1], "\n", met_rule[2],"\n\n",
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

