# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Package Does

`c2zattachments` is a Golem-based R Shiny app that lets users browse and download attachments from a Zotero library. It wraps the `c2z` library (by Øystein Olav Skaar) and presents a two-tab interface: one for selecting Zotero collections, one for selecting and downloading items/attachments.

## Common Commands

```r
# Load package for interactive development
devtools::load_all()

# Run the app (requires live Zotero credentials)
c2zattachments::run_app()

# Run with bundled example data instead of live API
c2zattachments::run_app(local = TRUE)

# Run all tests
devtools::test()

# Run a single test file
testthat::test_file("tests/testthat/test-mod_items.R")

# Check the package (includes R CMD check)
devtools::check()

# Document (regenerates NAMESPACE and man/)
devtools::document()
```

## Architecture

The package follows the standard Golem pattern:

- **`R/run_app.R`** — sole exported function; entry point for users
- **`R/app_ui.R`** / **`R/app_server.R`** — top-level UI and server; server wires three modules together
- **`R/mod_zotero_account.R`** — sidebar module; returns a reactive dataframe `{UserID, UserPassword}`; auto-reads `ZOTERO_USER` and `ZOTERO_API` env vars
- **`R/mod_collections.R`** — "Collections" tab; displays a `reactable` of available Zotero collections with multi-select
- **`R/mod_items.R`** — "Items" tab; joins attachment rows to parent item titles via `dplyr::left_join`; has a download button (export not yet implemented)

Golem utility files (`golem_utils_server.R`, `golem_utils_ui.R`) provide reactive helpers and HTML tag utilities — these are standard Golem scaffolding and rarely need editing.

## Local/Test Mode

Modules check for a `local` golem option (`getOption("golem.app.prod")` is `FALSE` by default). When `run_app(local = TRUE)` is passed, modules load bundled example `.RData` files from `inst/` instead of calling the live Zotero API:

- `inst/user.library.example.RData` — collections list
- `inst/user.library.collection.example.RData` — collection items
- `inst/user.library.copy.example.RData` — full library with attachments (~6 MB)

## Known Warnings (R CMD check)

- Non-ASCII character in `mod_zotero_account.R` (the "Ø" in the author's name)
- Undeclared global variables in `mod_items.R`: `parentItem`, `key`, `title` — these are `dplyr` tidy-eval column references
