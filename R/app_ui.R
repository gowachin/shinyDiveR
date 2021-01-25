#' @import shiny
#' @import shiny.i18n 
#' @import shinyTime
#' 
#' @param i18n traduction language
app_ui <- function() {
  language <- getOption( "shiny.lang")
  if (! language %in% c('en','fr')) language <- 'en'
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language(language)
  
  
  fluidPage(
    # addResourcePath('www', system.file("www", package = "shinyDiveR")),
    #### CSS ####
    theme = "bootstrap.css",
    # theme = system.file("app/www/bootstrap.css", package = "shinyDiveR"),
    # Slider hide border values
    tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max {
            visibility: hidden !important;
    }'))),
    # chooseSliderSkin( skin = c("Modern"), color = NULL), #'#766812'), 
    # # colors 
    setSliderColor(rep(c("#2a8dd2", "#cc4f1c"),2), c(1, 2, 3, 4)),
    tags$head(tags$link(rel="shortcut icon", href="DiveR_hex.png")), #Favicon
    #### TITLE ###
    # checkboxInput("help", i18n$t("hepl"), FALSE),
    titlePanel(
      title=div(img(src="DiveR_hex.png", height = 70),
                    i18n$t("Dive planification tool")), 
               windowTitle = "DiveR"),
    # hr(style = "border-color: #766812;"),
    
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
      #     h1('In work')
      #   # mod_consoUI('conso', i18n)
      # )
    ),
    hr(style = "border-color: #766812;"),
    fluidRow(
      column(5, # tags$a(href = "https://www.cteeter.ca", 'Chris Teeter', target = '_blank')
             p("App created by Maxime Jaunatre in January 2020", HTML("&bull;"),
               "Find the code on Github:", 
               tags$a(href = "https://github.com/gowachin/shinyDiveR", 
                      tags$i(class = 'fa fa-github', style = 'color:#bd971e'), 
                      target = '_blank'), style = "font-size: 85%"),
             p("Have a question? Spot an error? Report an issue on Github or send an email ", 
               tags$a(href = "mailto:maxime.jaunatre@yahoo.fr", 
                      tags$i(class = 'fa fa-envelope', style = 'color:#bd971e'),
                      target = '_blank'), style = "font-size: 85%"),
             p(tags$em("Last updated: January 2020"), style = 'font-size:75%')),

      column(7, #align = "right",
             # hr(style = "border-color: #cbcbcb;"),
             p(i18n$t(paste(
               'Disclaimer : This application is intended for use',
'in education about scubadiving planification only. It is not designed for',
'actual use in scuba diving and underwater activity. It is emphatically not',
'suitable for use in actual diving. Scuba diving is a dangerous activity with',
'risks of death and serious injury. No-one should attempt scuba diving without',
'training, certification, supervision and regular medical assessment. It is',
'also dangerous for trained scuba divers to exceed the limitations of their',
'training.')), style = 'font-size:85%'),
             p(i18n$t(paste(
               'This application will provide planification about dive',
               'profile and air consumption, without giving any warning',
               'if the activity would be dangerous or fatal.',
               'The author does not warrant that the application is',
               'correct in any sense whatsoever.'))
               , style = 'font-size:85%')
      )
    )
  )
}

