#' items UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList downloadButton
#' @importFrom reactable reactableOutput
mod_items_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(
      outputId = "DownloadAttachments",
      label = "Download Attachments"
    ),
    reactableOutput(
      outputId = ns("items")
    )
  )
}

#' items Server Functions
#'
#' @noRd
#'
#' @importFrom reactable renderReactable reactable colDef
#' @importFrom dplyr select left_join

mod_items_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    selected <- reactive(getReactableState("items", "selected"))

    if (isTRUE(golem::get_golem_options("local"))) {
      # is starting with 'run_app(local = TRUE)' then load test data
      user.library.collection <- readRDS(app_sys("user.library.collection.example.RData"))
      user.library.copy <- readRDS(app_sys("user.library.copy.example.RData"))
      item_dataframe <- data.frame(
        Key = user.library.copy$attachments$key,
        ParentKey = user.library.copy$attachments$parentItem,
        Title = user.library.copy$attachments |>
          select(parentItem) |>
          left_join(
            user.library.copy$items |> select(key, title),
            by = c("parentItem" = "key")
          ) |>
          select(title),
        Filename = user.library.copy$attachments$filename
      )
    } else {
      item_dataframe <- data.frame(
        Key = character(),
        ParentKey = character(),
        Title = character(),
        Filename = character()
      )
    }

    output$items <- renderReactable({
      reactable(
        item_dataframe,
        selection = "multiple",
        columns = list(
          Key = colDef(minWidth = 50),
          ParentKey = colDef(minWidth = 50)
        )
      )
    })

    # possible code to write all attachments in the user.library.copy list
    # for (i in seq_len(nrow(user.library.copy$attachments))) {
    #   content <- user.library.copy$attachments[i,]$file[[1]]$content
    #   filename <- user.library.copy$attachments[i,]$filename[[1]]
    #   writeBin(content, con = filename)
    # }

  })
}

## To be copied in the UI
# mod_items_ui("items_1")

## To be copied in the server
# mod_items_server("items_1")
