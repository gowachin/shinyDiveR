#' summarisedive server Function
#'
#' @description A shiny Module to summarise dive objects.
#' submodule of mod_01_squareUI
#'
#' @param id shiny id
#' @param i18n traduction language in a reactive element
#' @param dive a dive object created by the mn90 package
#' @param n number of the dive. TO be in c('first', 'second')
#'
#'
#' @noRd 
mod_summarisediveServer <- function(id, i18n, dive, num = c("first", "second")){
  num <- match.arg(num)
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      sup <- dive$desat$time > 0
      n <- sum(sup)
      diz <- sum(dive$desat$time[sup] > 9)
      sp <- c(rep("  ", n - diz), rep(" ", diz))
      
      if(dive$desat$group != "Z"){
        group <- paste0(i18n()$t('The dive group is '), dive$desat$group)
      } else {
        group <- ''
      }
      
      if(dive$params["maj"] > 0){
        maj <- paste0(i18n()$t('The dive majoration is '), dive$params["maj"], ' minutes.')
      } else {
        maj <- ''
      }
      
      ret <- renderText({
        paste0(
          i18n()$t(paste("The", num, "dive reaches ")), depth(dive),
          i18n()$t(" meters for a duration of "), dtime(dive), " minutes.\n",
          i18n()$t("Total dive time is "), round(diff(dive$hour),2),
          i18n()$t(" minutes with an ascent of "), round(dive$params["dtr"], 2), " minutes.\n",
          sum(dive$desat$time > 0), i18n()$t(" stops :"),
          paste(sprintf(
            i18n()$t("%s%d minutes at %d meters"), sp,
            dive$desat$time[sup],
            dive$desat$depth[sup]
          ),
          collapse = "\n         "
          ), '\n', group, '\n', maj
        )
        
      })
      ret
    }
  )
}
    
## To be copied in the server
# callModule(mod_summarisedive_server, "summarisedive_ui_1")
 
