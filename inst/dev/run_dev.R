.rs.api.documentSaveAll() # ferme et sauvegarde tous les fichiers ouvert
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), 
                        detach, character.only = TRUE, unload = TRUE))# detache tous les packages
rm(list = ls(all.names = TRUE))# vide l'environneent
devtools::document('.') # genere NAMESPACE et man
devtools::load_all('.') # charge le package
Sys.getenv('LANG')
Sys.setenv(LANG = "en") # change language 'fr' or 'en' supported by app
options(app.prod = FALSE) # TRUE = production mode, FALSE = development mode
options(shiny.loc = "")
shiny::runApp('inst/app') # lance l'application
Sys.setenv(LANG = "fr_FR.UTF-8") 

