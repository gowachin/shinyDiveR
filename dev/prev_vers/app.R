# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

setwd(dir = 'shinyDiveR')
options(shiny.port = 7775)
pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
print(getwd())
shinyDiveR::run_app('en') # add parameters here (if any)
# setwd(dir = '../')
