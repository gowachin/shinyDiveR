#' 02_consoUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id Internal parameters for {shiny}.
#' @param i18n traduction language 
#' @param sec_plot Boolean, TRUE if there is a second dive
#' @param dives a \code{\link[DiveR]{dive}} or \code{\link[DiveR]{ndive}} object.
#' @param r le petit r, a reactive value to pass variable from a module to 
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom graphics plot
#' @import DiveR
mod_02_consoUI_ui <- function(id, i18n){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      position = "right",
      ### Sidebar panel for inputs ####
      sidebarPanel(
        id = ns("sidebar"),
        helpText(i18n$t("You can input a tank by its volum and pressure")
        ),
        conditionalPanel(# hidden checkbox !
          'false', ns = ns, 
          checkboxInput(ns("sec_plot"), i18n$t("sec_plot"), FALSE)
        ),
        
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
          inputId = ns("volume"), label = "Volume (litre) :",
          min = 1, max = 18, value = 15, step = 0.5
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
          column(8, 
                 sliderInput( inputId = ns("rule1_press"), label = i18n$t("Pressure (bar) :"),
                              min = 0, max = 200, value = 100, step = 10 )
          )
        ),
        # rule 2
        fluidRow(
          column(width = 4, textInput(ns('rule2'), 'Rule 2', value = "Reserve")),
          column(8, 
                 sliderInput( inputId = ns("rule2_press"), label = i18n$t("Pressure (bar) :"),
                              min = 0, max = 200, value = 50, step = 10 )
                 )
          ), 
        # advanced pression settings ####
        checkboxInput("advset_press", i18n$t("Advanced settings"), FALSE),
        conditionalPanel(
          condition = "input.advset_press", ns = ns, 
          selectInput(
            "conso_selec", "Select the pressure unit",
            c(
              "bar" = "bar",
              "psi" = "psi"
            )
          )
          # selectInput(
          #   ns("conso_selec"), "Unit",
          #   c("bar" = "bar", "%" = "percent")
          # )
        )
      ),
      mainPanel(
        plotOutput(outputId = ns("plot_conso"))
      )
    )
  )
}
    
#' 02_consoUI Server Function
#'
#' @noRd 
mod_02_consoUI_server <- function(id, i18n, sec_plot, dives ,r){
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
        print(r)
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
      print('here')
      print(input$rule1_press)
      print(input$rule2_press)
      
      
      rules <- c(input$rule1_press, input$rule2_press)
      for (i in 1:2){
        lab <- paste0("rule", i, "_press")
        if (rules[i] > input$press ) {
          updateSliderInput(session, lab, value = input$press, min = 0, 
                            max = input$press)
          return()
        } else {
          updateSliderInput(session, lab, value = rules[i], min = 0, 
                            max = input$press)
        }
      }
      print('nope')
      print(input$rule1)
      print(rules)
      names(rules) <- c( input$rule1 , input$rule2 )
      tank <- tank(vol = input$volume, press = input$press, 
                   rules = list( rules = rules, sys = "bar" ))
      print('hello there')
      dt_conso <- conso(dive = conso_dive, tank, 
                        cons = input$cons, failure_label = 'AF')
      print('ok')
                        
      print(dt_conso)
      # plot consuption
      if (!app_prod()){cat('make plot\n')}
      output$plot_conso <- renderPlot({
        plot(dt_conso, ylab = i18n()$t("Pressure (bar)"), 
             xlab = i18n()$t("Time (min)"), legend = FALSE)
      })
      
    }
  )
}
    
## To be copied in the UI
# mod_02_consoUI_ui("02_consoUI_ui_1")
    
## To be copied in the server
# callModule(mod_02_consoUI_server, "02_consoUI_ui_1")
 
