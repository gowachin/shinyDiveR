library(shinyjs)
library(shiny)
library(shinydashboard)
my_username <- "test"
my_password <- "abc"
shinyApp(
  shinyUI(
    navbarPage( id = "navbar",
                useShinyjs(),
                tabPanel("A", uiOutput('loginpage')),
                tabPanel("B", uiOutput('page1'),
                         conditionalPanel(condition = "output.cond1==TRUE"))
    )
  ),
  shinyServer(function(input, output, session) {
    USER <- reactiveValues(Logged = FALSE)
    
    observe({
      if (USER$Logged == FALSE) {
        output$loginpage <- renderUI({
          box(title = "",textInput("userName", "Username"),
              passwordInput("passwd", "Password"),
              br(),
              actionButton("Login", "Log in"))})
        
        shinyjs::hide(selector = "#navbar li a[data-value=B]")
        
      } else if (USER$Logged == TRUE) {
        output$loginpage <- renderUI({fluidPage(
          box(title = "",br(),br(),actionButton("logout", "Logout"))
        )})
        
        shinyjs::show(selector = "#navbar li a[data-value=B]")
      }
      
    })
    
    observeEvent(input$Login, {
      Id.username <- which(my_username == input$userName)
      Id.password <- which(my_password == input$passwd)
      if(Id.username & Id.password) USER$Logged <<- TRUE
    })
    
    observeEvent(input$logout, {
      USER$Logged <- FALSE
    })
  }))