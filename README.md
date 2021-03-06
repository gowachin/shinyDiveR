
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyDiveR application <img src="https://raw.githubusercontent.com/gowachin/DiveR/master/inst/images/DiveR_hex.png" alt="logo" align="right" height=200px/>

<!-- badges: start -->
<!-- [![R build status](https://github.com/gowachin/shinyDiveR/workflows/R-CMD-check/badge.svg)](https://github.com/gowachin/shinyDiveR/actions) -->

[![](https://img.shields.io/badge/devel%20version-0.2.0.0-blue.svg)](https://github.com/gowachin/shinyDiveR)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

R package and shiny application for dive planification tools. It
contains functions and methods to represent dive curves, desaturation
time and gas consumption. At this day, only mn90 tables models are coded
for single, consecutive or successive dives. This mean all profile are
square ones and only maximum depth and dive time are used to compute
desaturation.

**The shiny application is not yet in production.**

Future parts are work in progress, like more precise planification setup
with different depths and time input. Desaturation planification with
other models are also planned along with maybe other gas than air
supported for consumption

Intended to be used by french dive student, traduction of the lexic is
on it’s way. For this part the shiny app is written in english with
french translation possible in settings.

## Installation

You can install the development version of `{shinyDiveR}` from
[github](https://github.com/gowachin/shinyDiveR) with:

``` r
# install.packages("devtools")
devtools::install_github('https://github.com/gowachin/shinyDiveR')
# or 
# install.packages("remotes")
remotes::install_github("gowachin/shinyDiveR")
```

Below is an exemple of the application :

<img src="https://raw.githubusercontent.com/gowachin/shinyDiveR/golem/inst/images/shinyDiveR.png" alt="screen" height=900px/>

<!-- You can install the released version of shinyDiveR from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("shinyDiveR")
```

## Example

This is a basic example which shows you how to solve a common problem:


```r
library(shinyDiveR)
## basic example code
```


You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/master/examples>. -->

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

Go check the projects of this repository !

Feel free to fork this, and use it. Any recommendation is welcome :)
