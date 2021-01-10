#' @import shiny
#' @import lubridate
#' @import mn90
NULL

#' @title   mod_squareUI
#' @description  Shiny module for square profile
#'
#' @param id shiny id
#' @param i18n traduction language
#' 
#' @examples
#' library(shiny)
#' library(shiny.i18n)
#' library(lubridate)
#' library(mn90)
#' library(shinyWidgets)
#' if (interactive()){
#' i18n <- shinyDiveR::i18n
#' i18n$set_translation_language('en')
#' ui <- fluidPage(
#'   mod_squareUI('square', i18n)
#' )
#' server <- function(input, output, session) {
#' observe({
#'    mod_squareServer('square', i18n)
#' })
#' }
#' shinyApp(ui, server)
#' }
#' 
#' @export
mod_squareUI <- function(id, i18n){
  ns <- NS(id)
  
  out <- tagList(
    sidebarLayout(
      position = "right",
      ### Sidebar panel for inputs ####
      sidebarPanel(
        id = ns("sidebar"),
        helpText(paste(
          i18n$t("You can input a dive with a depth and time") # ,
          # i18n$t("or input multiple time/depths points")
        )),
        titlePanel(i18n$t("First dive")),
        # Input: Slider for depths ----
        sliderInput(
          inputId = ns("depth1"), label = i18n$t("Depth (meter):"),
          min = 6, max = 65, value = 20
        ),
        # Input: Slider for time ----
        sliderInput(
          inputId = ns("time1"), label = i18n$t("Time (minutes):"),
          min = 1, max = 180, value = 40
        ),
        # Input: checkbox second dive ----
        checkboxInput(ns("sec"), i18n$t("Second Dive")),
        # Second dive ####
        conditionalPanel(
          condition = "input.sec == true", ns = ns,
          # Input: Slider for depths ----
          timeInput(ns("interv"), i18n$t("Interval time"),
                    value = strptime("12:01:00", "%T"), seconds = FALSE
          ),
          conditionalPanel(
            condition = "input.ghost_sec == true", ns = ns,
            sliderInput(
              inputId = ns("depth2"), label = i18n$t("Depth (meter):"),
              min = 6, max = 60, value = 20
            ),
            # Input: Slider for time ----
            conditionalPanel(
              condition = "input.time_sec == true", ns = ns,
              sliderInput(
                inputId = ns("time2"), label = i18n$t("Time (minutes):"),
                min = 1, max = 180, value = 40
              )
            )
          )
        ),
        mod_advparamInput(ns("adv_param"), i18n),
        conditionalPanel(
          condition = "false",
          checkboxInput(ns("ghost_sec"), "ghost second dive", FALSE),
          checkboxInput(ns("time_sec"), "time second dive", FALSE) #,
          # checkboxInput(ns("sec_plot"), "plot second dive", FALSE)
        )
      ),
      mainPanel(
        plotOutput(outputId = ns("divePlot")),
        verbatimTextOutput(outputId = ns("dive")),
        conditionalPanel(
          condition = "input.sec == true", ns = ns,
          verbatimTextOutput(outputId = ns("dive2"))
        )
      )
    )
  )
  
  if ( app_prod()) {
    out <-   out[! grepl('^dev',names(out))]
  }
  out
}


