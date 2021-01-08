#' @import shiny
NULL

#' @title   mod_summarisediveServer
#' @description  Shiny module for square profile
#'
#' @param id shiny id
#' @param i18n traduction language
#' @param dive a dive object created by the mn90 package
#'
#' @export
#' @rdname mod_squareUI
mod_summarisediveServer <- function(id, i18n, dive){
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      sup <- dive$palier$time > 0
      n <- sum(sup)
      diz <- sum(dive$palier$time[sup] > 9)
      sp <- c(rep("  ", n - diz), rep(" ", diz))
      
      if(dive$palier$group != "Z"){
        group <- paste0(i18n$t('The dive group is '), dive$palier$group)
      } else {
        group <- ''
      }
      
      if(dive$maj > 0){
        maj <- paste0(i18n$t('The dive majoration is '), dive$maj, ' minutes.')
      } else {
        maj <- ''
      }
      
      ret <- renderText({
        paste0(
          i18n$t("The first dive reach "), depth(dive),
          i18n$t(" meters for a duration of "), dtime(dive), " minutes.\n",
          i18n$t("Total dive time is "), diff(dive$hour),
          i18n$t(" minutes with an ascent of "), dive$dtr, " minutes.\n",
          sum(dive$palier$time > 0), i18n$t(" stops :"),
          paste(sprintf(
            i18n$t("%s%d minutes at %d meters"), sp,
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