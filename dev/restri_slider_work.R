sliderInput2 <- function(inputId, label, min, max, value, step=NULL, from_min, from_max){
  x <- sliderInput(inputId, label, min, max, value, step)
  x$children[[2]]$attribs <- c(x$children[[2]]$attribs, 
                               "data-from-min" = from_min, 
                               "data-from-max" = from_max, 
                               "data-from-shadow" = TRUE)
  x
}

updateSliderInput2 <- function (session, inputId, label = NULL, value = NULL, min = NULL, 
          max = NULL, step = NULL, timeFormat = NULL, timezone = NULL) 
{
  dataType <- getSliderType(min, max, value)
  if (is.null(timeFormat)) {
    timeFormat <- switch(dataType, date = "%F", datetime = "%F %T", 
                         number = NULL)
  }
  if (isTRUE(dataType %in% c("date", "datetime"))) {
    to_ms <- function(x) 1000 * as.numeric(as.POSIXct(x))
    if (!is.null(min)) 
      min <- to_ms(min)
    if (!is.null(max)) 
      max <- to_ms(max)
    if (!is.null(value)) 
      value <- to_ms(value)
  }
  message <- dropNulls(list(label = label, value = formatNoSci(value), 
                            min = formatNoSci(min), max = formatNoSci(max), step = formatNoSci(step), 
                            `data-type` = dataType, `time-format` = timeFormat, timezone = timezone))
  session$sendInputMessage(inputId, message)
}

ui <- fluidPage(
  sliderInput2("slider", "Slide:",
               min = 0, max = 100, value = 50, step = 5, from_min = 20, from_max = 80
  )
)

server <- function(input, output) {}

shinyApp(ui, server)