#' @title   mod_squareServer
#' @description  Shiny module for square profile
#'
#' @param id shiny id
#' @param i18n traduction language
#'
#' @export
#' @rdname mod_squareUI
mod_squareServer <- function(id, i18n, r){
  r$no_run <- FALSE # set for the conso module, to pass if slider return works
  
  moduleServer(
    id,
    ## Below is the module function
    function(input, output, session) {
      # compute the interval in minuyte ----
      if (!app_prod()){cat('square start\n')}
      print(input$interv)
      interv <- minute(input$interv) +
        60 * hour(input$interv)
      maxt1 <- max_depth_t(input$depth1)
      tmp <- input$time1
      ################ SLIDER T1 UPDATE ################
      if (tmp > maxt1) {
        updateSliderInput(session, "time1", value = maxt1, min = 1, max = maxt1)
        return()
      } else {
        updateSliderInput(session, "time1", value = tmp, min = 1, max = maxt1)
      }
      ################ Compute dive 1 ################
      if(!app_prod()) {
        hour <- minute(input$'adv_param-time_input1') + 
          60 * hour(input$'adv_param-time_input1')
      } else {
        hour <- 0
      }
      dive1 <- dive(
        depth = input$depth1, time = input$time1,
        secu = input$'adv_param-secu', vup = input$'adv_param-vup',
        hour = hour
      )
      # allow for second dive depending interval and depth
      updateCheckboxInput(session, "ghost_sec", "ghost second dive",
                          value = !(input$depth1 > 60 & interv < 720)
      )
      if (!app_prod()){
        cat("\n-----------------------\n\n") # consol debug help
      }
      ################ SLIDER T2 conditions ################
      timet <- input$time2
      if (interv <= 15) {
        if (!app_prod()){cat("\nconsec")}
        spendt <- max(dive1$dtcurve$times) + interv # already spent time
        maxt2 <- max_depth_t(max(input$depth1, input$depth2)) - spendt
        maxt2 <- floor(maxt2)
      } else if (interv > 720) {
        if (!app_prod()){cat("\ndiff")}
        maxt2 <- max_depth_t(input$depth2)
      } else {
        if (!app_prod()){
          cat("\nsuccess")
          cat("\nghost check ", input$ghost_sec)
        }
        if (input$depth1 > 60 & interv < 720) {
          if (!app_prod()){cat(" impossible")}
          maxt2 <- -1
        } else {
          maj <- majoration(
            depth = input$depth2, inter = interv,
            group = dive1$palier$group
          )
          if (!app_prod()){cat(" maj : ", maj)}
          maxt2 <- max_depth_t(input$depth2) - maj
        }
      }
      tmp <- input$time2
      
      updateCheckboxInput(session, "time_sec", "ghost second dive",
                          value = (maxt2 > 0)
      )
      r$sec_plot <- input$sec & input$ghost_sec & input$time_sec
      # updateCheckboxInput(session, "sec_plot", "ghost second dive",
      #                     value = input$sec & input$ghost_sec & input$time_sec
      # )
      if (!app_prod()){
      cat("\nmaj done\n") # consol debug help
      cat("inter ", interv, "time2 ", input$time2) # consol debug help
      cat("\ndepth2 ", input$depth2, "group ", dive1$palier$group)
      cat("\ntimet ", timet, "maxt2 ", maxt2, "\n")
      cat(input$ghost_sec, "ghost check\n")
      cat(input$sec, "sec\n")
      cat(input$time_sec, "time check\n")
      # cat(input$sec_plot, "sec plot")
      cat(r$sec_plot, "sec plot")
      }
      ################ SLIDER T2 UPDATE ################
      if (timet > maxt2 | !input$time_sec) {
        if (!app_prod()){cat("\n\n update slider")}
        updateSliderInput(session, "time2", value = maxt2, min = 1, max = maxt2)
        if (input$depth1 > 60) {
          output$dive2 <- renderText({
            i18n$t("A second dive is not possible in less than 12h")
          })
        } else {
          output$dive2 <- renderText({
            i18n$t("A second dive is not possible at this depth")
          })
        }
        if (input$time_sec) {
          r$no_run <- TRUE
          if (!app_prod()){cat("\n\n slider return")}
          return()
        }
      } else {
        updateSliderInput(session, "time2", value = tmp, min = 1, max = maxt2)
      }
      ################ Plot and compute dives ################
      # if (input$type == 'sqr'){}
      if (!app_prod()){cat("\n\n    dives compute")}
      # if (!input$sec_plot ) {
        if (!r$sec_plot ) {
        if (!app_prod()){cat("    single\n")}
        # Plot the dive
        output$divePlot <- renderPlot({
          plot(dive1, ylab = i18n$t("Depth (m)"), xlab = i18n$t("Time (min)"))
        })
        # Dive summary
        output$dive <- mod_summarisediveServer('dive1', i18n, dive1)
        
        r$dives <- dive1
      } else {
        if (!app_prod()){cat("    multiples\n")}
        # compute the dive
        mult_dive <- ndive(dive1,
                           dive(
                             depth = input$depth2, time = input$time2,
                             secu = input$'adv_param-secu', 
                             vup = input$'adv_param-vup'
                           ),
                           inter = interv
        )
        # Plot the dive
        output$divePlot <- renderPlot({
          plot(mult_dive, ylab = i18n$t("Depth (m)"), 
               xlab = i18n$t("Time (min)"))
        })
        # Dive summary
        output$dive <- mod_summarisediveServer('dive1', i18n, mult_dive$dive1)
        if (mult_dive$type != "solo") {
          output$dive2 <- mod_summarisediveServer('dive2', i18n, 
                                                  mult_dive$dive2)
        }
        
        r$dives <- mult_dive
      }
    
    }
  )
}

