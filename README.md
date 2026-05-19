
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{c2zattachments}`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of `{c2zattachments}` like so:

``` r
# install.packages("pak")
pak::pak("github::DavidPatShuiFong/c2zattachments")
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
#> [1] "2026-05-17 21:34:08 AEST"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ══ Documenting ═════════════════════════════════════════════════════════════════
#> ℹ Installed roxygen2 version (7.3.3) doesn't match declared (7.3.2)
#> ✖ `check()` will not re-document this package.
#> ℹ Do you need to re-run `document()`?
#> ── R CMD check results ────────────────────────── c2zattachments 0.0.0.9000 ────
#> Duration: 36.6s
#> 
#> ❯ checking tests ...
#>   See below...
#> 
#> ❯ checking code files for non-ASCII characters ... WARNING
#>   Found the following file with non-ASCII characters:
#>     R/mod_zotero_account.R
#>   Portable packages must use only ASCII characters in their R code and
#>   NAMESPACE directives, except perhaps in comments.
#>   Use \uxxxx escapes for other characters.
#>   Function ‘tools::showNonASCIIfile’ can help in finding non-ASCII
#>   characters in files.
#> 
#> ❯ checking top-level files ... NOTE
#>   Non-standard file/directory found at top level:
#>     ‘CLAUDE.md’
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
#> ── Test failures ───────────────────────────────────────────────── testthat ────
#> 
#> > # This file is part of the standard setup for testthat.
#> > # It is recommended that you do not modify it.
#> > #
#> > # Where should you do additional test configuration?
#> > # Learn more about the roles of various files in:
#> > # * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
#> > # * https://testthat.r-lib.org/articles/special-files.html
#> > 
#> > library(testthat)
#> > library(c2zattachments)
#> > 
#> > test_check("c2zattachments")
#> Loading required package: shiny
#> Saving _problems/test-golem_utils_ui-99.R
#> Saving _problems/test-golem_utils_ui-105.R
#> [ FAIL 2 | WARN 0 | SKIP 1 | PASS 99 ]
#> 
#> ══ Skipped tests (1) ═══════════════════════════════════════════════════════════
#> • rlang_is_interactive() is not TRUE (1): 'test-golem-recommended.R:72:5'
#> 
#> ══ Failed tests ════════════════════════════════════════════════════════════════
#> ── Failure ('test-golem_utils_ui.R:96:3'): Test undisplay works ────────────────
#> Expected `as.character(b)` to equal "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\">go</button>".
#> Differences:
#> actual vs expected
#> - "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\"><span class=\"action-label\">go</span></button>"
#> + "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\">go</button>"
#> 
#> ── Failure ('test-golem_utils_ui.R:102:3'): Test undisplay works ───────────────
#> Expected `as.character(b_undisplay)` to equal "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\">go</button>".
#> Differences:
#> actual vs expected
#> - "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\"><span class=\"action-label\">go</span></button>"
#> + "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\">go</button>"
#> 
#> 
#> [ FAIL 2 | WARN 0 | SKIP 1 | PASS 99 ]
#> Error:
#> ! Test failures.
#> Execution halted
#> 
#> 1 error ✖ | 1 warning ✖ | 3 notes ✖
#> Error:
#> ! R CMD check found ERRORs
```

``` r
covr::package_coverage()
#> Error:
#> ! Failure in `/tmp/Rtmp46wNTp/R_LIBSc3154bf766f/c2zattachments/c2zattachments-tests/testthat.Rout.fail`
#> ───
#> Expected `as.character(b_undisplay)` to equal "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\">go</button>".
#> Differences:
#> actual vs expected
#> - "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\"><span class=\"action-label\">go</span></button>"
#> + "<button id=\"go_filter\" type=\"button\" class=\"btn btn-default action-button\" style=\"display: none;\">go</button>"
#> 
#> 
#> [ FAIL 2 | WARN 0 | SKIP 1 | PASS 99 ]
#> Error:
#> ! Test failures.
#> Execution halted
```
