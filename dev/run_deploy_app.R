
# reinstall DiveR from github
devtools::install_github('https://github.com/gowachin/DiveR')

#deploy app
rsconnect::deployApp(appName = "shiny_DiveR")