#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny shiny.i18n
#' @importFrom shinyWidgets setSliderColor pickerInput
#' @noRd
app_ui <- function(request) {
  #### options ####
  language <- golem::get_golem_options("app_lang")
  i18n <- shinyDiveR::i18n
  i18n$set_translation_language(language)
  
  maxd <- golem::get_golem_options("app_maxd")
  ############### ####
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      #### Set language and choice ####
      shiny.i18n::usei18n(i18n),
      div(style = "float: right;", tags$style(".chooselang {width: 80px}"),
          div(class = "chooselang",
              pickerInput(
            inputId = 'selected_language',
            label = "Change language", 
            choices = i18n$get_languages(), 
            selected = language,
            choicesOpt = list(
              content = mapply(i18n$get_languages(), shinyDiveR::flags, 
                               FUN = function(country, flagUrl) {
                HTML(paste(tags$img(src=flagUrl, width=20, height=15), country))
              }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
            )
          )
          ),
      ),
      
      #### UI general part ####
      # Hide slider border value
      tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max {
            visibility: hidden !important; }'))),
      # Slider colors 
      shinyWidgets::setSliderColor(c(rep(c("#2a8dd2", "#cc4f1c"),2) #,
                                     # "#BDBCBB", "#87F7FF", "#2a8dd2",
                                     # "#87F7FF", "#cc4f1c"
                                     ), 
                                   c(1, 2, 3, 4 )), #5, 6, 7, 8, 9)),
      
      #### TITLE ####
      # checkboxInput("help", i18n$t("hepl"), FALSE),
      titlePanel(
        title=div(img(src="www/DiveR_hex.png", height = 70),
                  i18n$t("Dive planification tool")), 
        windowTitle = "DiveR"),
      # hr(style = "border-color: #766812;"),
      
      #### Inside ####
      tabsetPanel(
        type = "pills",
        #### Dive profile panel ####
        tabPanel(p(i18n$t("Dive Profile"),icon("water")),
                 # i18n$t("Dive Profile"),
                 #mod_squareUI('square', i18n, maxd),
                 mod_01_squareUI_ui('square', i18n, maxd),
                 ## invisible panel
                 conditionalPanel(
                   condition = "false",
                   checkboxInput("sec_plot", "plot second dive", FALSE)
                 )
        ),
        tabPanel(p(i18n$t("Consumption"),icon("lungs")),
                 mod_02_consoUI_ui('conso', i18n)
        )
      ),
      hr(style = "border-color: #766812;"),
      
      #### End of page ####
      fluidRow(
        column(5, # tags$a(href = "https://www.cteeter.ca", 'Chris Teeter', target = '_blank')
               p("App created by Maxime Jaunatre in January 2021", HTML("&bull;"),
                 "Find the code on Github:", 
                 tags$a(href = "https://github.com/gowachin/shinyDiveR", 
                        tags$i(class = 'fa fa-github', style = 'color:#bd971e'), 
                        target = '_blank'), style = "font-size: 85%"),
               p("Have a question? Spot an error? Report an issue on Github or send an email ", 
                 tags$a(href = "mailto:maxime.jaunatre@yahoo.fr", 
                        tags$i(class = 'fa fa-envelope', style = 'color:#bd971e'),
                        target = '_blank'), style = "font-size: 85%"),
               p(tags$em("Last updated: Februrary 2021"), style = 'font-size:75%')),
        
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
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(ext = 'png'),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinyDiveR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

