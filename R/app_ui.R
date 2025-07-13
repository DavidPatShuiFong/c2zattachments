#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom bslib page_sidebar sidebar navset_card_underline nav_panel
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    page_sidebar(
      sidebar = sidebar(
        mod_zotero_account_ui("zotero_account_1")
      ),
      navset_card_underline(
        nav_panel(
          title = "Collections",
          mod_collections_ui("collections_1")
        ),
        nav_panel(
          title = "Items",
          mod_items_ui("items_1")
        )
      ),
      # golem::golem_welcome_page() # Remove this line to start building your UI
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "c2zattachments"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
