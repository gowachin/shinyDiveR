FROM rocker/r-ver:4.0.3
RUN apt-get update && apt-get install -y  libicu-dev make pandoc pandoc-citeproc && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.30")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.5.0")'
RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.6")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.1.0")'
RUN Rscript -e 'remotes::install_version("rhandsontable",upgrade="never", version = "0.3.7")'
RUN Rscript -e 'remotes::install_version("shinyWidgets",upgrade="never", version = "0.5.4")'
RUN Rscript -e 'remotes::install_version("lubridate",upgrade="never", version = "1.7.9.2")'
RUN Rscript -e 'remotes::install_version("shiny.i18n",upgrade="never", version = "0.2.0")'
RUN Rscript -e 'remotes::install_version("R.utils",upgrade="never", version = "2.10.1")'

RUN Rscript -e 'remotes::install_github("burgerga/shinyTime@eff185518ba95f146c64eceacd43fa7331bf7cdf")'
COPY DiveR_*.tar.gz  /DiveR.tar.gz
COPY shinyDiveR_*.tar.gz  /shinyDiveR.tar.gz
RUN R -e "install.packages('DiveR.tar.gz', repos = NULL, type = 'source')"
RUN R -e "install.packages('shinyDiveR.tar.gz', repos = NULL, type = 'source')"

RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
EXPOSE 3838
CMD R -e "options('shiny.port'=3838,shiny.host='0.0.0.0');shinyDiveR::run_app()"
