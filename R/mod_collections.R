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
#' @importFrom shiny reactive req validate need
#' @importFrom reactable reactable renderReactable getReactableState
mod_collections_server <- function(id, credentials){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    collection_dataframe <- reactive({
      if (isTRUE(golem::get_golem_options("local"))) {
        user.library <- readRDS(app_sys("user.library.example.RData"))
      } else {
        creds <- credentials()
        req(!is.na(creds$UserID), nchar(creds$APIKey) > 0)
        user.library <- tryCatch(
          c2z::Zotero(
            id = as.character(creds$UserID),
            api = creds$APIKey,
            library = TRUE,
            get.collections = TRUE,
            get.items = FALSE
          ),
          error = function(e) {
            validate(need(FALSE, paste("Zotero error:", conditionMessage(e))))
          }
        )
      }
      data.frame(
        Collection = user.library$collections$name,
        Key = user.library$collections$key
      )
    })

    selected_keys <- reactive({
      idx <- getReactableState("collections", "selected")
      if (is.null(idx)) return(NULL)
      collection_dataframe()[idx, "Key"]
    })

    output$collections <- renderReactable({
      if (!isTRUE(golem::get_golem_options("local"))) {
        creds <- credentials()
        validate(need(
          !is.na(creds$UserID) && nchar(creds$APIKey) > 0,
          "Enter your Zotero User ID and API key in the sidebar to load your collections."
        ))
      }
      reactable(collection_dataframe(), selection = "multiple")
    })

    return(selected_keys)
  })
}

## To be copied in the UI
# mod_collections_ui("collections_1")

## To be copied in the server
# mod_collections_server("collections_1")
