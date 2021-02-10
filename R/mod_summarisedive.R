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
      sup <- dive$palier$time > 0
      n <- sum(sup)
      diz <- sum(dive$palier$time[sup] > 9)
      sp <- c(rep("  ", n - diz), rep(" ", diz))
      
      if(dive$palier$group != "Z"){
        group <- paste0(i18n()$t('The dive group is '), dive$palier$group)
      } else {
        group <- ''
      }
      
      if(dive$maj > 0){
        maj <- paste0(i18n()$t('The dive majoration is '), dive$maj, ' minutes.')
      } else {
        maj <- ''
      }
      
      ret <- renderText({
        paste0(
          i18n()$t(paste("The", num, "dive reaches ")), depth(dive),
          i18n()$t(" meters for a duration of "), dtime(dive), " minutes.\n",
          i18n()$t("Total dive time is "), round(diff(dive$hour),2),
          i18n()$t(" minutes with an ascent of "), round(dive$dtr, 2), " minutes.\n",
          sum(dive$palier$time > 0), i18n()$t(" stops :"),
          paste(sprintf(
            i18n()$t("%s%d minutes at %d meters"), sp,
            dive$palier$time[sup],
            dive$palier$depth[sup]
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
 
