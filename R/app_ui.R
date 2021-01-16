#' @import shiny
#' @import shiny.i18n 
#' @import shinyTime
#' 
#' @param i18n traduction language
#' 
app_ui <- function() {
  language <- getOption( "shiny.lang")
  if (! language %in% c('en','fr')) language <- 'en'
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language(language)
  
  
  fluidPage(
    #### CSS ####
    # theme = "bootstrap.css",
    # tags$head(tags$link(
    #   rel = "stylesheet",
    #   type = "text/css",
    #   href = "bootstrap.css"
    # )),
    # setSliderColor(c("DeepPink ", "#FF4500", "", "Teal"), c(1, 2, 4, 5)),
    # setSliderColor(c("DeepPink ", "#FF4500", "", "Teal", 'blue', 'orange'), c(1, 2, 4, 5)),
    chooseSliderSkin(
      skin = c("Flat")#, "Flat", "Modern", "Nice", "Simple", "HTML5", "Round", "Square"),
    ),
    ####
    # checkboxInput("help", i18n$t("hepl"), FALSE),
    img(src = 'DiveR_hex.png', height = 100, width = 100),
    hr(style = "border-color: #cbcbcb;"),
    tabsetPanel(
      type = "pills",
      #### Dive profile panel ####
      tabPanel(p(i18n$t("Dive Profile"),icon("water")),
        # i18n$t("Dive Profile"),
        mod_squareUI('square', i18n),
        ## invisible panel
        conditionalPanel(
          condition = "false",
          checkboxInput("sec_plot", "plot second dive", FALSE)
        )
      )#,
      # tabPanel(
      #   i18n$t("Consumption"),
      #   mod_consoUI('conso', i18n)
      # )
    ),
hr(style = "border-color: #cbcbcb;"),
fluidRow(
  column(8,                 # tags$a(href = "https://www.cteeter.ca", 'Chris Teeter', target = '_blank')
         p("App created by Maxime Jaunatre in January 2020", HTML("&bull;"),
           "Find the code on Github:", tags$a(href = "https://github.com/gowachin/shinyDiveR", tags$i(class = 'fa fa-github', style = 'color:#5000a5'), target = '_blank'), style = "font-size: 85%"),
         p("Have a question? Spot an error? Send an email ", tags$a(href = "mailto:maxime.jaunatre@yahoo.fr", tags$i(class = 'fa fa-envelope', style = 'color:#990000'), target = '_blank'), style = "font-size: 85%"),
         p(tags$em("Still in development",HTML("&bull;"), "Last updated: January 2020"), style = 'font-size:75%'))#,
  # column(3, align = "right",
  #        conditionalPanel(
  #          condition = "input.masters_golf == 'Scoring Averages' | input.masters_golf == 'Player Pages'",
  #          p(tags$em('Check the box below to change the colour scheme of the distributions to one that is more easily read by those with color blindness.', style = "font-size: 70%; font-family:Helvetica")),
  #          checkboxInput("col_blind", label = "Colourblind?", value = F)))
  ),
hr(style = "border-color: #cbcbcb;"),
p('Disclaimer : This application is intended for use in education about scubadiving 
  planification only. It is not designed for actual use in scuba diving and underwater 
  activity. It is emphatically not suitable for use in actual diving. Scuba diving is a 
  dangerous activity with risks of death and serious injury. No-one should attempt scuba 
  diving without training, certification, supervision and regular medical assessment. 
  It is also dangerous for trained scuba divers to exceed the limitations of their training.', style = 'font-size:60%'),
p('This application will provide planinfication about dive profile and air consumption, 
without giving any warning if the activity would be dangerous or fatal.
The author does not warrant that the application is correct in any sense whatsoever.'
  , style = 'font-size:60%')
)
}

