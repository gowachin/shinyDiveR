options(shiny.lang = 'fr') # change language 'fr' or 'en' supported by app
pkgload::load_all()
shiny::shinyApp(ui = app_ui(), server = app_server)