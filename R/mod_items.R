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
      outputId = ns("DownloadAttachments"),
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
#' @importFrom shiny reactive req validate need downloadHandler
#' @importFrom reactable renderReactable reactable colDef getReactableState
#' @importFrom dplyr select left_join filter
#' @importFrom httr GET add_headers status_code content

mod_items_server <- function(id, credentials, selected_collections){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    user_library <- reactive({
      if (isTRUE(golem::get_golem_options("local"))) {
        readRDS(app_sys("user.library.copy.example.RData"))
      } else {
        creds <- credentials()
        keys <- selected_collections()
        req(!is.na(creds$UserID), nchar(creds$APIKey) > 0, length(keys) > 0)
        results_list <- lapply(keys, function(key) {
          zotero <- tryCatch(
            c2z::Zotero(
              id = as.character(creds$UserID),
              api = creds$APIKey,
              collection.key = key,
              get.collections = FALSE,
              get.items = TRUE
            ),
            error = function(e) {
              validate(need(FALSE, paste("Zotero error:", conditionMessage(e))))
            }
          )
          results <- tryCatch(
            c2z::ZoteroLibrary(zotero),
            error = function(e) {
              validate(need(FALSE, paste("Zotero error:", conditionMessage(e))))
            }
          )
          results$results
        })
        dplyr::bind_rows(results_list)
      }
    })

    item_dataframe <- reactive({
      lib <- user_library()
      attachments <- lib |>
        dplyr::filter(itemType == "attachment") |>
        dplyr::filter(contentType == "application/pdf") |>
        dplyr::select(key, parentItem, filename) |>
        dplyr::left_join(
          lib |> dplyr::select(key, title),
          # replace the attachment title with the 'parent' title
          by = dplyr::join_by(parentItem == key)
        )
      if (is.null(attachments) || nrow(attachments) == 0) {
        return(data.frame(
          Key = character(),
          ParentKey = character(),
          Title = character(),
          Filename = character()
        ))
      }
      data.frame(
        Key = attachments$key,
        ParentKey = attachments$parentItem,
        Title = attachments$title,
        Filename = attachments$filename
      )
    })

    selected <- reactive(getReactableState("items", "selected"))

    output$items <- renderReactable({
      if (!isTRUE(golem::get_golem_options("local"))) {
        creds <- credentials()
        validate(
          need(
            !is.na(creds$UserID) && nchar(creds$APIKey) > 0,
            "Enter your Zotero credentials in the sidebar."
          ),
          need(
            length(selected_collections()) > 0,
            "Select one or more collections in the Collections tab to load items."
          )
        )
      }
      reactable(
        item_dataframe(),
        selection = "multiple",
        columns = list(
          Key = colDef(minWidth = 50),
          ParentKey = colDef(minWidth = 50)
        )
      )
    })

    output$DownloadAttachments <- downloadHandler(
      filename = function() "attachments.zip",
      content = function(file) {
        idx <- selected()
        req(!is.null(idx), length(idx) > 0)

        rows <- item_dataframe()[idx, ]

        tmp_dir <- tempfile()
        dir.create(tmp_dir)
        on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

        if (isTRUE(golem::get_golem_options("local"))) {
          lib_att <- user_library()$attachments
          keys <- rows$Key
          filenames <- rows$Filename
          for (i in seq_along(keys)) {
            row_match <- which(lib_att$key == keys[[i]])
            if (length(row_match) == 0) next
            writeBin(
              lib_att$file[[row_match]]$content,
              file.path(tmp_dir, filenames[[i]])
            )
          }
        } else {
          creds <- credentials()
          base_url <- paste0(
            "https://api.zotero.org/users/",
            as.character(creds$UserID),
            "/items/"
          )
          invisible(apply(rows, 1, function(row) {
            response <- GET(
              paste0(base_url, row[["Key"]], "/file"),
              add_headers("Zotero-API-Key" = creds$APIKey)
            )
            if (status_code(response) == 200) {
              writeBin(
                content(response, as = "raw"),
                file.path(tmp_dir, row[["Filename"]])
              )
            }
          }))
        }

        old_wd <- setwd(tmp_dir)
        on.exit(setwd(old_wd), add = TRUE)
        utils::zip(file, files = list.files(tmp_dir))
      }
    )

  })
}

## To be copied in the UI
# mod_items_ui("items_1")

## To be copied in the server
# mod_items_server("items_1")
