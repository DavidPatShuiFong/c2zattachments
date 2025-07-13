#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # Zotero API user ID and key
  mod_zotero_account_server("zotero_account_1")
  # choose from list of collections
  mod_collections_server("collections_1")
  # choose from list of items within selected collections, download attachments
  mod_items_server("items_1")
}
