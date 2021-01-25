FROM thinkr/rfull

COPY DiveR_*.tar.gz  /DiveR.tar.gz
COPY shinyDiveR_*.tar.gz  /shinyDiveR.tar.gz

RUN R -e "install.packages(c('shiny.i18n', 'shinyTime', 'shinyWidgets', 'rhandsontable', 'pkgload'))"
RUN R -e "install.packages('DiveR.tar.gz', repos = NULL, type = 'source')"
RUN R -e "install.packages('shinyDiveR.tar.gz', repos = NULL, type = 'source')"

COPY Rprofile.site /usr/local/lib/R/etc

EXPOSE 3838
CMD ["R", "-e shinyDiveR::run_app('fr')"]
