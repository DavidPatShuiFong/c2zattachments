
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{c2zattachments}`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of `{c2zattachments}` like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Run

You can launch the application by running:

``` r
c2zattachments::run_app()
```

or

``` r
# run test-version of app, with 'dummy' collection
c2zattachments::run_app(local = TRUE)
```

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2025-07-13 21:55:09 AEST"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading c2zattachments
#> ── R CMD check results ────────────────────────── c2zattachments 0.0.0.9000 ────
#> Duration: 32.1s
#> 
#> ❯ checking R files for non-ASCII characters ... WARNING
#>   Found the following file with non-ASCII characters:
#>     mod_zotero_account.R
#>   Portable packages must use only ASCII characters in their R code,
#>   except perhaps in comments.
#>   Use \uxxxx escapes for other characters.
#> 
#> ❯ checking installed package size ... NOTE
#>     installed size is  6.1Mb
#> 
#> ❯ checking for future file timestamps ... NOTE
#>   unable to verify current time
#> 
#> ❯ checking package subdirectories ... NOTE
#>   Problems with news in ‘NEWS.md’:
#>   No news entries found.
#> 
#> ❯ checking R code for possible problems ... NOTE
#>   mod_items_server : <anonymous>: no visible binding for global variable
#>     ‘parentItem’
#>   mod_items_server : <anonymous>: no visible binding for global variable
#>     ‘key’
#>   mod_items_server : <anonymous>: no visible binding for global variable
#>     ‘title’
#>   Undefined global functions or variables:
#>     key parentItem title
#>   Consider adding
#>     importFrom("graphics", "title")
#>   to your NAMESPACE file.
#> 
#> 0 errors ✔ | 1 warning ✖ | 4 notes ✖
#> Error: R CMD check found WARNINGs
```

``` r
covr::package_coverage()
#> c2zattachments Coverage: 90.14%
#> R/run_app.R: 0.00%
#> R/mod_items.R: 70.21%
#> R/mod_collections.R: 80.00%
#> R/mod_zotero_account.R: 94.52%
#> R/app_config.R: 100.00%
#> R/app_server.R: 100.00%
#> R/app_ui.R: 100.00%
#> R/golem_utils_server.R: 100.00%
#> R/golem_utils_ui.R: 100.00%
```
