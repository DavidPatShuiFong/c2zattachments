#' collections UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList h2
#' @importFrom reactable reactableOutput
mod_collections_ui <- function(id) {
  ns <- NS(id)
  tagList(
    reactableOutput(
      outputId = ns("collections")
    )
  )
}

#' collections Server Functions
#'
#' @noRd
#'
#' @importFrom reactable reactable renderReactable getReactableState
mod_collections_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    selected <- reactive(getReactableState("collections", "selected"))

    if (isTRUE(golem::get_golem_options("local"))) {
      # is starting with 'run_app(local = TRUE)' then load test data
      user.library <- readRDS(app_sys("user.library.example.RData"))
      collection_dataframe <- data.frame(
        Collection = user.library$collections$name,
        Key = user.library$collections$key
      )
    } else {
      collection_dataframe <- data.frame(
        Collection = character(),
        Key = character()
      )
    }

    output$collections <- renderReactable({
      reactable(collection_dataframe, selection = "multiple")
    })

  })
}

## To be copied in the UI
# mod_collections_ui("collections_1")

## To be copied in the server
# mod_collections_server("collections_1")
