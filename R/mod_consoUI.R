#' @import shiny
#' @import lubridate
#' @import mn90
#' @import graphics
NULL

#' @title   mod_consoUI
#' @description  Shiny module for conso
#'
#' @param id shiny id
#' @param i18n traduction language
#' 
#'  
#' @export
mod_consoUI <- function(id, i18n){
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
        conditionalPanel(# hidden checkbox !
          'false', ns = ns, checkboxInput(ns("sec_plot"), i18n$t("sec_plot"), 
                                          FALSE)
        ),
                         
        # fucking conditionnal panel not working as i want
        conditionalPanel(
          condition = "input.sec_plot == true", ns = ns,
          selectInput(
            ns("conso_selec"), "Select the dive",
            c(
              # i18n$t("Square") = "sqr" #, # don't work, who knows why ?
              "1" = "first",
              "2" = "second"
            )
          )
        ),
        # bloc caracteristics
        sliderInput(
          inputId = ns("volume"), label = "Volume (littre) :",
          min = 1, max = 18, value = 10, step = 0.5
        ),
        sliderInput(
          inputId = ns("press"), label = i18n$t("Pressure (bar) :"),
          min = 10, max = 300, value = 200, step = 10
        ),
        sliderInput(
          inputId = ns("cons"), label = i18n$t("Consumption (littre/minute) :"),
          min = 10, max = 30, value = 20, step = 1
        ),
        # rule 1 
        helpText(paste("A rule is an important pression to watch during a dive")),
        fluidRow(
          column(width = 4, textInput(ns('rule1'), 'Rule 1', value = "Mid-pression")),
          column(3, selectInput(
            ns("conso_selec"), "Select the dive",
            c("bar" = "bar", "%" = "percent")
          ))),
        sliderInput( inputId = ns("rule1_press"), label = i18n$t("Pressure (bar) :"),
                     min = 0, max = 200, value = 100, step = 10 ),
        # rule 2
        fluidRow(
          column(width = 4, textInput(ns('rule2'), 'Rule 2', value = "Reserve")),
          column(3, selectInput(
            ns("conso_selec"), "Select the dive",
            c("bar" = "bar", "%" = "percent")
          ))),
        sliderInput( inputId = ns("rule2_press"), label = i18n$t("Pressure (bar) :"),
                     min = 0, max = 200, value = 50, step = 10 ),
        # advanced pression settings ####
        checkboxInput("advset_press", i18n$t("Advanced settings"), FALSE),
        conditionalPanel(
          condition = "input.advset_press", ns = ns, 
          # checkboxInput("secu", i18n$t("Security stop"), TRUE),
          selectInput(
            "conso_selec", "Select the pression unit",
            c(
              "bar" = "bar",
              "psi" = "psi"
            )
          )
        )
      ),
      mainPanel(
        plotOutput(outputId = ns("plot_conso"))
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
#' @param sec_plot input of square module if there is a second dive or not
#' @param dives a dive object created by the square module
#' @param r list passing objects from module to modules
#'
#' @export
#' @rdname mod_squareUI
mod_consoServer <- function(id, i18n, sec_plot, dives, r){
  if(r$no_run) return() # set in square, to echap the slider return() call
  
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      # compute the interval in minuyte ----
      if (!app_prod()){
        cat('\n\nconso start\n')
        print(names(input))
        print(input$conso_selec)
        print(dives$dive2)
        }
      if (r$sec_plot){ # select the dive
        updateCheckboxInput(session, "sec_plot", "sec_plot", TRUE)
        conso_dive <- switch(input$conso_selec,
                             first = dives$dive1,
                             second = dives$dive2)
      } else {
        conso_dive <- dives
      }
      if (!app_prod()){cat('compute conso\n')} # bug here in the conso part! see package
      print(conso_dive)
      dt_conso <- conso(dive = conso_dive, bloc = bloc(input$volume, input$press), 
                        cons = input$cons, 
                        mid = input$rule1_press, reserve = input$rule2_press)
      # plot consuption
      if (!app_prod()){cat('make plot\n')}
      output$plot_conso <- renderPlot({
        # plot(1,1, main = 'dev plot')
        plot(conso_dive, ylab = i18n$t("Depth (m)"), xlab = i18n$t("Time (min)"))
        lines(dt_conso$dtcurve$time, -dt_conso$vpress/ 12, col = 'blue')
        abline(v= dt_conso$time_mid[2], col = "orange")
        abline(v= dt_conso$time_reserve[2], col = "red")
      })
    }
  )
}
