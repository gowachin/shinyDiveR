#' @import rlang
NULL

#' Inverted versions of in, is.null and is.na
#' 
#' @noRd
#' 
#' @examples
#' 1 %not_in% 1:10
#' not_null(NULL)
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

#' Removes the null from a vector
#' 
#' @noRd
#' 
#' @example 
#' drop_nulls(list(1, NULL, 2))
drop_nulls <- function(x){
  x[!sapply(x, is.null)]
}

#' If x is `NULL`, return y, otherwise return x
#' 
#' @param x,y Two elements to test, one potentially `NULL`
#' 
#' @noRd
#' 
#' @examples
#' NULL %||% 1
"%||%" <- function(x, y){
  if (is.null(x)) {
    y
  } else {
    x
  }
}

#' If x is `NA`, return y, otherwise return x
#' 
#' @param x,y Two elements to test, one potentially `NA`
#' 
#' @noRd
#' 
#' @examples
#' NA %||% 1
"%|NA|%" <- function(x, y){
  if (is.na(x)) {
    y
  } else {
    x
  }
}

#' Typing reactiveValues is too long
#' 
#' @inheritParams reactiveValues
#' @inheritParams reactiveValuesToList
#' 
#' @noRd
rv <- shiny::reactiveValues
rvtl <- shiny::reactiveValuesToList


#' return `TRUE` if in `production mode`
#' 
#' @export
app_prod <- function(){
  getOption( "golem.app.prod" ) %||% TRUE
}

#' Translation
#' 
#' Environment set by the shiny.i18n package. Run on the translatio.json file.
#' 
#' @details 
#' At this day only english ('en') and french ('fr') are set in the json file. 
#' You can contribute to this via the github repository of this project at
#' \url{https://github.com/gowachin/shinyDiveR}
#'
#' @author Jaunatre Maxime <maxime.jaunatre@yahoo.fr>
#' 
#' @examples 
#' data(i18n)
#' i18n$set_translation_language('fr') # choose the french language
"i18n"

#' Flags icon links
#' 
#' Urls of svg files for flags.
#' 
#' @details 
#' At this day only english ('en') and french ('fr') are set. All these icons 
#' are on the following website : 
#' \url{https://cdn.rawgit.com/lipis/flag-icon-css/master/}
#'
#' @author Jaunatre Maxime <maxime.jaunatre@yahoo.fr>
"flags"
