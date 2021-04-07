
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyDiveR application <img src="https://raw.githubusercontent.com/gowachin/DiveR/master/inst/images/DiveR_hex.png" alt="logo" align="right" height=200px/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![](https://img.shields.io/badge/devel%20version-0.2.0.0-blue.svg)](https://github.com/gowachin/shinyDiveR)
<!-- [![R build status](https://github.com/gowachin/shinyDiveR/workflows/R-CMD-check/badge.svg)](https://github.com/gowachin/shinyDiveR/actions) -->

<!-- badges: end -->

R package and shiny application for dive planification tools. It
represent a part of the [DiveR
package](https://github.com/gowachin/DiveR) and simplify it’s usage.

At this day, only mn90 tables models are coded for single, consecutive
or successive dives. This mean all profile are square ones and only
maximum depth and dive time are used to compute desaturation.

Intended to be used by french dive student, traduction of the lexic is
on it’s way. For this part the shiny app is written in english with
french translation possible in settings.

Feel free to participate to this project, it is designed to be open
source under a [CECILL-2
Licence](https://github.com/gowachin/DiveR/blob/master/LICENCE-CECILL-2.1.txt).
Any help in traduction or documentation is welcome (see end of README).

## Installation

### Dependencies

This package depend on the [DiveR
package](https://github.com/gowachin/DiveR). It can be installed with
the following code. *Note that this package also have dependencies
described on its own README.*

``` r
# install.packages("devtools")
devtools::install_github('https://github.com/gowachin/DiveR')
```

### Development version

You can install the development version of `{shinyDiveR}` from
[github](https://github.com/gowachin/shinyDiveR) with:

``` r
# install.packages("devtools")
devtools::install_github('https://github.com/gowachin/shinyDiveR')
# or 
# install.packages("remotes")
remotes::install_github("gowachin/shinyDiveR")
```

You can run the application on your PC with the following code :

``` r
# Simulation of a dive
library(shinyDiveR)
shinyDiveR::run_app(app_lang = "en")
```

Below is an example of the application :

<img src="https://raw.githubusercontent.com/gowachin/shinyDiveR/golem/inst/images/shinyDiveR.png" alt="screen" height=900px/>

<!-- You can install the released version of shinyDiveR from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("shinyDiveR")
```

 -->

## Disclaimer

This application is intended for use in education about scubadiving
planification and academic interest only. It is not designed for actual
use in scuba diving and underwater activity. It is emphatically not
suitable for use in actual diving. Scuba diving is a dangerous activity
with risks of death and serious injury. No-one should attempt scuba
diving without training, certification, supervision and regular medical
assessment. It is also dangerous for trained scuba divers to exceed the
limitations of their training.

This application will provide planinfication about dive profile and air
consumption, without giving any warning if the activity would be
dangerous or fatal. In doing so, it does not take account of safety
restrictions, other physical laws, or other important information.
Despite using diving table as base for computation, no output from this
application should be misconstrued as a diving table. The author does
not warrant that the application is correct in any sense whatsoever.
Even if correctly computed, the predictions of a theoretical physical
model may not be correct predictions.

## Want to help ?

Go check the [projects](https://github.com/gowachin/shinyDiveR/projects)
of this repository ! Any help is welcome and I accept all sort of ideas
for future project. The idea of this package is to learn about process
like desaturation models and turn them into algorithms. If you want to
use a specific model, join me and we can try to implement it !

Feel free to fork this, and use it. Any recommendation is welcome :)
