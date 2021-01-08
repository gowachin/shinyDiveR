.rs.api.documentSaveAll() # ferme et sauvegarde tous les fichiers ouvert
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), 
                        detach, character.only = TRUE, unload = TRUE))# detache tous les packages
rm(list = ls(all.names = TRUE))# vide l'environneent
devtools::document('.') # genere NAMESPACE et man
devtools::load_all('.') # charge le package
getOption( "shiny.lang")
options(shiny.lang = 'en') # change language 'fr' or 'en' supported by app
options(app.prod = T) # TRUE = production mode, FALSE = development mode
shiny::runApp('inst/app') # lance l'application

